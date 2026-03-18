
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
// Latihan C: Tambahkan field di title di JSON, lalu update name atau field baru).
  final String? title;

  const HeroRpg({
    required this.name,
    required this.job,
    required this.baseHp,
    required this.baseMp,
    this.title,
  });

  // Named constructor (contoh)
  const HeroRpg.novice(String name)
      : name = name,
        job = Job.warrior,
        baseHp = 50,
        baseMp = 20,
        title = null;

  // Factory: bikin object dari Map/JSON
  factory HeroRpg.fromJson(Map<String, dynamic> json) {
    final jobString = (json['job'] as String?) ?? 'warrior';

    final job = switch (jobString) {
      'mage' => Job.mage,
      'archer' => Job.archer,
      _ => Job.warrior,
    };

    // Latihan C: Cek field title, kalau ada pakai itu, kalau tidak ada pakai name, kalau name juga tidak ada, pakai 'Unknown'
    final rawName = (json['name'] as String?) ?? json['title'] as String? ?? 'Unknown';

    return HeroRpg(
      name: rawName,
      job: job,
      baseHp: (json['baseHp'] as int?) ?? 50,
      baseMp: (json['baseMp'] as int?) ?? 20,
      title: json['title'] as String?,
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

  @override
  String toString() {
    return 'HeroRpg(name: $name, job: ${job.label}, hp: $baseHp, mp: $baseMp)';
  }
}

// Tugas 3: Buat extension untuk String: toTitleCase() lalu pakai untuk nama monster
extension StringCaseExtension on String {
  String toSnakeCase() {
    return replaceAll(' ', '_').toLowerCase();
  }
}