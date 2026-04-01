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

  // CHALLENGE 1: HEAL BUTTON
  void demoHeal() {
    final hero = HeroRpg(
      name: 'Fathir',
      job: Job.mage,
      baseHp: 80,
      baseMp: 120,
    );

    // Immutable: membuat object baru
    final healedHero = HeroRpg(
      name: hero.name,
      job: hero.job,
      baseHp: hero.baseHp + 10,
      baseMp: hero.baseMp,
    );

    show(
      [
        '=== Heal Demo ===',
        'Hero awal HP: ${hero.baseHp}',
        'Hero setelah heal +10',
        'HP baru: ${healedHero.baseHp}',
        '',
        'Catatan:',
        'Hero lama tidak berubah (immutable)',
      ].join('\n'),
    );
  }

  // CHALLENGE 2: SHOP ITEMS
  Future<void> demoShopItems() async {
    show('🛒 Mengambil item dari shop...');

    final items = await fetchShopItems();

    show(['=== Shop Items ===', ...items.map((e) => '• $e')].join('\n'));
  }

  Future<List<String>> fetchShopItems() async {
    await Future.delayed(const Duration(seconds: 1));

    return ['Potion', 'Mega Potion', 'Mana Potion', 'Sword', 'Shield'];
  }

  // 1) VAR / FINAL / CONST + NULL SAFETY
  void demoVariablesAndNullSafety() {
    // var: tipe bisa "di-infer" oleh Dart
    var name = 'Fathir'; // String

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
    final hello1 = greet('Fathir');
    final hello2 = greet('Fathir', 'Godlane');
    final spell1 = castSpell(spell: 'Fireball');
    final spell2 = castSpell(spell: 'Heal', manaCost: 5);
    final doubledTwice = applyTwice(3, (x) => x * 2); // 3 -> 6 -> 12

    show(
      [
        '=== Functions ===',
        'add(2,3) => $resultAdd',
        'greet("Fathir") => $hello1',
        'greet("Fathir","Godlane") => $hello2',
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
    final hero = HeroRpg(
      name: 'Fathir',
      job: Job.mage,
      baseHp: 80,
      baseMp: 120,
    );
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
                  onPressed: () => demoAsyncAwait(),
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('Async/Await'),
                ),
                ElevatedButton.icon(
                  onPressed: demoHeal,
                  icon: const Icon(Icons.healing),
                  label: const Text('Heal +10'),
                ),
                OutlinedButton.icon(
                  onPressed: () =>
                      show('Tekan tombol untuk melihat demo Dart!'),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Clear'),
                ),
                ElevatedButton.icon(
                  onPressed: () => demoShopItems(),
                  icon: const Icon(Icons.store),
                  label: const Text('Shop Items'),
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
