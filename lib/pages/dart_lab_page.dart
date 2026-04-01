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

  // 1) VARIABLES + NULL SAFETY
  void demoVariablesAndNullSafety() {
    var name = 'Rani';
    final hp = 100;
    const maxLevel = 10;

    String? guild;

    final guildName = guild ?? 'No Guild';
    final guildUpper = guild?.toUpperCase();

    final List<int?> potions = [1, null, 3];

    show([
      '=== Variables + Null Safety ===',
      'name: $name',
      'hp: $hp',
      'maxLevel: $maxLevel',
      'guild: $guild',
      'guildName: $guildName',
      'guildUpper: $guildUpper',
      'potions: $potions',
    ].join('\n'));
  }

  // 2) FUNCTIONS
  void demoFunctions() {
    int add(int a, int b) => a + b;

    String greet(String name, [String? title]) {
      return title == null ? 'Halo $name!' : 'Halo $title $name!';
    }

    String castSpell({required String spell, int manaCost = 10}) {
      return '🪄 Cast $spell (mana -$manaCost)';
    }

    int applyTwice(int value, int Function(int) f) {
      return f(f(value));
    }

    show([
      '=== Functions ===',
      'add: ${add(2, 3)}',
      'greet: ${greet('Rani')}',
      'greet title: ${greet('Rani', 'Mage')}',
      'spell: ${castSpell(spell: 'Fireball')}',
      'applyTwice: ${applyTwice(3, (x) => x * 2)}',
    ].join('\n'));
  }

  // 3) COLLECTION
  void demoCollections() {
    final rng = Random();

    final monsters = ['slime', 'goblin', 'wolf', 'dragon'];
    final labeled =
        monsters.map((m) => 'Monster: ${m.toTitleCase()}').toList();

    final hits = List.generate(3, (_) => rng.nextInt(10) + 1);
    final totalDamage = hits.fold<int>(0, (sum, x) => sum + x);

    show([
      '=== Collections ===',
      'monsters: $labeled',
      'hits: $hits',
      'totalDamage: $totalDamage',
    ].join('\n'));
  }

  // 4) CLASS
  void demoClasses() {
    final hero = HeroRpg.novice('Rani');
    final leveled = hero.levelUp(2);

    final hero2 = HeroRpg.fromJson({
      'name': 'Bima',
      'job': 'warrior',
      'baseHp': 120,
      'baseMp': 40,
      'inventory': {'potion': 2}
    });

    show([
      '=== Class ===',
      'hero: $hero',
      'power: ${hero.power}',
      'leveled: $leveled',
      'hero2: $hero2',
    ].join('\n'));
  }

  // 5) ASYNC QUEST
  Future<void> demoAsyncAwait() async {
    show('⏳ Loading quest...');

    try {
      final quest = await fetchQuest();
      show('Quest: $quest');
    } catch (e) {
      show('Error: $e');
    }
  }

  Future<String> fetchQuest() async {
    await Future.delayed(const Duration(seconds: 1));

    const quests = [
      'Kalahkan Goblin',
      'Cari Potion',
      'Lindungi desa',
    ];

    final rng = Random();
    return quests[rng.nextInt(quests.length)];
  }

  // =========================
  // ✅ PR FITUR
  // =========================

  // HEAL
  void demoHeal() {
    final hero = HeroRpg.novice('Rani');
    final healed = hero.heal();

    show('❤️ Heal\nHP: ${hero.baseHp} → ${healed.baseHp}');
  }

  // INVENTORY
  void demoInventory() {
    final hero = HeroRpg.novice('Rani');

    final result = hero.inventory.entries
        .map((e) => '- ${e.key.toTitleCase()}: ${e.value}')
        .join('\n');

    show('🎒 Inventory:\n$result');
  }

  // ASYNC SHOP
  Future<void> demoShop() async {
    show('🛒 Loading shop...');

    final items = await fetchShopItems();

    final result =
        items.map((e) => '- ${e.toTitleCase()}').join('\n');

    show('🛍️ Shop:\n$result');
  }

  Future<List<String>> fetchShopItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['sword', 'shield', 'potion', 'armor'];
  }

  // RANDOM LOOT
  void randomLoot() {
    final items = ['gold', 'potion', 'gem'];
    final rng = Random();
    final loot = items[rng.nextInt(items.length)];

    show('🎁 Loot: ${loot.toTitleCase()}');
  }

  // ATTACK
  void demoAttack() {
    final rng = Random();
    final damage = rng.nextInt(10) + 1;

    show('⚔️ Attack Goblin, damage: $damage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dart Lab RPG')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(onPressed: demoVariablesAndNullSafety, child: const Text('Variables')),
                ElevatedButton(onPressed: demoFunctions, child: const Text('Functions')),
                ElevatedButton(onPressed: demoCollections, child: const Text('Collections')),
                ElevatedButton(onPressed: demoClasses, child: const Text('Class')),
                ElevatedButton(onPressed: demoAsyncAwait, child: const Text('Async')),

                // PR
                ElevatedButton(onPressed: demoHeal, child: const Text('Heal')),
                ElevatedButton(onPressed: demoInventory, child: const Text('Inventory')),
                ElevatedButton(onPressed: demoShop, child: const Text('Shop')),

                ElevatedButton(onPressed: randomLoot, child: const Text('Loot')),
                ElevatedButton(onPressed: demoAttack, child: const Text('Attack')),

                OutlinedButton(
                  onPressed: () => show('Reset'),
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(output),
              ),
            ),
          ],
        ),
      ),
    );
  }
}