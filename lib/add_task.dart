import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  TextEditingController _taskController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(labelText: 'Task'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time (HH:mm)'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String task = _taskController.text;
                String date = _dateController.text;
                String time = _timeController.text;

                await FirebaseFirestore.instance.collection('tasks').add({
                  'taskName': task,
                  'date': date,
                  'time': time,
                });

                // Navigate back to the previous screen
                Navigator.of(context).pop();
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      _dateController.text = picked.toLocal().toString().split(' ')[0];
    }
  }
}
