enum Job { warrior, mage, archer }

// PR NO 3: Extension untuk String → toTitleCase()
extension StringExt on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

extension JobLabel on Job {
  String get label {
    switch (this) {
      case Job.warrior:
        return 'Warrior';
      case Job.mage:
        return 'Mage';
      case Job.archer:
        return 'Archer';
    }
  }
}

class HeroRpg {
  final String name;
  final String title;
  final Job job;
  final int baseHp;
  final int baseMp;

  const HeroRpg({
    required this.name,
    required this.title,
    required this.job,
    required this.baseHp,
    required this.baseMp,
  });

  // Named constructor
  const HeroRpg.novice(String name)
      : name = name,
        title = 'Novice',
        job = Job.warrior,
        baseHp = 50,
        baseMp = 20;

  // Factory: buat object dari Map/JSON
  factory HeroRpg.fromJson(Map<String, dynamic> json) {
    final jobString = (json['job'] as String?) ?? 'warrior';
    final job = switch (jobString) {
      'mage'   => Job.mage,
      'archer' => Job.archer,
      _        => Job.warrior,
    };
    return HeroRpg(
      name:   (json['name']   as String?) ?? 'Unknown',
      title:  (json['title']  as String?) ?? 'Rookie',
      job:    job,
      baseHp: (json['baseHp'] as int?)    ?? 50,
      baseMp: (json['baseMp'] as int?)    ?? 20,
    );
  }

  // PR NO 1: Heal — immutable, return HeroRpg BARU dengan HP +10
  HeroRpg heal() {
    return HeroRpg(
      name:   name,
      title:  title,
      job:    job,
      baseHp: baseHp + 10, // tidak mengubah object ini, return object baru
      baseMp: baseMp,
    );
  }

  // Getter: kalkulasi power berdasarkan job
  int get power {
    return switch (job) {
      Job.warrior => baseHp + (baseMp ~/ 4),
      Job.mage    => baseMp + (baseHp ~/ 4),
      Job.archer  => (baseHp + baseMp) ~/ 2,
    };
  }

  // Method levelUp: immutable style
  HeroRpg levelUp(int times) {
    return HeroRpg(
      name:   name,
      title:  title,
      job:    job,
      baseHp: baseHp + 10 * times,
      baseMp: baseMp + 8  * times,
    );
  }

  @override
  String toString() {
    return 'HeroRpg(name: $name, title: $title, job: ${job.label}, hp: $baseHp, mp: $baseMp)';
  }
}