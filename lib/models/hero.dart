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

class HeroRpg {
  final String name;
  final Job job;
  final int baseHp;
  final int baseMp;

  const HeroRpg({
    required this.name,
    required this.job,
    required this.baseHp,
    required this.baseMp,
  });

  // Named constructor (contoh)
  const HeroRpg.novice(String name)
      : name = name,
        job = Job.warrior,
        baseHp = 50,
        baseMp = 20;

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
      job: job,
      baseHp: baseHp + 10 * times,
      baseMp: baseMp + 8 * times,
    );
  }

  HeroRpg heal(int amount) {
    return HeroRpg(
      name: name,
      job: job,
      baseHp: baseHp + amount,
      baseMp: baseMp,
    );
  }

  @override
  String toString() {
    return 'HeroRpg(name: $name, job: ${job.label}, hp: $baseHp, mp: $baseMp)';
  }
}