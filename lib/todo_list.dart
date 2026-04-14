import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final IconData icon;
  final String title;
  final String reward; 

  
  const TodoList({
    super.key, 
    required this.icon, 
    required this.title, 
    required this.reward
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 195, 206, 255).withAlpha(14),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withAlpha(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 10,
              offset: const Offset(0, 4)
            )
          ]
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 35, 31, 255).withAlpha(12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color.fromARGB(255, 30, 11, 201),),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold),), 
                  const SizedBox(height: 2,),
                  Text(reward), 
                ],
              ), 
            )
          ],
        ),
      ),
    );
  }
}