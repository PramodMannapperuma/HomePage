import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';

class Task {
  final String title;
  final String status;
  final String downloadUrl;

  Task({required this.title, required this.status, required this.downloadUrl});
}

class TaskScreen extends StatelessWidget {
  final List<Task> tasks = [
    Task(title: 'Salary Confirmation', status: 'Approved', downloadUrl: 'url1'),
    Task(title: 'VISA Letter', status: 'Pending', downloadUrl: 'url2'),
    Task(title: 'Letter to Bank for loans', status: 'Approved', downloadUrl: 'url3'),
    Task(title: 'task', status: 'Pending', downloadUrl: 'url4'),
  ];

  TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Task', showActions: true, showLeading: false, context: context),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4.0,
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(8.0),
                title: Text(
                  tasks[index].title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        tasks[index].status == 'Approved'
                            ? Icons.check_circle
                            : Icons.pending,
                        color: tasks[index].status == 'Approved'
                            ? Colors.green
                            : Colors.orange,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        tasks[index].status,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: tasks[index].status == 'Approved'
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: tasks[index].status == 'Approved'
                    ? IconButton(
                  icon: Icon(Icons.download),
                  color: Colors.purple,
                  onPressed: () {
                    // handle download logic
                    print('Downloading from ${tasks[index].downloadUrl}');
                  },
                )
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}