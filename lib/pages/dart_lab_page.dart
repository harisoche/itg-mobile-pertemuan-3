import 'dart:math';
import 'package:flutter/material.dart';
import '../models/hero.dart';

class DartLabPage extends StatefulWidget {
  const DartLabPage({super.key});

  @override
  State<DartLabPage> createState() => _DartLabPageState();
}

extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) return this;

    return split(' ')
        .map((word) =>
            word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}

class _DartLabPageState extends State<DartLabPage> {
  String output = 'Tekan tombol untuk melihat demo Dart!';

  void show(String text) {
    setState(() => output = text);
  }
    List<String> items = ['gold','potion','gem','scroll'];

    void demoRandomLoot() {
    final randomNumber = Random();
    final randomItem = items[randomNumber.nextInt(items.length)];
    // Operator ?? (kalau null, pakai nilai pengganti)
    
    show([
      'Random loot: $randomItem',
    ].join('\n'));
  }

  void attack(String monster, {int bonus = 0}) {
    final randomNumber = Random();
    final damage = randomNumber.nextInt(100) + bonus;
    // Operator ?? (kalau null, pakai nilai pengganti)
    
    show([
      'Attack $monster, damage: $damage',
    ].join('\n'));
  }


  // 1) VAR / FINAL / CONST + NULL SAFETY
  void demoVariablesAndNullSafety() {
    // var: tipe bisa "di-infer" oleh Dart
    var name = 'Rani'; // String

    // final: nilainya hanya bisa di-assign sekali (runtime constant)
    final hp = 100;

    // const: benar-benar constant di compile-time
    const maxLevel = 10;

    // Null safety: tipe? artinya boleh null
    String? guild;

    

    // Operator ?? (kalau null, pakai nilai pengganti)
    final guildName = guild ?? 'No Guild';

    // Operator ?. (akses property/method kalau tidak null)
    final guildUpper = guildName.toUpperCase(); // hasilnya String? (bisa null)

    // Contoh list yang boleh menyimpan null
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
      '',
      'Catatan:',
      '- var = Dart menebak tipe',
      '- final = sekali assign (runtime)',
      '- const = compile-time constant',
      '- String? = boleh null',
    ].join('\n'));
  }

  // 2) FUNCTION: positional, named, optional, arrow, higher-order
  void demoFunctions() {
    int add(int a, int b) => a + b; // arrow function

    // optional positional parameter [ ... ]
    String greet(String name, [String? title]) {
      if (title == null) return 'Halo $name!';
      return 'Halo $title $name!';
    }
    

    // named parameter { ... } + required
    String castSpell({required String spell, int manaCost = 10}) {
      return '🪄 Cast $spell (mana -$manaCost)';
    }

    // function sebagai parameter
    int applyTwice(int value, int Function(int) f) {
      return f(f(value));
    }

    final resultAdd = add(2, 3);
    final hello1 = greet('Rani');
    final hello2 = greet('Rani', 'Mage');
    final spell1 = castSpell(spell: 'Fireball');
    final spell2 = castSpell(spell: 'Heal', manaCost: 5);
    final doubledTwice = applyTwice(3, (x) => x * 2); // 3 -> 6 -> 12

    show([
      '=== Functions ===',
      'add(2,3) => $resultAdd',
      'greet("Rani") => $hello1',
      'greet("Rani","Mage") => $hello2',
      'castSpell(spell:"Fireball") => $spell1',
      'castSpell(spell:"Heal", manaCost:5) => $spell2',
      'applyTwice(3, x*2) => $doubledTwice',
      '',
      'Catatan:',
      '- [param] = optional positional',
      '- {param} = named parameter',
      '- required = wajib diisi',
      '- Function bisa jadi parameter',
    ].join('\n'));
  }

  // 3) COLLECTION: List/Map + map/where/fold + collection if/for
  void demoCollections() {
    final rng = Random();

    // List
    final monsters = ['Slime', 'Goblin', 'Wolf', 'Dragon', 'ogre'];

    // Ambil monster yang panjang namanya > 4
    final strongNames = monsters.where((m) => m.length > 4).toList();
    // Ubah jadi "Monster: X"
    final labeled = monsters.map((m) => 'Monster: $m').toList();

    // Total damage acak untuk 3 hit
    final hits = List.generate(3, (_) => rng.nextInt(10) + 1); // 1..10
    final totalDamage = hits.fold<int>(0, (sum, x) => sum + x);

    // Map
    final loot = {
      'gold': 120,
      'potion': 2,
      'gem': 1,
    };

    // Collection if/for (seru buat bikin list dinamis)
    final level = rng.nextInt(5) + 1; // 1..5
    final rewards = [
      '🎁 Daily Reward',
      if (level >= 3) '⭐ Bonus Reward (level >= 3)',
      for (final item in loot.keys) '• $item',
    ];

    show([
      '=== Collections (List/Map) ===',
      'monsters: $monsters',
      'where(length>4): $strongNames',
      'toTitleCase: ${monsters[4].toTitleCase()}',
      'map(label): $labeled',
      'hits: $hits',
      'totalDamage (fold): $totalDamage',
      '',
      'loot map: $loot',
      'random level: $level',
      'rewards:',
      ...rewards,
      '',
      'Catatan:',
      '- where = filter',
      '- map = transform',
      '- fold = reduce + akumulasi',
      '- collection if/for = list dinamis',
    ].join('\n'));
  }

  

  void demoInventory() {

    // List
    final items = ['sword', 'shield', 'armor', 'ring', 'amulet', 'scroll', 'gem'];

    // Map
    final loot = {
      'gold': 120,
      'potion': 2,
      'gem': 1,
    };
    final itemList = items.map((e) => '• $e').toList();

    final lootList =
      loot.entries.map((e) => '• ${e.key} : ${e.value}').toList();


    show([
      '=== Inventory ===',
      'Items: $items',
      'Item List: ',
      ...itemList,
      'loot map: $loot',
      'loot list:',
      ...lootList,
      '',
    ].join('\n'));
  }

  // 4) CLASS + CONSTRUCTOR + FACTORY + GETTER + ENUM + EXTENSION
  void demoClasses() {
    final hero = HeroRpg(title: "Hero RPG", name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);
    final leveled = hero.levelUp(3);

    // Simulasi data JSON (Map)
    final json = {
      'title': 'Hero RPG',
      'name': 'Bima',
      'job': 'warrior',
      'baseHp': 120,
      'baseMp': 40,
    };

    final hero2 = HeroRpg.fromJson(json);

    show([
      '=== Class / Enum / Extension ===',
      'title: ${hero.title}',
      'hero: $hero',
      'hero.power => ${hero.power}',
      'leveled (levelUp 3x): $leveled',
      '',
      'fromJson:',
      'hero2: $hero2',
      'hero2.title => ${hero2.title}',
      'hero2.jobLabel => ${hero2.job.label}',
      '',
      'Catatan:',
      '- constructor = cara membuat object',
      '- factory fromJson = bikin object dari Map',
      '- getter (power) = property hasil hitungan',
      '- enum = pilihan tetap (job)',
      '- extension = nambah kemampuan ke tipe (job.label)',
    ].join('\n'));
  }

  void demoHeal(int? healAmount) {
    final hero = HeroRpg(title: "Hero RPG", name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);
    final leveled = hero.levelUp(3);
    
    final healedHero = hero.heal(healAmount ?? 10);

    show([
      'title: ${hero.title}',
      'hero: $hero',
      'hero.power => ${hero.power}',
      'leveled (levelUp 3x): $leveled',
      'hero hp before heal: ${hero.baseHp}',
      'hero MP ${hero.baseMp}',
      'healAmount: $healAmount',
      'hero after heal: $healedHero',
      'hero HP after heal: ${healedHero.baseHp}',
      '',
    ].join('\n'));
  }

  // 5) ASYNC/AWAIT + TRY/CATCH
  Future<void> demoAsyncAwait() async {
    show('⏳ Mengambil quest dari server...');

    try {
      final shopTrade = await fetchShopItems();
      final quest = await fetchQuest();
      show([
        '=== Async/Await ===',
        'Quest didapat!',
        '• $quest',
        'Shop Trade mission:',
        '• $shopTrade',
        '',
        'Catatan:',
        '- Future = nilai yang datang belakangan',
        '- await = tunggu Future selesai',
        '- try/catch = tangani error',
      ].join('\n'));
    } catch (e) {
      show('❌ Gagal ambil quest: $e');
    }
  }

  

  Future<String> fetchQuest() async {
    // Simulasi "internet" dengan delay
    await Future.delayed(const Duration(seconds: 1));

    // Kadang gagal biar seru
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

  Future<String> fetchShopItems() async {
    // Simulasi "internet" dengan delay
    await Future.delayed(const Duration(seconds: 1));

    // Kadang gagal biar seru
    final rng = Random();
    if (rng.nextInt(5) == 0) {
      throw Exception('Server sedang tidur 😴');
    }

    const shopTrade = [
      'Buy 2 Potion',
      'Sell 1 Sword',
      'Trade 3 Gems for 100 Gold',
      'buy 1 Scroll',
    ];

    return shopTrade[rng.nextInt(shopTrade.length)];
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
                  onPressed:  () => demoHeal(10),
                  icon: const Icon(Icons.health_and_safety),
                  label: const Text('Heal'),
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
                  onPressed: demoInventory,
                  icon: const Icon(Icons.inventory),
                  label: const Text('Inventory'),
                ),
                ElevatedButton.icon(
                  onPressed: demoClasses,
                  icon: const Icon(Icons.shield),
                  label: const Text('Class + Enum'),
                ),
                ElevatedButton.icon(
                  onPressed: () => demoAsyncAwait(),
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('Async/Await'),
                ),
                ElevatedButton.icon(
                  onPressed: () => demoRandomLoot(),
                  icon: const Icon(Icons.numbers),
                  label: const Text('Random loot'),
                ),
                ElevatedButton.icon(
                  onPressed: () => attack('Goblin'),
                  icon: const Icon(Icons.dangerous),
                  label: const Text('Attack Goblin'),
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