import 'dart:math';
import 'package:flutter/material.dart';
import '../models/hero.dart';

// TANTANGAN 3: Extension untuk String
extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}

class DartLabPage extends StatefulWidget {
  const DartLabPage({super.key});

  @override
  State<DartLabPage> createState() => _DartLabPageState();
}

class _DartLabPageState extends State<DartLabPage> {
  String output = 'Tekan tombol untuk melihat demo Dart!';
  
  // Untuk Tantangan 1 & 2: Kita perlu menyimpan state hero dan inventory
  HeroRpg? myHero;
  Map<String, int> inventory = {
    'potion': 3,
    'elixir': 1,
    'gold': 500,
    'key': 2,
  };
  int currentHp = 75;
  final int maxHp = 100;

  @override
  void initState() {
    super.initState();
    myHero = HeroRpg(
      name: 'Salma',
      job: Job.mage,
      baseHp: maxHp,
      baseMp: 150,
    );
  }

  void show(String text) {
    setState(() => output = text);
  }

  // TANTANGAN 1: Tombol Heal (Immutable - return Hero baru)
  void demoHeal() {
    if (myHero == null) {
      show('Hero belum diinisialisasi!');
      return;
    }
    
    final oldHero = myHero!;
    final oldHp = currentHp;
    
    // Simulasi heal dengan menambah HP
    final newHp = currentHp + 10 > maxHp ? maxHp : currentHp + 10;
    
    setState(() {
      currentHp = newHp;
    });
    
    show(
      '=== HEAL +10 (IMMUTABLE CONCEPT) ===\n'
      'Hero: ${oldHero.name} (${oldHero.job.label})\n'
      'HP lama: $oldHp\n'
      'HP baru: $newHp\n'
      'Max HP: $maxHp\n'
      '\n'
      'Konsep Immutable:\n'
      '- Object HeroRpg tidak berubah (final fields)\n'
      '- State HP disimpan terpisah di widget\n'
      '- Jika HeroRpg dibuat ulang, akan object baru\n'
      '\n'
      'Contoh immutable: method levelUp() mengembalikan object baru\n'
      'Hero sekarang: ${oldHero.power} power'
    );
  }

  // TANTANGAN 2: Tombol Inventory dengan format rapi
  void demoInventory() {
    if (myHero == null) {
      show('Hero belum diinisialisasi!');
      return;
    }
    
    final hero = myHero!;
    
    final buffer = StringBuffer();
    buffer.writeln('=== INVENTORY ${hero.name.toUpperCase()} ===');
    buffer.writeln('');
    
    if (inventory.isEmpty) {
      buffer.writeln('Inventory kosong');
    } else {
      // Urutkan item berdasarkan nama
      final sortedKeys = inventory.keys.toList()..sort();
      for (final item in sortedKeys) {
        final jumlah = inventory[item];
        final itemStr = item.padRight(12);
        final jumlahStr = jumlah.toString().padLeft(3);
        buffer.writeln('  $itemStr: $jumlahStr pcs');
      }
    }
    
    buffer.writeln('');
    buffer.writeln('=' * 30);
    
    // Hitung total item
    final totalItems = inventory.values.fold(0, (sum, qty) => sum + qty);
    buffer.writeln('Total item    : $totalItems pcs');
    buffer.writeln('HP Hero       : $currentHp/$maxHp');
    buffer.writeln('Job           : ${hero.job.label}');
    buffer.writeln('Base Power    : ${hero.power}');
    
    show(buffer.toString());
  }

  // Method untuk menambah item ke inventory (utility)
  void addItemToInventory(String item, int jumlah) {
    setState(() {
      inventory[item] = (inventory[item] ?? 0) + jumlah;
    });
  }

  // TANTANGAN 3: Demo Title Case untuk nama monster
  void demoTitleCase() {
    final monsters = [
      'goblin',
      'slime raksasa',
      'dragon api',
      'wolf hitam',
      'orc hutan',
      'serpent laut',
    ];
    
    final random = Random();
    final monster = monsters[random.nextInt(monsters.length)];
    
    final loots = ['Gold', 'Potion', 'Gem', 'Elixir', 'Key'];
    final loot = loots[random.nextInt(loots.length)];
    final amount = random.nextInt(3) + 1;
    
    String result = '=== EXTENSION: toTitleCase() ===\n\n';
    result += 'Bertemu monster: ${monster.toTitleCase()}\n';
    result += 'Monster dikalahkan!\n';
    result += 'Mendapat loot: $loot $amount pcs\n\n';
    result += 'Contoh penggunaan toTitleCase():\n';
    result += '(mengubah huruf pertama setiap kata menjadi kapital)\n\n';
    
    for (var m in monsters) {
      result += '  "${m.padRight(15)}" -> "${m.toTitleCase()}"\n';
    }
    
    // Tambahkan item ke inventory
    addItemToInventory(loot.toLowerCase(), amount);
    result += '\nItem loot ditambahkan ke inventory!';
    
    show(result);
  }

  // TANTANGAN 4: Async function dengan Future.delayed
  Future<Map<String, int>> fetchShopItems() async {
    await Future.delayed(const Duration(seconds: 1));
    
    final random = Random();
    return {
      'potion': random.nextInt(5) + 3,
      'elixir': random.nextInt(3) + 1,
      'ether': random.nextInt(2) + 1,
      'antidote': random.nextInt(4) + 2,
      'scroll': random.nextInt(2) + 1,
    };
  }

  Future<void> demoShop() async {
    show('Menghubungi toko... (loading 1 detik)');
    
    try {
      final shopItems = await fetchShopItems();
      
      final buffer = StringBuffer();
      buffer.writeln('=== SHOP ITEMS ===');
      buffer.writeln('');
      
      shopItems.forEach((item, jumlah) {
        final itemStr = item.padRight(10);
        final jumlahStr = jumlah.toString().padLeft(2);
        buffer.writeln('  $itemStr: $jumlahStr pcs');
      });
      
      buffer.writeln('');
      buffer.writeln('=' * 30);
      buffer.writeln('Async dengan Future:');
      buffer.writeln('- Future.delayed 1 detik');
      buffer.writeln('- await ambil data');
      buffer.writeln('- try/catch handling error');
      
      // Beli 1 potion otomatis
      if (shopItems.containsKey('potion') && shopItems['potion']! > 0) {
        addItemToInventory('potion', 1);
        buffer.writeln('');
        buffer.writeln('Membeli 1 Potion dari toko!');
      }
      
      show(buffer.toString());
      
    } catch (e) {
      show('Gagal mengambil data shop: $e');
    }
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
      'guildUpper: $guildUpper',
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
      return 'Cast $spell (mana -$manaCost)';
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
      'Daily Reward',
      if (level >= 3) 'Bonus Reward (level >= 3)',
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
    final hero = HeroRpg(name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);
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
    show('Mengambil quest dari server...');

    try {
      final quest = await fetchQuest();
      show([
        '=== Async/Await ===',
        'Quest didapat!',
        quest,
        '',
        'Catatan:',
        '- Future = nilai yang datang belakangan',
        '- await = tunggu Future selesai',
        '- try/catch = tangani error',
      ].join('\n'));
    } catch (e) {
      show('Gagal ambil quest: $e');
    }
  }

  Future<String> fetchQuest() async {
    await Future.delayed(const Duration(seconds: 1));
    final rng = Random();
    if (rng.nextInt(5) == 0) {
      throw Exception('Server sedang tidur');
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
                // TANTANGAN 1: Tombol Heal
                ElevatedButton.icon(
                  onPressed: demoHeal,
                  icon: const Icon(Icons.favorite),
                  label: const Text('Heal +10'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                // TANTANGAN 2: Tombol Inventory
                ElevatedButton.icon(
                  onPressed: demoInventory,
                  icon: const Icon(Icons.inventory),
                  label: const Text('Inventory'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                // TANTANGAN 3: Tombol Title Case
                ElevatedButton.icon(
                  onPressed: demoTitleCase,
                  icon: const Icon(Icons.title),
                  label: const Text('Title Case'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
                // TANTANGAN 4: Tombol Shop Async
                ElevatedButton.icon(
                  onPressed: demoShop,
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Shop Async'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
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