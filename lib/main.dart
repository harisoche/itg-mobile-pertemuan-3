// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'hero.dart' as game_hero;
import 'extensions.dart';
import 'shop.dart';

Future<void> _initializeGame() async {
  // === Setup awal Hero ===
  game_hero.Hero hero = const game_hero.Hero(
    name: 'Arya',
    hp: 50,
    inventory: {},
  );
  print('Hero: ${hero.name} | HP: ${hero.hp}');

  // === 1. Tombol Heal (+10 HP) ===
  hero = hero.copyWith(hp: hero.hp + 10);
  print('\n[HEAL] HP sekarang: ${hero.hp}');

  // === 2. Tombol Inventory ===
  hero = hero.copyWith(
    inventory: {'Health Potion': 3, 'Iron Sword': 1, 'Arrow': 20},
  );
  print('');
  hero.showInventory();

  // === 3. Extension toTitleCase() untuk nama monster ===
  List<String> monsters = ['goblin king', 'dark wizard', 'stone golem'];
  print('\n=== Daftar Monster ===');
  for (var monster in monsters) {
    print('- ${monster.toTitleCase()}');
  }

  // === 4. Async fetchShopItems() ===
  print('\n[SHOP] Mengambil data toko...');
  List<String> shopItems = await fetchShopItems();
  print('=== Item Toko ===');
  for (var item in shopItems) {
    print('- $item');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeGame();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        body: Center(
          child: Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => _counter++),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
