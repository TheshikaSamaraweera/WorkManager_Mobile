// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';



class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => BottmBar();
}

class BottmBar extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            color: Colors.black,
            activeColor: const Color.fromARGB(255, 156, 29, 29),
            tabBackgroundColor: Color.fromARGB(255, 255, 255, 255),
            gap: 8,
            padding: EdgeInsets.all(12),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.search,
                text: "Search",
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
              ),
              GButton(
                icon: Icons.list,
                text: "To-Do",
              ),
            ],
          ),
        ),
      ),
    
    );
  }


}






