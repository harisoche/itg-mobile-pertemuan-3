enum Job { warrior, mage, archer }

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

  // No 2: Inventory
  final Map<String, int> inventory;

  const HeroRpg({
    required this.name,
    required this.title,
    required this.job,
    required this.baseHp,
    required this.baseMp,
    this.inventory = const {},
  });

  const HeroRpg.novice(String name)
      : name = name,
        title = 'Novice',
        job = Job.warrior,
        baseHp = 50,
        baseMp = 20,
        inventory = const {'Potion': 1};

  factory HeroRpg.fromJson(Map<String, dynamic> json) {
    final jobString = (json['job'] as String?) ?? 'warrior';

    final job = switch (jobString) {
      'mage' => Job.mage,
      'archer' => Job.archer,
      _ => Job.warrior,
    };

    return HeroRpg(
      name: (json['name'] as String?) ?? 'Unknown',
      title: (json['title'] as String?) ?? 'Rookie',
      job: job,
      baseHp: (json['baseHp'] as int?) ?? 50,
      baseMp: (json['baseMp'] as int?) ?? 20,
      inventory: Map<String, int>.from(json['inventory'] ?? {}),
    );
  }

  // 1: Heal
  HeroRpg heal() {
    return HeroRpg(
      name: name,
      title: title,
      job: job,
      baseHp: baseHp + 10,
      baseMp: baseMp,
      inventory: inventory,
    );
  }

  // 2: Add item
  HeroRpg addItem(String item) {
    final newInventory = Map<String, int>.from(inventory);
    newInventory[item] = (newInventory[item] ?? 0) + 1;

    return HeroRpg(
      name: name,
      title: title,
      job: job,
      baseHp: baseHp,
      baseMp: baseMp,
      inventory: newInventory,
    );
  }

  int get power {
    return switch (job) {
      Job.warrior => baseHp + (baseMp ~/ 4),
      Job.mage => baseMp + (baseHp ~/ 4),
      Job.archer => (baseHp + baseMp) ~/ 2,
    };
  }

  HeroRpg levelUp(int times) {
    return HeroRpg(
      name: name,
      title: title,
      job: job,
      baseHp: baseHp + 10 * times,
      baseMp: baseMp + 8 * times,
      inventory: inventory,
    );
  }

  @override
  String toString() {
    return 'HeroRpg(name: $name, job: ${job.label}, hp: $baseHp, mp: $baseMp, inventory: $inventory)';
  }
}