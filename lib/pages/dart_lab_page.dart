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
  HeroRpg hero = HeroRpg(
  name: 'Player',
  job: Job.warrior,
  baseHp: 100,
  baseMp: 50,

  
);
Future<List<String>> fetchShopItems() async {
  await Future.delayed(const Duration(seconds: 1));
  return ["Sword", "Shield", "Potion"];
}
Map<String, int> inventory = {
  "Potion": 2,
  "Elixir": 1,
  "Gold": 100,
};
HeroRpg? activeHero;
  void show(String text) {
    setState(() => output = text);
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
    final monsters = ['slime', 'goblin king', 'dark wolf'];

    final formatted = monsters.map((m) => m.toTitleCase()).toList();
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
      'map(label): $labeled',
      'hits: $hits',
      'formatted monsters: $formatted',
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

  // 4) CLASS + CONSTRUCTOR + FACTORY + GETTER + ENUM + EXTENSION
  void demoClasses() {
    final hero = HeroRpg(name: 'Rani', title: 'The Great', job: Job.mage, baseHp: 80, baseMp: 120);
    final leveled = hero.levelUp(3);

    // Simulasi data JSON (Map)
    final json = {
      'name': 'Bima',
      'job': 'warrior',
      'baseHp': 120,
      'baseMp': 40,
    };

    final hero2 = HeroRpg.fromJson(json);

    show([
      '=== Class / Enum / Extension ===',
      'hero: $hero',
      'hero.power => ${hero.power}',
      'leveled (levelUp 3x): $leveled',
      '',
      'fromJson:',
      'hero2: $hero2',
      'hero2 title: ${hero2.title}',
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

  // 5) ASYNC/AWAIT + TRY/CATCH
  Future<void> demoAsyncAwait() async {
    show('⏳ Mengambil quest dari server...');

    try {
      final quest = await fetchQuest();
      show([
        '=== Async/Await ===',
        'Quest didapat!',
        '• $quest',
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

  // --- LATIHAN A: RANDOM LOOT ---
  void demoRandomLoot() {
    final loots = ['gold', 'potion', 'gem', 'scroll'];
    final rng = Random();
    
    // Mengambil item acak berdasarkan index (0 sampai panjang list - 1)
    final pickedLoot = loots[rng.nextInt(loots.length)];

    show([
      '=== Random Loot ===',
      'WAw! Selamat Kamu menemukan: $pickedLoot',
      '',
      'Daftar Loot yang tersedia: $loots',
      '',
      'Catatan:',
      '- Random().nextInt(4) menghasilkan angka 0-3',
      '- loots[index] mengambil item dari list sesuai posisi',
    ].join('\n'));
  }

// --- LATIHAN B: FUNCTION ATTACK ---
  
  String attack(String monster, {int bonus = 0}) {
    final rng = Random();
    final baseDamage = rng.nextInt(10) + 1; // 1 sampai 10
    final totalDamage = baseDamage + bonus;

    return 'Attack $monster, damage: $totalDamage (Base: $baseDamage + Bonus: $bonus)';
  }

  void demoAttackAction() {
    // Memanggil function attack dengan berbagai skenario
    final atk1 = attack('Goblin'); // Tanpa bonus (menggunakan default 0)
    final atk2 = attack('Dragon', bonus: 5); // Menggunakan named parameter bonus
    
    show([
      '=== Battle Log ===',
      atk1,
      atk2,
      '',
      'Kriteria Latihan:',
      '- Menggunakan Random() untuk damage 1..10',
      '- Menggunakan Named Parameter {int bonus = 0}',
      '- String interpolation untuk output',
    ].join('\n'));
  }

  // --- LATIHAN C: PARSING JSON (Baru) ---
  void demoParsingJson() {
    final jsonResponse = {
      'name': 'Gatot',
      'title': 'Ksatria Pringgodani',
      'job': 'warrior',
      'baseHp': 200,
      'baseMp': 50,
    };

    final hero = HeroRpg.fromJson(jsonResponse);

    show([
      '=== Latihan C: Parsing JSON ===',
      'Input JSON: $jsonResponse',
      '',
      'Hasil Object Hero:',
      'Nama Hero: ${hero.name}',
      'Gelar    : ${hero.title}',
      'toString : $hero',
      '',
      'Catatan:',
      '- Berhasil mengekstrak field "title"',
      '- Coba hapus field title di code untuk lihat default value "Rookie"',
    ].join('\n'));
  }

// PR 1: Tambah Tombol Heal (Immutable)
  void demoHealAction() {
    // Inisialisasi jika belum ada
    activeHero ??= const HeroRpg(
      name: 'Rani', 
      title: 'The Great', 
      job: Job.mage, 
      baseHp: 80, 
      baseMp: 120
    );

    // Update secara immutable (menghasilkan object baru)
    activeHero = activeHero!.heal();

    show([
      '=== PR_NO 1: Heal Action ===',
      'Hero melakukan pemulihan...',
      'Status Baru: $activeHero',
      '',
      'Catatan: HP bertambah +10 setiap klik.'
    ].join('\n'));
  }

  // PR 2: Tombol Inventory (Map Format)
  void demoInventoryDisplay() {
    final items = {'Gold': 500, 'Potion': 3, 'Magic Scroll': 1, 'Gem': 1};
    
    List<String> result = ['=== PR_NO 2: Hero Inventory ==='];
    items.forEach((key, value) {
      result.add('• $key : $value');
    });

    show(result.join('\n'));
  }

  // PR 3: Extension toTitleCase()
  void demoAttackWithTitleCase() {
    String monsterName = 'goblin'; // Input huruf kecil
    final damage = Random().nextInt(10) + 1;
    
    // Memanggil extension yang dibuat di model
    show([
      '=== PR_NO 3: String Extension ===',
      'Input awal: $monsterName',
      'Setelah toTitleCase(): ${monsterName.toTitleCase()}',
      '',
      'Attack ${monsterName.toTitleCase()}, damage: $damage',
    ].join('\n'));
  }

  // PR 4: Async fetchShopItems()
  Future<void> fetchShopItems() async {
    show('PR_NO 4: Menghubungi pedagang shop...');
    
    await Future.delayed(const Duration(seconds: 1));
    
    const shopList = ['Iron Sword - 100g', 'Mana Potion - 20g', 'Antidote - 15g'];
    
    show([
      '=== Shop Items (Async) ===',
      'Barang tersedia hari ini:',
      ...shopList.map((item) => '- $item'),
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

  Text(
    "HP: ${hero.baseHp}",
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  ),

  const SizedBox(height: 10),

  Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      ElevatedButton.icon(
        onPressed: () {
          show(
            inventory.entries
                .map((item) => "${item.key}: ${item.value}")
                .join('\n'),
          );
        },
        icon: const Icon(Icons.inventory),
        label: const Text('Inventory'),
      ),
      ElevatedButton.icon(
        onPressed: () {
          setState(() {
            hero = hero.heal();
          });
        },
        icon: const Icon(Icons.favorite),
        label: const Text('Heal +10'),
      ),
      ElevatedButton.icon(
        onPressed: () async {
          show("Loading shop...");
          final items = await fetchShopItems();
          show(items.join('\n'));
        },
        icon: const Icon(Icons.store),
        label: const Text('Shop'),
      ),
      ElevatedButton.icon(
        onPressed: demoVariablesAndNullSafety,
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
                  onPressed: demoRandomLoot,
                  icon: const Icon(Icons.card_giftcard),
                  label: const Text('Random Loot'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade100,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: demoAttackAction,
                  icon: const Icon(Icons.sports_martial_arts),
                  label: const Text('Attack Action'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: demoParsingJson,
                  icon: const Icon(Icons.data_object),
                  label: const Text('Parse JSON'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: demoHealAction, 
                  icon: const Icon(Icons.health_and_safety), 
                  label: const Text('Heal (+10)'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: demoInventoryDisplay, 
                  icon: const Icon(Icons.backpack), 
                  label: const Text('Inventory'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: demoAttackWithTitleCase, 
                  icon: const Icon(Icons.text_fields), 
                  label: const Text('TitleCase Atk'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: fetchShopItems, 
                  icon: const Icon(Icons.shopping_bag), 
                  label: const Text('Fetch Shop'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade100),
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

extension StringExtension on String {
  String toTitleCase() {
    return split(' ')
        .map((word) =>
            word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}