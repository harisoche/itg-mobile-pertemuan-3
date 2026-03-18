import 'dart:math';
import 'package:flutter/material.dart';
import '../models/hero.dart';

class DartLabPage extends StatefulWidget {
  const DartLabPage({super.key});

  @override
  State<DartLabPage> createState() => _DartLabPageState();
}

class _DartLabPageState extends State<DartLabPage> {
  String output = 'Tekan tombol untuk melihat demo Dart!';

  final Map<String, int> inventory = {};

  void show(String text) {
    setState(() => output = text);
  }

  // 1) VAR / FINAL / CONST + NULL SAFETY
  void demoVariablesAndNullSafety() {
    var name = 'Rani';
    final hp = 100;
    const maxLevel = 10;

    String? guild;

    final guildName = guild ?? 'No Guild';
    final guildUpper = guildName.toUpperCase();

    final List<int?> potions = [1, null, 3];

    show([
      '=== Variables + Null Safety ===',
      'name (var): $name',
      'hp (final): $hp',
      'maxLevel (const): $maxLevel',
      'guild: $guild',
      'guildName (??): $guildName',
      'guildUpper: $guildUpper',
      'potions: $potions',
    ].join('\n'));
  }

  // 2) FUNCTIONS
  void demoFunctions() {
    int add(int a, int b) => a + b;

    String greet(String name, [String? title]) {
      if (title == null) return 'Halo $name!';
      return 'Halo $title $name!';
    }

    String castSpell({required String spell, int manaCost = 10}) {
      return '🪄 Cast $spell (mana -$manaCost)';
    }

    int applyTwice(int value, int Function(int) f) {
      return f(f(value));
    }

    show([
      '=== Functions ===',
      'add(2,3) => ${add(2, 3)}',
      greet('Rani'),
      greet('Rani', 'Mage'),
      castSpell(spell: 'Fireball'),
      'applyTwice(3, x*2) => ${applyTwice(3, (x) => x * 2)}',
    ].join('\n'));
  }

  // 3) COLLECTION
  void demoCollections() {
    final rng = Random();

    final monsters = ['Slime', 'Goblin', 'Wolf', 'Dragon'];

    final strongNames = monsters.where((m) => m.length > 4).toList();
    final labeled = monsters.map((m) => 'Monster: $m').toList();

    final hits = List.generate(3, (_) => rng.nextInt(10) + 1);
    final totalDamage = hits.fold<int>(0, (sum, x) => sum + x);

    show([
      '=== Collections ===',
      'monsters: $monsters',
      'where(length>4): $strongNames',
      'map(label): $labeled',
      'hits: $hits',
      'totalDamage: $totalDamage',
    ].join('\n'));
  }

  // 4) CLASS
  void demoClasses() {
    final hero = HeroRpg(name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);
    final leveled = hero.levelUp(3);

    show([
      '=== Class ===',
      'hero: $hero',
      'power: ${hero.power}',
      'leveled: $leveled',
    ].join('\n'));
  }

  // 5) ASYNC/AWAIT 
  Future<void> demoAsyncAwait() async {
    show('⏳ Mengambil quest dari server...');

    try {
      final quest = await fetchQuest();
      show([
        '=== Async/Await ===',
        'Quest didapat!',
        '• $quest',
      ].join('\n'));
    } catch (e) {
      show('❌ Gagal ambil quest: $e');
    }
  }

  
  Future<String> fetchQuest() async {
    await Future.delayed(const Duration(seconds: 1));

    final rng = Random();
    if (rng.nextInt(5) == 0) {
      throw Exception('Server sedang tidur 😴');
    }

    const quests = [
      'Kalahkan 3 Goblin',
      'Cari 2 Potion',
      'Lindungi desa dari Wolf',
      'Temukan Gem tersembunyi',
    ];

    return quests[rng.nextInt(quests.length)];
  }

  //  RANDOM LOOT 
  void randomLoot() {
    final lootItems = ['gold', 'potion', 'gem', 'scroll'];

    final loot = lootItems[Random().nextInt(lootItems.length)];
    addItem(loot);

    show([
      '=== 🎁 Random Loot ===',
      'Kamu mendapatkan: $loot',
      '',
      'Inventory:',
      formatInventory(),
    ].join('\n'));
  }

  //  ATTACK
  void attackMonster() {
    final monsters = ['goblin', 'slime', 'wolf'];

    final monster = monsters[Random().nextInt(monsters.length)];
    final damage = Random().nextInt(10) + 1;

    show("⚔️ Attack ${monster.toTitleCase()}, damage: $damage");
  }

  //  HEAL
  void healHero() {
    final hero = HeroRpg(name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);
    final healed = hero.levelUp(1);

    show("❤️ Heal!\nHP sekarang: ${healed.baseHp}");
  }

  //  SHOP
  Future<void> loadShop() async {
    show("⏳ Loading shop...");
    final items = await fetchShopItems();

    show("🛒 Shop:\n${items.join('\n')}");
  }

  Future<List<String>> fetchShopItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['sword', 'shield', 'armor'];
  }

  //  INVENTORY
  void addItem(String item) {
    inventory[item] = (inventory[item] ?? 0) + 1;
  }

  String formatInventory() {
    if (inventory.isEmpty) return "Inventory kosong";

    return inventory.entries
        .map((e) => "- ${e.key}: ${e.value}")
        .join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Lab RPG'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: demoVariablesAndNullSafety,
                  icon: const Icon(Icons.bolt),
                  label: const Text('Variables + Null'),
                ),
                ElevatedButton.icon(
                  onPressed: demoFunctions,
                  icon: const Icon(Icons.functions),
                  label: const Text('Functions'),
                ),
                ElevatedButton.icon(
                  onPressed: demoCollections,
                  icon: const Icon(Icons.list_alt),
                  label: const Text('Collections'),
                ),
                ElevatedButton.icon(
                  onPressed: demoClasses,
                  icon: const Icon(Icons.shield),
                  label: const Text('Class + Enum'),
                ),
                ElevatedButton.icon(
                  onPressed: demoAsyncAwait,
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('Async/Await'),
                ),
                ElevatedButton(
                  onPressed: randomLoot,
                  child: const Text('🎁 Random Loot'),
                ),
                ElevatedButton(
                  onPressed: attackMonster,
                  child: const Text('⚔️ Attack'),
                ),
                ElevatedButton(
                  onPressed: healHero,
                  child: const Text('❤️ Heal'),
                ),
                ElevatedButton(
                  onPressed: loadShop,
                  child: const Text('🛒 Shop'),
                ),
                OutlinedButton.icon(
                  onPressed: () => show('Tekan tombol untuk melihat demo Dart!'),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    output,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//  EXTENSION
extension TitleCase on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}