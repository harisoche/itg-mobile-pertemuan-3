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

  void show(String text) {
    setState(() => output = text);
  }

  void getRandomLoot() {
    List<String> lootList = ['gold', 'potion', 'gem', 'scroll'];
    int randomIndex = Random().nextInt(lootList.length);
    String dapetLoot = lootList[randomIndex];

    show([
      '=== Random Loot ===',
      'Membuka peti harta karun...',
      'Selamat! Kamu mendapatkan: $dapetLoot 🎉',
    ].join('\n'));
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
      'guildUpper (?.): $guildUpper',
      'potions: $potions',
    ].join('\n'));
  }

  // 2) FUNCTION
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

    String attack(String monster, {int bonus = 0}) {
      int damage = Random().nextInt(10) + 1 + bonus;
      return '⚔️ Attack $monster, damage: $damage';
    }

    show([
      '=== Functions ===',
      'add(2,3) => ${add(2, 3)}',
      'greet("Rani") => ${greet('Rani')}',
      'castSpell(spell:"Fireball") => ${castSpell(spell: 'Fireball')}',
      '',
      '=== Attack Demo ===',
      attack('Goblin'), 
      attack('Dragon', bonus: 5), 
    ].join('\n'));
  }

  // 3) COLLECTION
  void demoCollections() {
    final rng = Random();
    final monsters = ['Slime', 'Goblin', 'Wolf', 'Dragon'];
    final strongNames = monsters.where((m) => m.length > 4).toList();

    final rawMonsters = ['orc', 'troll', 'skeleton', 'zombie'];
    final formattedMonsters = rawMonsters.map((m) => m.toTitleCase()).toList();
    
    show([
      '=== Collections ===',
      'monsters: $monsters',
      'where(length>4): $strongNames',
      '',
      '=== Extension: toTitleCase() ===',
      'Nama Asli (Kecil): $rawMonsters',
      'Setelah toTitleCase: $formattedMonsters',
    ].join('\n'));
  }

  // 4) CLASS
  void demoClasses() {
    final hero = HeroRpg(name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);
    
    final json = {
      'title': 'Lord', 
      'name': 'Bima',
      'job': 'warrior',
      'baseHp': 120,
      'baseMp': 40,
    };
    final hero2 = HeroRpg.fromJson(json);

    show([
      '=== Class ===',
      'hero: $hero',
      'power: ${hero.power}',
      '',
      '=== Parse JSON Title ===',
      'hero2: $hero2',
    ].join('\n'));
  }

  // 5) ASYNC/AWAIT
  Future<void> demoAsyncAwait() async {
    show('⏳ Mengambil quest dari server...');
    await Future.delayed(const Duration(seconds: 1));
    show('=== Async/Await ===\nQuest: Kalahkan 3 Goblin');
  }

  Future<List<String>> fetchShopItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['🗡️ Iron Sword (150G)', '🛡️ Wooden Shield (80G)', '🧪 Health Potion (25G)'];
  }

  Future<void> demoShop() async {
    show('⏳ Berjalan ke toko item...');
    final items = await fetchShopItems(); 
    show([
      '=== Shop Items ===',
      'Barang yang tersedia di toko:',
      ...items.map((item) => '• $item'),
    ].join('\n'));
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
                  onPressed: getRandomLoot,
                  icon: const Icon(Icons.card_giftcard),
                  label: const Text('Random Loot'),
                ),
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
                ElevatedButton.icon(
                  onPressed: demoShop,
                  icon: const Icon(Icons.store),
                  label: const Text('Buka Toko'),
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
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                ),
                child: SingleChildScrollView(
                  child: SelectableText(
                    output,
                    style: const TextStyle(fontFamily: 'monospace', height: 1.35),
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

extension StringCasingExtension on String {
  String toTitleCase() {
    if (this.isEmpty) return this;
    return '${this[0].toUpperCase()}${this.substring(1).toLowerCase()}';
  }
}