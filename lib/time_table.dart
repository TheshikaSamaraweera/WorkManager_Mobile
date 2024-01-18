import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class Task {
  final String title;
  final String time;

  Task({required this.title, required this.time});
}

class WeekTimeTablePage extends StatefulWidget {
  @override
  _WeekTimeTablePageState createState() => _WeekTimeTablePageState();
}

class _WeekTimeTablePageState extends State<WeekTimeTablePage> {
  late DateTime selectedDay;
  late List<Task> events;

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    events = [];
    fetchTasks(selectedDay);
  }

  Future<void> fetchTasks(DateTime date) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');

    QuerySnapshot<Object?> querySnapshot = await timetable
        .where('date', isEqualTo: date)
        .get() as QuerySnapshot<Object?>;

    List<Task> tasks = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Task(title: data['title'], time: data['time']);
    }).toList();

    setState(() {
      events = tasks;
    });
  }

  void _navigateToDayTimeTablePage(DateTime day) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DayTimeTablePage(selectedDay: day),
      ),
    ).then((_) {
      // Fetch tasks again after returning from DayTimeTablePage
      fetchTasks(selectedDay);
    });
  }

  Future<void> saveTask(DateTime date, Task task) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');
    await timetable.add({
      'date': date,
      'title': task.title,
      'time': task.time,
    });

    // Fetch tasks again to update the list
    fetchTasks(date);
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String time = '';

        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time'),
                onChanged: (value) {
                  time = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (title.isNotEmpty && time.isNotEmpty) {
                  Task newTask = Task(title: title, time: time);
                  await saveTask(selectedDay, newTask);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDayContainer(DateTime day) {
    return GestureDetector(
      onTap: () {
        _navigateToDayTimeTablePage(day);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Center(
          child: Text(
            DateFormat('MMM d').format(day),
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Time Table'),
      ),
      body: Column(
        children: [
          // Weekdays
          Container(
            height: 40, // Adjust the height as needed
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.2,
              ),
              itemCount: 7,
              itemBuilder: (context, index) {
                DateTime day = selectedDay.add(Duration(days: index));
                return _buildDayContainer(day);
              },
            ),
          ),
          // Events
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(events[index].title),
                subtitle: Text(events[index].time),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}

class DayTimeTablePage extends StatefulWidget {
  final DateTime selectedDay;

  DayTimeTablePage({Key? key, required this.selectedDay}) : super(key: key);

  @override
  _DayTimeTablePageState createState() => _DayTimeTablePageState();
}

class _DayTimeTablePageState extends State<DayTimeTablePage> {
  late List<Task> selectedTasks;

  @override
  void initState() {
    super.initState();
    selectedTasks = [];
    fetchTasks(widget.selectedDay);
  }

  Future<void> fetchTasks(DateTime date) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');
    QuerySnapshot<Object?> querySnapshot = await timetable
        .where('date', isEqualTo: date)
        .get() as QuerySnapshot<Object?>;

    List<Task> tasks = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Task(title: data['title'], time: data['time']);
    }).toList();

    setState(() {
      selectedTasks = tasks;
    });
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String time = '';

        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Time'),
                onChanged: (value) {
                  time = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (title.isNotEmpty && time.isNotEmpty) {
                  Task newTask = Task(title: title, time: time);
                  await saveTask(widget.selectedDay, newTask);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveTask(DateTime date, Task task) async {
    CollectionReference timetable =
        FirebaseFirestore.instance.collection('timetable');
    await timetable.add({
      'date': date,
      'title': task.title,
      'time': task.time,
    });
    fetchTasks(date); // Fetch tasks again to update the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Daily Time Table - ${DateFormat('MMMM d, y').format(widget.selectedDay)}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedTasks[index].title),
                  subtitle: Text(selectedTasks[index].time),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeekTimeTablePage(),
    );
  }
}
