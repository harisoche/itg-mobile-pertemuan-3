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

  // =============================
  // ✅ TAMBAHAN: INVENTORY
  // =============================
  final Map<String, int> inventory;

  const HeroRpg({
    required this.name,
    required this.job,
    required this.baseHp,
    required this.baseMp,
    this.inventory = const {}, // default kosong
  });

  // Named constructor (contoh)
  const HeroRpg.novice(String name)
    : name = name,
      job = Job.warrior,
      baseHp = 50,
      baseMp = 20,
      inventory = const {}; // ✅ TAMBAHAN

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
      inventory: const {}, // ✅ TAMBAHAN
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

  // Method: level up (immutable)
  HeroRpg levelUp(int times) {
    return HeroRpg(
      name: name,
      job: job,
      baseHp: baseHp + 10 * times,
      baseMp: baseMp + 8 * times,
      inventory: inventory, // ✅ TAMBAHAN (biar tidak hilang)
    );
  }

  // =============================
  // ✅ TAMBAHAN: HEAL (IMMUTABLE)
  // =============================
  HeroRpg heal() {
    return HeroRpg(
      name: name,
      job: job,
      baseHp: baseHp + 10,
      baseMp: baseMp,
      inventory: inventory,
    );
  }

  // =============================
  // ✅ TAMBAHAN: ADD ITEM
  // =============================
  HeroRpg addItem(String item) {
    final newInventory = Map<String, int>.from(inventory);

    if (newInventory.containsKey(item)) {
      newInventory[item] = newInventory[item]! + 1;
    } else {
      newInventory[item] = 1;
    }

    return HeroRpg(
      name: name,
      job: job,
      baseHp: baseHp,
      baseMp: baseMp,
      inventory: newInventory,
    );
  }

  @override
  String toString() {
    return 'HeroRpg(name: $name, job: ${job.label}, hp: $baseHp, mp: $baseMp)';
  }
}
