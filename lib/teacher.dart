// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:workapp/size_config.dart';
import 'package:workapp/style/app_style.dart';
import 'package:workapp/todo_list.dart';

import 'login.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 7,
            ),
            child: Column(
              children: const [
                
              ],
            ),
          ),
          
        ],
      ),
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 26, 115, 231),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            backgroundColor: Color.fromARGB(255, 26, 115, 231),
            color: Colors.black,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 18, 97, 131),
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

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}

