import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:workapp/home_page.dart';
import 'package:workapp/student.dart';
import 'package:workapp/teacher.dart';
import 'package:workapp/widget/bottom_bar.dart';

import 'home.dart';
=======
import 'package:workapp/time_table.dart';
>>>>>>> f134189ce57513e066c019828f6a8ef6db4e612c
import 'register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
      ),
      home: WeekTimeTablePage()
    );
  }
}
