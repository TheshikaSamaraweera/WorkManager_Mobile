import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_lab.dart';

class LabListPage extends StatefulWidget {
  @override
  _LabListPageState createState() => _LabListPageState();
}

class _LabListPageState extends State<LabListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab List'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddLabPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('labs').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var labs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: labs.length,
            itemBuilder: (context, index) {
              var lab = labs[index].data();
              return _buildLabTile(
                lab['labNumber'] ?? 'No Lab Number',
                lab['moduleName'] ?? 'No Module Name',
                lab['moduleCode'] ?? 'No Module Code',
                lab['conductingDate'] ?? 'No Date',
                lab['time'] ?? 'No Time',
                labId: labs[index].id,
                isCompleted: lab['completed'] ?? false,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLabTile(
    String labNumber,
    String moduleName,
    String moduleCode,
    String conductingDate,
    String time, {
    required String labId,
    required bool isCompleted,
  }) {
    Color cardColor = isCompleted ? Colors.greenAccent : Colors.white;
    String completionNote =
        isCompleted ? 'Completed' : ''; // Note to display when completed

    return Card(
      color: cardColor,
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
            Text('Lab Number: $labNumber'),
            Text('Module Name: $moduleName'),
            Text('Module Code: $moduleCode'),
            Text('Conducting Date: $conductingDate'),
            Text('Time: $time'),
            Text(completionNote, style: TextStyle(color: Colors.green)),
          ],
        ),
        trailing: isCompleted
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.undo),
                    onPressed: () {
                      _markLabNotCompleted(labId);
                      _showUndoMessage();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteLab(labId);
                    },
                  ),
                ],
              )
            : IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  _markLabCompleted(labId);
                  _showCompletionMessage();
                },
              ),
      ),
    );
  }

  void _markLabCompleted(String labId) async {
    await FirebaseFirestore.instance
        .collection('labs')
        .doc(labId)
        .update({'completed': true});
  }

  void _markLabNotCompleted(String labId) async {
    await FirebaseFirestore.instance
        .collection('labs')
        .doc(labId)
        .update({'completed': false});
  }

  void _deleteLab(String labId) async {
    await FirebaseFirestore.instance.collection('labs').doc(labId).delete();
  }

  void _showUndoMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lab Marked as Not Completed'),
          content: Text('You have marked the lab as not completed.'),
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

  void _showCompletionMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lab Completed'),
          content: Text('You have completed the lab.'),
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
