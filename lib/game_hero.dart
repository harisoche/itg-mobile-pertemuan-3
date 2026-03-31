class GameHero {
  final String name;
  final int hp;
  final int maxHp;
  final Map<String, int> inventory;

  const GameHero({
    required this.name,
    required this.hp,
    required this.maxHp,
    this.inventory = const {},
  });

  GameHero heal() {
    int newHp = (hp + 10).clamp(0, maxHp);
    return GameHero(
      name: name,
      hp: newHp,
      maxHp: maxHp,
      inventory: inventory,
    );
  }

  String showInventory() {
    if (inventory.isEmpty) return 'Inventory kosong';
    String result = '🎒 Inventory:\n';
    inventory.forEach((item, jumlah) {
      result += '  - $item : $jumlah\n';
    });
    return result;
  }

  @override
  String toString() => '🧙 $name | HP: $hp/$maxHp';
}