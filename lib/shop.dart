Future<List<String>> fetchShopItems() async {
  await Future.delayed(const Duration(seconds: 1));
  return [
    'Health Potion - 50 gold',
    'Iron Sword - 150 gold',
    'Magic Shield - 200 gold',
    'Elixir - 300 gold',
  ];
}