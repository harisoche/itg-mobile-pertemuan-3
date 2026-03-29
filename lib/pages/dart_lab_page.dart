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

  int currentHp = 100;
  List<String> inventory = [];

  void show(String text) {
    setState(() => output = text);
  }

  // ================= RPG FEATURE =================

  void heal() {
    currentHp += 10;

    show(['=== Heal ===', '❤️ HP +10', 'HP sekarang: $currentHp'].join('\n'));
  }

  void attack(String monster, {int bonus = 0}) {
    final rng = Random();

    int baseDamage = rng.nextInt(10) + 1 + bonus;
    bool isCrit = rng.nextBool();
    int totalDamage = isCrit ? baseDamage * 3 : baseDamage;

    show(
      [
        '=== Attack ===',
        '⚔ Attack $monster',
        'Base damage: $baseDamage',
        if (isCrit) '🔥 CRITICAL HIT x3!',
        'Total damage: $totalDamage',
      ].join('\n'),
    );
  }

  void randomLoot() {
    final rng = Random();
    final items = ['gold', 'potion', 'gem', 'scroll'];

    final loot = items[rng.nextInt(items.length)];
    inventory.add(loot);

    show(
      [
        '=== Random Loot ===',
        '🎁 Dapat: $loot',
        'Inventory: $inventory',
      ].join('\n'),
    );
  }

  // ================= DEMO =================

  void demoVariablesAndNullSafety() {
    var name = 'Rani';
    final hp = 100;
    const maxLevel = 10;

    String? guild;

    final guildName = guild ?? 'No Guild';

    show(
      [
        '=== Variables ===',
        'name: $name',
        'hp: $hp',
        'maxLevel: $maxLevel',
        'guild: $guildName',
      ].join('\n'),
    );
  }

  void demoFunctions() {
    int add(int a, int b) => a + b;

    final result = add(2, 3);

    show(['=== Functions ===', 'add(2,3) = $result'].join('\n'));
  }

  void demoCollections() {
    final monsters = ['Slime', 'Goblin', 'Dragon'];

    show(['=== Collections ===', 'monsters: $monsters'].join('\n'));
  }

  void demoClasses() {
    final hero = HeroRpg(
      name: 'Rani',
      title: 'Mage',
      job: Job.mage,
      baseHp: 80,
      baseMp: 120,
    );

    show(['=== Class ===', '$hero', 'Power: ${hero.power}'].join('\n'));
  }

  Future<void> demoAsyncAwait() async {
    show('Loading quest...');

    await Future.delayed(const Duration(seconds: 1));

    show(['=== Async ===', 'Quest selesai!'].join('\n'));
  }

  // ================= UI =================

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
                ElevatedButton(onPressed: heal, child: const Text('Heal')),
                ElevatedButton(
                  onPressed: () => attack('Goblin', bonus: 5),
                  child: const Text('Attack'),
                ),
                ElevatedButton(
                  onPressed: randomLoot,
                  child: const Text('Loot'),
                ),
                ElevatedButton(
                  onPressed: demoVariablesAndNullSafety,
                  child: const Text('Variables'),
                ),
                ElevatedButton(
                  onPressed: demoFunctions,
                  child: const Text('Functions'),
                ),
                ElevatedButton(
                  onPressed: demoCollections,
                  child: const Text('Collections'),
                ),
                ElevatedButton(
                  onPressed: demoClasses,
                  child: const Text('Class'),
                ),
                ElevatedButton(
                  onPressed: demoAsyncAwait,
                  child: const Text('Async'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(child: SingleChildScrollView(child: Text(output))),
          ],
        ),
      ),
    );
  }
}
