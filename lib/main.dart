import 'package:flutter/material.dart';
import 'game_hero.dart';
import 'extensions.dart';
import 'shop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPG Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RpgHomePage(),
    );
  }
}

class RpgHomePage extends StatefulWidget {
  const RpgHomePage({super.key});

  @override
  State<RpgHomePage> createState() => _RpgHomePageState();
}

class _RpgHomePageState extends State<RpgHomePage> {
  GameHero hero = GameHero(
    name: 'Arthur',
    hp: 50,
    maxHp: 100,
    inventory: {
      'Sword': 1,
      'Health Potion': 3,
      'Gold Coin': 50,
    },
  );

  List<String> monsters = ['goblin king', 'dark wizard', 'fire dragon'];
  List<String> shopItems = [];
  bool isLoadingShop = false;
  String log = '';

  void onHeal() {
    setState(() {
      hero = hero.heal();
      log = '💊 Heal digunakan! HP sekarang: ${hero.hp}';
    });
  }

  void onShowInventory() {
    setState(() {
      log = hero.showInventory();
    });
  }

  Future<void> onFetchShop() async {
    setState(() {
      isLoadingShop = true;
      log = '🔄 Mengambil data toko...';
    });
    final items = await fetchShopItems();
    setState(() {
      shopItems = items;
      isLoadingShop = false;
      log = '🏪 Data toko berhasil dimuat!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RPG Game - Dart Lab')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$hero',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                    onPressed: onHeal, child: const Text('💊 Heal')),
                const SizedBox(width: 8),
                ElevatedButton(
                    onPressed: onShowInventory,
                    child: const Text('🎒 Inventory')),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: isLoadingShop ? null : onFetchShop,
                  child: const Text('🏪 Toko'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (log.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.grey[200],
                width: double.infinity,
                child: Text(log),
              ),
            const SizedBox(height: 16),
            const Text('👾 Daftar Monster:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...monsters.map((m) => Text('  - ${m.toTitleCase()}')),
            const SizedBox(height: 16),
            if (shopItems.isNotEmpty) ...[
              const Text('🏪 Item Toko:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ...shopItems.map((item) => Text('  🛒 $item')),
            ],
          ],
        ),
      ),
    );
  }
}