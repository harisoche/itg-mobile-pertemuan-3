import 'dart:math';
import 'package:flutter/material.dart';
import '../models/hero.dart';

extension StringExtensions on String {
  String toTitleCase() {
    final words = split(' ');
    final capitalized = words
        .map((w) {
          if (w.isEmpty) return w;
          return w[0].toUpperCase() + w.substring(1).toLowerCase();
        })
        .join(' ');
    return capitalized;
  }
}

class DartLabPage extends StatefulWidget {
  const DartLabPage({super.key});

  @override
  State<DartLabPage> createState() => _DartLabPageState();
}

class _DartLabPageState extends State<DartLabPage> {
  String output = 'Tekan tombol untuk melihat demo Dart!';
  HeroRpg currentHero = const HeroRpg(
    name: 'Rani',
    job: Job.mage,
    baseHp: 80,
    baseMp: 120,
  );
  Map<String, int> inventory = {'Potion': 2, 'Elixir': 1, 'Arrow': 12};

  void show(String text) {
    setState(() => output = text);
  }

  void healHero() {
    final healedHero = HeroRpg(
      name: currentHero.name,
      job: currentHero.job,
      baseHp: currentHero.baseHp + 10,
      baseMp: currentHero.baseMp,
    );
    setState(() => currentHero = healedHero);
    show('✅ Heal +10! Hero sekarang HP ${currentHero.baseHp}');
  }

  void showInventory() {
    final lines = inventory.entries
        .map((e) => '• ${e.key}: ${e.value}')
        .toList();
    show(
      [
        '=== Inventory ===',
        ...lines,
        '',
        'Total item jenis: ${inventory.length}',
      ].join('\n'),
    );
  }

  void demoMonsterTitleCase() {
    final monsters = ['slime', 'goblin', 'ice wolf', 'dark dragon'];
    final titleCased = monsters.map((m) => m.toTitleCase()).toList();
    show(
      [
        '=== Monster Name toTitleCase ===',
        ...titleCased.map((m) => '• $m'),
      ].join('\n'),
    );
  }

  Future<void> fetchShopItems() async {
    show('⏳ Mengambil item dari shop...');
    await Future.delayed(const Duration(seconds: 1));
    final shopItems = ['sword', 'shield', 'potion', 'gem'];
    show(
      [
        "=== Shop Items (async) ===",
        ...shopItems.map((i) => '• ${i.toTitleCase()}'),
      ].join('\n'),
    );
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

    show(
      [
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
      ].join('\n'),
    );
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

    show(
      [
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
      ].join('\n'),
    );
  }

  // 3) COLLECTION: List/Map + map/where/fold + collection if/for
  void demoCollections() {
    final rng = Random();

    // List
    final monsters = ['Slime', 'Goblin', 'Wolf', 'Dragon'];

    // Ambil monster yang panjang namanya > 4
    final strongNames = monsters.where((m) => m.length > 4).toList();

    // Ubah jadi "Monster: X"
    final labeled = monsters.map((m) => 'Monster: $m').toList();

    // Total damage acak untuk 3 hit
    final hits = List.generate(3, (_) => rng.nextInt(10) + 1); // 1..10
    final totalDamage = hits.fold<int>(0, (sum, x) => sum + x);

    // Map
    final loot = {'gold': 120, 'potion': 2, 'gem': 1};

    // Collection if/for (seru buat bikin list dinamis)
    final level = rng.nextInt(5) + 1; // 1..5
    final rewards = [
      '🎁 Daily Reward',
      if (level >= 3) '⭐ Bonus Reward (level >= 3)',
      for (final item in loot.keys) '• $item',
    ];

    show(
      [
        '=== Collections (List/Map) ===',
        'monsters: $monsters',
        'where(length>4): $strongNames',
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
      ].join('\n'),
    );
  }

  // 4) CLASS + CONSTRUCTOR + FACTORY + GETTER + ENUM + EXTENSION
  void demoClasses() {
    final hero = HeroRpg(name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);
    final leveled = hero.levelUp(3);

    // Simulasi data JSON (Map)
    final json = {
      'name': 'Bima',
      'job': 'warrior',
      'baseHp': 120,
      'baseMp': 40,
    };

    final hero2 = HeroRpg.fromJson(json);

    show(
      [
        '=== Class / Enum / Extension ===',
        'hero: $hero',
        'hero.power => ${hero.power}',
        'leveled (levelUp 3x): $leveled',
        '',
        'fromJson:',
        'hero2: $hero2',
        'hero2.jobLabel => ${hero2.job.label}',
        '',
        'Catatan:',
        '- constructor = cara membuat object',
        '- factory fromJson = bikin object dari Map',
        '- getter (power) = property hasil hitungan',
        '- enum = pilihan tetap (job)',
        '- extension = nambah kemampuan ke tipe (job.label)',
      ].join('\n'),
    );
  }

  // 5) ASYNC/AWAIT + TRY/CATCH
  Future<void> demoAsyncAwait() async {
    show('⏳ Mengambil quest dari server...');

    try {
      final quest = await fetchQuest();
      show(
        [
          '=== Async/Await ===',
          'Quest didapat!',
          '• $quest',
          '',
          'Catatan:',
          '- Future = nilai yang datang belakangan',
          '- await = tunggu Future selesai',
          '- try/catch = tangani error',
        ].join('\n'),
      );
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
            const Text(
              'Tugas Dart Lab RPG',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: healHero,
                  icon: const Icon(Icons.healing),
                  label: const Text('Heal +10 (Immutable)'),
                ),
                ElevatedButton.icon(
                  onPressed: showInventory,
                  icon: const Icon(Icons.inventory_2),
                  label: const Text('Inventory'),
                ),
                ElevatedButton.icon(
                  onPressed: demoMonsterTitleCase,
                  icon: const Icon(Icons.format_textdirection_l_to_r),
                  label: const Text('toTitleCase Monster'),
                ),
                ElevatedButton.icon(
                  onPressed: fetchShopItems,
                  icon: const Icon(Icons.store),
                  label: const Text('Fetch Shop Items'),
                ),
                OutlinedButton.icon(
                  onPressed: () =>
                      show('Tekan tombol untuk melihat demo Dart!'),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Demo tambahan (opsional)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
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
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black.withAlpha(25)),
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
