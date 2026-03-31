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

  // ========================
  // LATIHAN A: RANDOM LOOT
  // ========================
  void randomLoot() {
    final rng = Random();
    final loots = ['gold', 'potion', 'gem', 'scroll'];

    final result = loots[rng.nextInt(loots.length)];

    show('🎁 Loot: $result');
  }

  // ========================
  // LATIHAN B: ATTACK
  // ========================
  String attack(String monster, {int bonus = 0}) {
    final rng = Random();
    final damage = rng.nextInt(10) + 1 + bonus;
    return '⚔️ Attack $monster → damage: $damage';
  }

  void demoAttack() {
    show([attack('Goblin'), attack('Dragon', bonus: 5)].join('\n'));
  }

  // ========================
  // VARIABLES + NULL SAFETY
  // ========================
  void demoVariables() {
    var name = 'Rani';
    final hp = 100;
    const maxLevel = 10;

    String? guild;
    final guildName = guild ?? 'No Guild';

    show('name: $name\nhp: $hp\nmaxLevel: $maxLevel\nguild: $guildName');
  }

  // ========================
  // FUNCTION
  // ========================
  void demoFunction() {
    int add(int a, int b) => a + b;

    String greet(String name, [String? title]) {
      return title == null ? 'Halo $name' : 'Halo $title $name';
    }

    show('${add(2, 3)}\n${greet('Rani')}\n${greet('Rani', 'Mage')}');
  }

  // ========================
  // COLLECTION
  // ========================
  void demoCollection() {
    final rng = Random();
    final list = List.generate(3, (_) => rng.nextInt(10) + 1);
    final total = list.fold(0, (a, b) => a + b);

    show('List: $list\nTotal: $total');
  }

  // ========================
  // CLASS + ENUM
  // ========================
  void demoClass() {
    final hero = HeroRpg(
      name: 'Rani',
      title: 'Mage',
      job: Job.mage,
      baseHp: 80,
      baseMp: 120,
    );

    final json = {
      'name': 'Bima',
      'job': 'warrior',
      'baseHp': 120,
      'baseMp': 40,
      'title': 'The Brave',
    };

    final hero2 = HeroRpg.fromJson(json);

    show('$hero\nPower: ${hero.power}\n\nFrom JSON:\n$hero2');
  }

  // ========================
  // ASYNC / AWAIT
  // ========================
  Future<void> demoAsync() async {
    show('Loading...');

    await Future.delayed(const Duration(seconds: 1));

    show('✅ Data berhasil diambil');
  }

  // ========================
  // UI
  // ========================
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
              children: [
                ElevatedButton(
                  onPressed: demoVariables,
                  child: const Text('Var'),
                ),
                ElevatedButton(
                  onPressed: demoFunction,
                  child: const Text('Function'),
                ),
                ElevatedButton(
                  onPressed: demoCollection,
                  child: const Text('Collection'),
                ),
                ElevatedButton(
                  onPressed: demoClass,
                  child: const Text('Class'),
                ),
                ElevatedButton(
                  onPressed: demoAsync,
                  child: const Text('Async'),
                ),
                ElevatedButton(
                  onPressed: randomLoot,
                  child: const Text('Loot'),
                ),
                ElevatedButton(
                  onPressed: demoAttack,
                  child: const Text('Attack'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  output,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
