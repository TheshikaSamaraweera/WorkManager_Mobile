import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workapp/lab_list.dart';
import 'package:workapp/todo_list.dart';

import 'assignment.dart';

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
      home: LabListPage(),
    );
  }
}
