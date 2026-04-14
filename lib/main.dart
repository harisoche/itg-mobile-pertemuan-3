import 'package:flutter/material.dart';
import 'header_widget.dart';
import 'chip_widget.dart';
import 'todo_list.dart';



void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final List<Map<String, dynamic>> questList = const [
    {
      "icon": Icons.done,
      "title": "Kalahkan 3 Goblin",
      "reward": "Reward: 10+ Gold"
    },
    {
      "icon": Icons.eco,
      "title": "Kumpulkan 5 Herbal",
      "reward": "Reward: 2+ Potion"
    },
    {
      "icon": Icons.star,
      "title": "Kalahkan Bos Goblin",
      "reward": "Reward: 100+ Gold"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        title: Text("Adventure Rank RPG",
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 47, 71, 255),
      ),
      body: Padding(padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: .start,
         children: [
            HeaderWidget(name: "Qwerty", role: "Penjajah", level: 0),
            SizedBox(height: 8),
            Row(
              spacing: 8,
              children: [
                ChipWidget(
                  icon: Icons.favorite,
                  color: Colors.red,
                  label: "HP: ",
                  value: "90",
                  borderColor: Colors.red,
                  backgroundColor: Colors.red.withAlpha(30),
                ),
                ChipWidget(
                  icon: Icons.auto_awesome,
                  color: Colors.blue,
                  label: "MP: ",
                  value: "120",
                  borderColor: Colors.blue,
                  backgroundColor: Colors.blue.withAlpha(30),
                ),
                ChipWidget(
                  icon: Icons.paid,
                  color: const Color.fromARGB(255, 202, 165, 0),
                  label: "Gold: ",
                  value: "140",
                  borderColor: const Color.fromARGB(255, 70, 71, 0),
                  backgroundColor: const Color.fromARGB(255, 185, 230, 25).withAlpha(30),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(),
            SizedBox(height: 8),
            Text(
              "Today's Quests",
              style: TextStyle(
                fontWeight: .bold,
                fontSize: 20,
                color: const Color.fromARGB(221, 46, 46, 46),
              ),
            ),
            ...questList.map((quest) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0), 
                            child: TodoList(
                              icon: quest["icon"],
                              title: quest["title"],
                              reward: quest["reward"],
                    ),
                );
            }),
          ],
        ),
      ),
    );
  }
}
