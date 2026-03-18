import 'dart:math';
import 'package:flutter/material.dart';
import '../models/hero.dart';

extension StringTitleCase on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.isEmpty ? word : word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
  }
}

class DartLabPage extends StatefulWidget {
  const DartLabPage({super.key});

  @override
  State<DartLabPage> createState() => _DartLabPageState();
}

class _DartLabPageState extends State<DartLabPage> {
  String output = 'Tekan tombol untuk melihat demo Dart!';
  HeroRpg hero = HeroRpg(name: 'Rani', job: Job.warrior, baseHp: 50, baseMp: 20, inventory: {'Potion': 3, 'Elixir': 1, 'Gold': 100});

  void show(String text) {
    setState(() => output = text);
  }

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

  void demoCollections() {
    final rng = Random();
    final monsters = ['Slime', 'Goblin', 'Wolf', 'Dragon'];
    final strongNames = monsters.where((m) => m.length > 4).map((m) => m.toTitleCase()).toList();
    final labeled = monsters.map((m) => 'Monster: ${m.toTitleCase()}').toList();
    final hits = List.generate(3, (_) => rng.nextInt(10) + 1);
    final totalDamage = hits.fold<int>(0, (sum, x) => sum + x);
    final loot = {'gold': 120, 'potion': 2, 'gem': 1};
    final level = rng.nextInt(5) + 1;
    final rewards = ['🎁 Daily Reward', if (level >= 3) '⭐ Bonus Reward (level >= 3)', for (final item in loot.keys) '• $item'];

    show([
      '=== Collections (List/Map) ===',
      'monsters: ${monsters.map((m) => m.toTitleCase()).toList()}',
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
    final heroInstance = HeroRpg(name: 'Rani', job: Job.mage, baseHp: 80, baseMp: 120);
    final leveled = heroInstance.levelUp(3);
    final json = {'name': 'Bima', 'job': 'warrior', 'baseHp': 120, 'baseMp': 40};
    final hero2 = HeroRpg.fromJson(json);

    show([
      '=== Class / Enum / Extension ===',
      'hero: $heroInstance',
      'hero.power => ${heroInstance.power}',
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
    const quests = ['Kalahkan 3 Goblin', 'Cari 2 Potion', 'Lindungi desa dari Wolf', 'Temukan Gem tersembunyi'];
    return quests[rng.nextInt(quests.length)];
  }

  void demoHeal() {
    final healedHero = hero.heal(10);
    setState(() => hero = healedHero);
    show('✅ Heal +10 HP\nSekarang: $hero');
  }

  void demoInventory() {
    final lines = hero.inventory.entries.map((e) => '• ${e.key}: ${e.value}').toList();
    show(['=== Inventory ===', ...lines].join('\n'));
  }

  Future<void> demoShopItems() async {
    show('⏳ Mengambil item dari shop...');
    try {
      final items = await fetchShopItems();
      show(['=== Shop Items ===', for (final item in items) '• ${item.toTitleCase()}'].join('\n'));
    } catch (e) {
      show('❌ Gagal ambil item: $e');
    }
  }

  Future<List<String>> fetchShopItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['potion', 'elixir', 'sword', 'shield'];
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
                ElevatedButton.icon(onPressed: demoVariablesAndNullSafety, icon: const Icon(Icons.bolt), label: const Text('Variables + Null')),
                ElevatedButton.icon(onPressed: demoFunctions, icon: const Icon(Icons.functions), label: const Text('Functions')),
                ElevatedButton.icon(onPressed: demoCollections, icon: const Icon(Icons.list_alt), label: const Text('Collections')),
                ElevatedButton.icon(onPressed: demoClasses, icon: const Icon(Icons.shield), label: const Text('Class + Enum')),
                ElevatedButton.icon(onPressed: () => demoAsyncAwait(), icon: const Icon(Icons.cloud_download), label: const Text('Async/Await')),
                ElevatedButton.icon(onPressed: demoHeal, icon: const Icon(Icons.healing), label: const Text('Heal +10 HP')),
                ElevatedButton.icon(onPressed: demoInventory, icon: const Icon(Icons.backpack), label: const Text('Inventory')),
                ElevatedButton.icon(onPressed: demoShopItems, icon: const Icon(Icons.store), label: const Text('Shop Items')),
                OutlinedButton.icon(onPressed: () => show('Tekan tombol untuk melihat demo Dart!'), icon: const Icon(Icons.refresh), label: const Text('Clear')),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
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