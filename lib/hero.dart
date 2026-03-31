// ignore_for_file: avoid_print

class Hero {
  final String name;
  final int hp;
  final Map<String, int> inventory;

  const Hero({required this.name, required this.hp, required this.inventory});

  Hero copyWith({String? name, int? hp, Map<String, int>? inventory}) {
    return Hero(
      name: name ?? this.name,
      hp: hp ?? this.hp,
      inventory: inventory ?? this.inventory,
    );
  }

  void showInventory() {
    if (inventory.isEmpty) {
      print('Inventory kosong.');
      return;
    }
    print('=== Inventory ===');
    inventory.forEach((item, jumlah) {
      print('- $item: $jumlah');
    });
    print('=================');
  }
}
