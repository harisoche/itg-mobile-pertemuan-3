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

  // ──────────────────────────────────────────────────────
  // DEMO DASAR (tidak diubah)
  // ──────────────────────────────────────────────────────

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

  void demoFunctions() {
    int add(int a, int b) => a + b;

    String greet(String name, [String? title]) {
      if (title == null) return 'Halo $name!';
      return 'Halo $title $name!';
    }

    String castSpell({required String spell, int manaCost = 10}) {
      return '🪄 Cast $spell (mana -$manaCost)';
    }

    int applyTwice(int value, int Function(int) f) => f(f(value));

    show([
      '=== Functions ===',
      'add(2,3) => ${add(2, 3)}',
      'greet("Rani") => ${greet("Rani")}',
      'greet("Rani","Mage") => ${greet("Rani", "Mage")}',
      'castSpell(Fireball) => ${castSpell(spell: "Fireball")}',
      'castSpell(Heal,5) => ${castSpell(spell: "Heal", manaCost: 5)}',
      'applyTwice(3, x*2) => ${applyTwice(3, (x) => x * 2)}',
      '',
      'Catatan:',
      '- [param] = optional positional',
      '- {param} = named parameter',
      '- required = wajib diisi',
      '- Function bisa jadi parameter',
    ].join('\n'));
  }

  void demoCollections() {
    final rng = Random();
    final monsters = ['Slime', 'Goblin', 'Wolf', 'Dragon'];
    final strongNames = monsters.where((m) => m.length > 4).toList();
    final labeled = monsters.map((m) => 'Monster: $m').toList();
    final hits = List.generate(3, (_) => rng.nextInt(10) + 1);
    final totalDamage = hits.fold<int>(0, (sum, x) => sum + x);
    final loot = {'gold': 120, 'potion': 2, 'gem': 1};
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

  void demoClasses() {
    final hero = HeroRpg(
        name: 'Rani', title: 'The Great', job: Job.mage, baseHp: 80, baseMp: 120);
    final leveled = hero.levelUp(3);
    final json = {'name': 'Bima', 'job': 'warrior', 'baseHp': 120, 'baseMp': 40};
    final hero2 = HeroRpg.fromJson(json);

    show([
      '=== Class / Enum / Extension ===',
      'hero: $hero',
      'hero.power => ${hero.power}',
      'leveled (levelUp 3x): $leveled',
      '',
      'fromJson:',
      'hero2: $hero2',
      'hero2.title: ${hero2.title}',
      'hero2.jobLabel => ${hero2.job.label}',
      '',
      'Catatan:',
      '- constructor = cara membuat object',
      '- factory fromJson = bikin object dari Map',
      '- getter (power) = property hasil hitungan',
      '- enum = pilihan tetap (job)',
      '- extension = nambah kemampuan ke tipe',
    ].join('\n'));
  }

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
    if (rng.nextInt(5) == 0) throw Exception('Server sedang tidur 😴');
    const quests = [
      'Kalahkan 3 Goblin',
      'Cari 2 Potion',
      'Lindungi desa dari Wolf',
      'Temukan Gem tersembunyi',
    ];
    return quests[rng.nextInt(quests.length)];
  }

  void demoRandomLoot() {
    final loots = ['gold', 'potion', 'gem', 'scroll'];
    final pickedLoot = loots[Random().nextInt(loots.length)];
    show([
      '=== Random Loot ===',
      'Wow! Selamat, kamu menemukan: $pickedLoot 🎁',
      '',
      'Daftar loot tersedia: $loots',
      '',
      'Catatan:',
      '- Random().nextInt(n) → angka 0 s/d n-1',
      '- loots[index] → ambil item dari list',
    ].join('\n'));
  }

  String attack(String monster, {int bonus = 0}) {
    final base = Random().nextInt(10) + 1;
    final total = base + bonus;
    return 'Attack $monster, damage: $total (Base: $base + Bonus: $bonus)';
  }

  void demoAttackAction() {
    show([
      '=== Battle Log ===',
      attack('Goblin'),
      attack('Dragon', bonus: 5),
      '',
      'Catatan:',
      '- Random() untuk damage 1..10',
      '- Named parameter {int bonus = 0}',
      '- String interpolation untuk output',
    ].join('\n'));
  }

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
      'Nama  : ${hero.name}',
      'Gelar : ${hero.title}',
      'toString: $hero',
    ].join('\n'));
  }

  // ──────────────────────────────────────────────────────
  // PR 1: Heal (+10) — Immutable
  // Konsep: heal() mengembalikan HeroRpg BARU, bukan ubah object lama
  // ──────────────────────────────────────────────────────
  void demoHealAction() {
    // Buat hero awal (const / immutable)
    const hero = HeroRpg(
      name: 'Rani',
      title: 'The Great',
      job: Job.mage,
      baseHp: 80,
      baseMp: 120,
    );

    // heal() → return object BARU, hero lama tidak berubah
    final healedHero = hero.heal();

    show([
      '=== PR 1: Heal (+10) — Immutable ===',
      '',
      '[ Hero SEBELUM heal ]',
      'HP : ${hero.baseHp}',
      'MP : ${hero.baseMp}',
      '',
      '[ Hero SESUDAH heal() ]',
      'HP : ${healedHero.baseHp}  ← bertambah +10',
      'MP : ${healedHero.baseMp}',
      '',
      'hero lama masih hp=${hero.baseHp} (tidak berubah)',
      'healedHero adalah object BARU',
      '',
      'Catatan:',
      '- heal() tidak mutasi object asli',
      '- Selalu return HeroRpg baru (immutable style)',
    ].join('\n'));
  }

  // ──────────────────────────────────────────────────────
  // PR 2: Inventory — Map<item, jumlah>, format rapi
  // ──────────────────────────────────────────────────────
  void demoInventoryDisplay() {
    // Map item → jumlah sesuai requirement
    final Map<String, int> inventory = {
      'Gold':         150,
      'Health Potion': 3,
      'Mana Potion':   2,
      'Magic Scroll':  1,
      'Gem':           5,
    };

    final lines = <String>[
      '=== PR 2: Inventory ===',
      '',
      'Item               Jumlah',
      '─────────────────────────',
    ];

    // Iterasi Map dan tampilkan format rapi
    inventory.forEach((item, jumlah) {
      lines.add('${item.padRight(18)} $jumlah');
    });

    lines.addAll([
      '─────────────────────────',
      'Total item: ${inventory.length} jenis',
      '',
      'Catatan:',
      '- Map<String, int> = item → jumlah',
      '- forEach() untuk iterasi Map',
      '- padRight() untuk format kolom rapi',
    ]);

    show(lines.join('\n'));
  }

  // ──────────────────────────────────────────────────────
  // PR 3: Extension toTitleCase() — dipakai untuk nama monster
  // ──────────────────────────────────────────────────────
  void demoAttackWithTitleCase() {
    // Nama monster sengaja lowercase untuk demo extension
    const monsterName = 'goblin';
    final damage = Random().nextInt(10) + 1;

    // toTitleCase() dipakai untuk nama monster
    final formattedName = monsterName.toTitleCase();

    show([
      '=== PR 3: Extension toTitleCase() ===',
      '',
      'Input nama monster : "$monsterName"',
      'Setelah toTitleCase(): "$formattedName"',
      '',
      '⚔️  Attack $formattedName! Damage: $damage',
      '',
      'Contoh lain:',
      '"dragon"   → ${"dragon".toTitleCase()}',
      '"dark wolf" → ${"dark wolf".toTitleCase()}',
      '"oRC"      → ${"oRC".toTitleCase()}',
      '',
      'Catatan:',
      '- extension StringExt on String { ... }',
      '- Menambah method baru ke tipe String',
      '- Huruf pertama kapital, sisanya kecil',
    ].join('\n'));
  }

  // ──────────────────────────────────────────────────────
  // PR 4: fetchShopItems() — async dengan Future.delayed 1 detik
  // ──────────────────────────────────────────────────────
  Future<void> fetchShopItems() async {
    show('🛒 Menghubungi toko...\n⏳ Mohon tunggu 1 detik...');

    // Future.delayed 1 detik sesuai requirement
    await Future.delayed(const Duration(seconds: 1));

    const shopItems = [
      'Iron Sword    - 100 gold',
      'Mana Potion   -  20 gold',
      'Antidote      -  15 gold',
      'Steel Shield  - 200 gold',
      'Magic Staff   - 350 gold',
    ];

    show([
      '=== PR 4: fetchShopItems() ===',
      '',
      '✅ Data toko berhasil dimuat!',
      '',
      'Barang tersedia:',
      ...shopItems.map((item) => '  • $item'),
      '',
      'Catatan:',
      '- Future.delayed(Duration(seconds: 1))',
      '- async/await = non-blocking',
      '- UI tetap responsif saat menunggu',
    ].join('\n'));
  }

  // ──────────────────────────────────────────────────────
  // BUILD
  // ──────────────────────────────────────────────────────
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
                // ── Demo Dasar ──
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
                ElevatedButton.icon(
                  onPressed: demoRandomLoot,
                  icon: const Icon(Icons.card_giftcard),
                  label: const Text('Random Loot'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: demoAttackAction,
                  icon: const Icon(Icons.sports_martial_arts),
                  label: const Text('Attack Action'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: demoParsingJson,
                  icon: const Icon(Icons.data_object),
                  label: const Text('Parse JSON'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade100),
                ),
                // ── PR Buttons ──
                ElevatedButton.icon(
                  onPressed: demoHealAction,
                  icon: const Icon(Icons.health_and_safety),
                  label: const Text('Heal (+10)'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: demoInventoryDisplay,
                  icon: const Icon(Icons.backpack),
                  label: const Text('Inventory'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: demoAttackWithTitleCase,
                  icon: const Icon(Icons.text_fields),
                  label: const Text('TitleCase Atk'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade100),
                ),
                ElevatedButton.icon(
                  onPressed: fetchShopItems,
                  icon: const Icon(Icons.shopping_bag),
                  label: const Text('Fetch Shop'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100),
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
                        fontFamily: 'monospace', height: 1.35),
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