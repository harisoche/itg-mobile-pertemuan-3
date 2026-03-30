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

  // State tambahan untuk mendemonstrasikan Heal (Tantangan 1)
  HeroRpg? activeHero;

  void show(String text) {
    setState(() => output = text);
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

    final resultAdd = add(2, 3);
    final hello1 = greet('Rani');
    final hello2 = greet('Rani', 'Mage');
    final spell1 = castSpell(spell: 'Fireball');
    final spell2 = castSpell(spell: 'Heal', manaCost: 5);
    final doubledTwice = applyTwice(3, (x) => x * 2);

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
    final monsters = ['Slime', 'Goblin', 'Wolf', 'Dragon'];
    final strongNames = monsters.where((m) => m.length > 4).toList();
    final labeled = monsters.map((m) => 'Monster: $m').toList();
    final hits = List.generate(3, (_) => rng.nextInt(10) + 1);
    final totalDamage = hits.fold<int>(0, (sum, x) => sum + x);

    final loot = {
      'gold': 120,
      'potion': 2,
      'gem': 1,
    };

    final level = rng.nextInt(5) + 1;
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
    final hero = HeroRpg(
      name: 'Rani',
      title: 'The Great',
      job: Job.mage,
      baseHp: 80,
      baseMp: 120,
    );
    final leveled = hero.levelUp(3);

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
    await Future.delayed(const Duration(seconds: 1));
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
    final baseDamage = rng.nextInt(10) + 1;
    final totalDamage = baseDamage + bonus;
    return 'Attack $monster, damage: $totalDamage (Base: $baseDamage + Bonus: $bonus)';
  }

  void demoAttackAction() {
    final atk1 = attack('Goblin');
    final atk2 = attack('Dragon', bonus: 5);

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

  // --- LATIHAN C: PARSING JSON ---
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

  // ================================================================
  // TANTANGAN 1: Tombol Heal — Immutable (return HeroRpg baru)
  // ================================================================
  void demoHealAction() {
    // Inisialisasi hero jika belum ada
    activeHero ??= const HeroRpg(
      name: 'Rani',
      title: 'The Great',
      job: Job.mage,
      baseHp: 80,
      baseMp: 120,
    );

    // heal() mengembalikan object HeroRpg baru dengan HP +10 (immutable style)
    activeHero = activeHero!.heal();

    show([
      '=== Tantangan 1: Heal Action ===',
      'Hero melakukan pemulihan...',
      'Status Baru: $activeHero',
      '',
      'Catatan:',
      '- heal() tidak mengubah object lama',
      '- Menghasilkan HeroRpg baru dengan HP +10 (immutable)',
      '- Tekan lagi untuk terus menambah HP',
    ].join('\n'));
  }

  // ================================================================
  // TANTANGAN 2: Tombol Inventory — Map item -> jumlah, format rapi
  // ================================================================
  void demoInventoryDisplay() {
    final items = {
      'Gold': 500,
      'Potion': 3,
      'Magic Scroll': 1,
      'Gem': 1,
    };

    final List<String> result = ['=== Tantangan 2: Hero Inventory ===', ''];
    items.forEach((key, value) {
      result.add('• $key : $value');
    });
    result.addAll([
      '',
      'Catatan:',
      '- Map<String, int> untuk menyimpan item dan jumlahnya',
      '- forEach() untuk iterasi setiap entry Map',
      '- Format "• item : jumlah" untuk tampilan rapi',
    ]);

    show(result.join('\n'));
  }

  // ================================================================
  // TANTANGAN 3: Extension toTitleCase() — pakai untuk nama monster
  // ================================================================
  void demoAttackWithTitleCase() {
    String monsterName = 'goblin'; // Input huruf kecil
    final damage = Random().nextInt(10) + 1;

    // toTitleCase() didefinisikan di extension StringExt pada hero.dart
    show([
      '=== Tantangan 3: String Extension ===',
      'Input awal (huruf kecil): $monsterName',
      'Setelah toTitleCase()   : ${monsterName.toTitleCase()}',
      '',
      'Attack ${monsterName.toTitleCase()}, damage: $damage',
      '',
      'Catatan:',
      '- extension StringExt on String { ... }',
      '- toTitleCase() = huruf pertama kapital, sisanya kecil',
      '- Dipakai langsung pada String biasa: monsterName.toTitleCase()',
    ].join('\n'));
  }

  // ================================================================
  // TANTANGAN 4: Async fetchShopItems() dengan Future.delayed 1 detik
  // ================================================================
  Future<void> fetchShopItems() async {
    show('🛒 Tantangan 4: Menghubungi pedagang shop...');

    // Simulasi network request dengan delay 1 detik
    await Future.delayed(const Duration(seconds: 1));

    const shopList = [
      'Iron Sword     - 100g',
      'Mana Potion    -  20g',
      'Antidote       -  15g',
      'Steel Shield   - 150g',
      'Magic Staff    - 200g',
    ];

    show([
      '=== Tantangan 4: Fetch Shop Items (Async) ===',
      'Barang tersedia hari ini:',
      '',
      ...shopList.map((item) => '• $item'),
      '',
      'Catatan:',
      '- fetchShopItems() adalah Future<void>',
      '- await Future.delayed(1 detik) = simulasi network',
      '- Tampilkan loading dulu, lalu hasil setelah selesai',
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade100,
                  ),
                ),
                // Tantangan 1
                ElevatedButton.icon(
                  onPressed: demoHealAction,
                  icon: const Icon(Icons.health_and_safety),
                  label: const Text('Heal (+10)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                  ),
                ),
                // Tantangan 2
                ElevatedButton.icon(
                  onPressed: demoInventoryDisplay,
                  icon: const Icon(Icons.backpack),
                  label: const Text('Inventory'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade100,
                  ),
                ),
                // Tantangan 3
                ElevatedButton.icon(
                  onPressed: demoAttackWithTitleCase,
                  icon: const Icon(Icons.text_fields),
                  label: const Text('TitleCase Atk'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal.shade100,
                  ),
                ),
                // Tantangan 4
                ElevatedButton.icon(
                  onPressed: fetchShopItems,
                  icon: const Icon(Icons.shopping_bag),
                  label: const Text('Fetch Shop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                  ),
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