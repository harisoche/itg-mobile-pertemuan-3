enum Job { warrior, mage, archer }

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

extension StringExtension on String {
  String toTitleCase() {
    if (this.isEmpty) return this;
    return this.split(' ')
        .map((word) => word.isNotEmpty 
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' 
            : '')
        .join(' ');
  }
}

class HeroRpg {
  final String name;
  final String? title;
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

  // Named constructor (contoh)
  const HeroRpg.novice(String name)
      : name = name,
        title = 'Novice',
        job = Job.warrior,
        baseHp = 50,
        baseMp = 20;

  HeroRpg heal() {
    print("Mengobati $name... HP bertambah +10!");
    return HeroRpg(
      name: name,
      title: title,
      job: job,
      baseHp: baseHp + 10, // Tambah HP 10
      baseMp: baseMp,
    );
  }


  // Factory: bikin object dari Map/JSON
  factory HeroRpg.fromJson(Map<String, dynamic> json) {
    final jobString = (json['job'] as String?) ?? 'warrior';

    final job = switch (jobString) {
      'mage' => Job.mage,
      'archer' => Job.archer,
      _ => Job.warrior,
    };

    return HeroRpg(
      name: (json['name'] as String?) ?? 'Unknown',
      title: json['title'] as String?,
      job: job,
      baseHp: (json['baseHp'] as int?) ?? 50,
      baseMp: (json['baseMp'] as int?) ?? 20,
    );
  }

  // Getter: property hasil hitungan
  int get power {
    return switch (job) {
      Job.warrior => baseHp + (baseMp ~/ 4),
      Job.mage => baseMp + (baseHp ~/ 4),
      Job.archer => (baseHp + baseMp) ~/ 2,
    };
  }

  // Method: mengembalikan object baru (immutable style)
  HeroRpg levelUp(int times) {
    return HeroRpg(
      name: name,
      title: title,
      job: job,
      baseHp: baseHp + 10 * times,
      baseMp: baseMp + 8 * times,
    );
  }

  @override
  String toString() {
    return 'HeroRpg(name: ${name.toTitleCase()}, job: ${job.label}, hp: $baseHp, mp: $baseMp)';
  }
}