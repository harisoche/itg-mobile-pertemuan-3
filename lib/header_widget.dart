import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String name;
  final String role;
  final int level;
  
  const HeaderWidget({
    super.key,
    required this.name,
    required this.role,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 132, 137, 197),
              const Color.fromARGB(255, 47, 57, 252)
            ],
            // begin: Alignment.topLeft,
            // end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(24),
          
        ),
        child: Row(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
                  ),
                ),
                Positioned(
                  right: -2,
                  bottom: 1,
                  child:Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    child: Text("Level 999",
                      style: TextStyle(
                        color: const Color.fromRGBO(252, 47, 47, 1),
                        fontSize: 11,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                )
              ],
            ),
            SizedBox(width: 13,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Avalin",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("Ksatria Terkuat di Dunia",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 69, 66, 95),
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                  ),)
                ],
              )
            )
          ],
        ),
      // ),
    );
  }
}