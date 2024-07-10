import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class Task {
  final String title;
  final String description;
  final String status;
  final double progress;
  final String dateRange;
  final String? documentUrl; // Optional document URL for completed tasks

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.progress,
    required this.dateRange,
    this.documentUrl, // Optional parameter for document URL
  });
}

class TaskScreen extends StatelessWidget {
  final List<Task> tasks = [
    Task(
      title: 'Salary Confirmation',
      description: 'Request salary confirmation letter',
      status: 'Pending',
      progress: 0.4,
      dateRange: '10th May - 15th May',
    ),
    Task(
      title: 'VISA Letter',
      description: 'Request VISA letter',
      status: 'Pending',
      progress: 0.5,
      dateRange: '10th May - 15th May',
    ),
    Task(
      title: 'Letter to Bank for loans',
      description: 'Request loan approval letter',
      status: 'Pending',
      progress: 0.6,
      dateRange: '10th May - 15th May',
    ),
    Task(
      title: 'Task',
      description: 'General task description',
      status: 'Completed', // Example completed task
      progress: 1.0, // Progress 1.0 indicates completed
      dateRange: '10th May - 15th May',
      documentUrl: 'https://example.com/document', // Example document URL
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Tasks',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true, // Show back button instead of hamburger icon
      ),
      drawer: CustomSidebar(token: '',),
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task List',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tasks[index].title,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${(tasks[index].progress * 100).toStringAsFixed(0)}%',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: tasks[index].status == 'Completed'
                                      ? Colors.green // Completed status color
                                      : AppColors.background,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            tasks[index].description,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tasks[index].status,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: tasks[index].status == 'Completed'
                                      ? Colors.green // Completed status color
                                      : AppColors.background,
                                ),
                              ),
                              Text(
                                tasks[index].dateRange,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: AppColors.background,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0), // Add some space
                          if (tasks[index].status == 'Completed' &&
                              tasks[index].documentUrl != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.download),
                                  onPressed: () {
                                    // Handle download action here
                                    print('Downloading ${tasks[index].title}');
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
