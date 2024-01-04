import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_assignment.dart';

class AssignmentListPage extends StatefulWidget {
  @override
  _AssignmentListPageState createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment List'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddAssignmentPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('assignments').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var assignments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              var assignment = assignments[index].data();
              return _buildAssignmentTile(
                AssignmentType.values[
                    assignment['assignmentType'] ?? AssignmentType.quiz.index],
                assignment['conductingDate'] ?? 'No Date',
                assignment['time'] ?? 'No Time',
                assignment['moduleName'] ?? 'No Module Name',
                assignment['moduleCode'] ?? 'No Module Code',
                assignmentId: assignments[index].id,
                isCompleted: assignment['completed'] ?? false,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildAssignmentTile(AssignmentType assignmentType,
      String conductingDate, String time, String moduleName, String moduleCode,
      {required String assignmentId, required bool isCompleted}) {
    return Card(
      color: isCompleted ? Colors.greenAccent : Colors.white,
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          '$moduleName - $moduleCode',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Assignment Type: ${assignmentTypeToString(assignmentType)}'),
            Text('Date: $conductingDate'),
            Text('Time: $time'),
          ],
        ),
        trailing: isCompleted
            ? null
            : IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  _markAssignmentCompleted(assignmentId);
                  _showCongratulatoryMessage();
                },
              ),
      ),
    );
  }

  void _markAssignmentCompleted(String assignmentId) async {
    await FirebaseFirestore.instance
        .collection('assignments')
        .doc(assignmentId)
        .update({'completed': true});
  }

  void _showCongratulatoryMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text('You have completed your assignment.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
