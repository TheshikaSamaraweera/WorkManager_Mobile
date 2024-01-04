import 'package:flutter/material.dart';
import 'add_task.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Navigate to the AddTaskPage and wait for a result
              String newTask = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTaskPage()),
              );

              // Handle the result (newTask) as needed, e.g., update your task list
              if (newTask != null) {
                // Perform logic to update your task list
                // tasks.add(newTask);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Delete work action
              // Implement the logic to delete tasks
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Task 1'),
            // Add more properties or actions as needed for each task
          ),
          ListTile(
            title: Text('Task 2'),
            // Add more properties or actions as needed for each task
          ),
          // Add more ListTiles for additional tasks
        ],
      ),
    );
  }
}
