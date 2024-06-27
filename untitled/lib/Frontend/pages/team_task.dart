import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';

class TeamTask {
  final String title;
  final String teamMembers;
  final String status;
  final double progress;
  final String dateRange;
  final List<String> memberImages;

  TeamTask({
    required this.title,
    required this.teamMembers,
    required this.status,
    required this.progress,
    required this.dateRange,
    required this.memberImages,
  });
}

class TaskListScreen extends StatelessWidget {
  final List<TeamTask> tasks = [
    TeamTask(
      title: 'HR Manager iOS App',
      teamMembers: 'Team members',
      status: 'In progress',
      progress: 0.8,
      dateRange: '11th Jul - 11th Aug',
      memberImages: [
        'assets/member1.png',
        'assets/member2.png',
        'assets/member3.png'
      ],
    ),
    TeamTask(
      title: 'HR Manager Android App',
      teamMembers: 'Team members',
      status: 'In progress',
      progress: 0.6,
      dateRange: '12th Jul - 12th Aug',
      memberImages: [
        'assets/member4.png',
        'assets/member5.png',
        'assets/member6.png'
      ],
    ),
    TeamTask(
      title: 'HR Manager Web App',
      teamMembers: 'Team members',
      status: 'In progress',
      progress: 0.9,
      dateRange: '12th Jul - 12th Aug',
      memberImages: [
        'assets/member4.png',
        'assets/member5.png',
        'assets/member6.png'
      ],
    ),
    TeamTask(
      title: 'HR Manager Desktop App',
      teamMembers: 'Team members',
      status: 'In progress',
      progress: 0.3,
      dateRange: '12th Jul - 12th Aug',
      memberImages: [
        'assets/member4.png',
        'assets/member5.png',
        'assets/member6.png'
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Team Tasks',
          showActions: true,
          showLeading: false,
          context: context),
      body: Container(
        // color: Colors.grey[200],
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Team',
              style: TextStyle(
                fontSize: 15.0,
                color: AppColors.background,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
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
                                  color: AppColors.background,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              for (var imageUrl in tasks[index].memberImages)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                    radius: 16.0,
                                    backgroundImage: AssetImage(imageUrl),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tasks[index].teamMembers,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                tasks[index].status,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: tasks[index].status == 'In progress'
                                      ? Colors.purple
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            tasks[index].dateRange,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[600],
                            ),
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
