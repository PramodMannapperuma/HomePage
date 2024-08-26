// import 'package:flutter/material.dart';
// import '../app_bar.dart';
// import '../styles/app_colors.dart';
// import '../styles/sidebar.dart';

// class Task {
//   final String title;
//   final String description;
//   final String status;
//   final double progress;
//   final String dateRange;
//   final String? documentUrl; // Optional document URL for completed tasks

//   Task({
//     required this.title,
//     required this.description,
//     required this.status,
//     required this.progress,
//     required this.dateRange,
//     this.documentUrl, // Optional parameter for document URL
//   });
// }

// class TaskScreen extends StatelessWidget {
//   final List<Task> tasks = [
//     Task(
//       title: 'Salary Confirmation',
//       description: 'Request salary confirmation letter',
//       status: 'Pending',
//       progress: 0.4,
//       dateRange: '10th May - 15th May',
//     ),
//     Task(
//       title: 'VISA Letter',
//       description: 'Request VISA letter',
//       status: 'Pending',
//       progress: 0.5,
//       dateRange: '10th May - 15th May',
//     ),
//     Task(
//       title: 'Letter to Bank for loans',
//       description: 'Request loan approval letter',
//       status: 'Pending',
//       progress: 0.6,
//       dateRange: '10th May - 15th May',
//     ),
//     Task(
//       title: 'Task',
//       description: 'General task description',
//       status: 'Completed', // Example completed task
//       progress: 1.0, // Progress 1.0 indicates completed
//       dateRange: '10th May - 15th May',
//       documentUrl: 'https://example.com/document', // Example document URL
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(
//         title: 'Tasks',
//         showActions: true,
//         showLeading: true,
//         context: context,
//         showBackButton: true, // Show back button instead of hamburger icon
//       ),
//       drawer: CustomSidebar(token: '',),
//       body: Container(
//         color: Colors.grey[200],
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Task List',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: tasks.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     elevation: 4.0,
//                     margin: EdgeInsets.symmetric(vertical: 10.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 tasks[index].title,
//                                 style: TextStyle(
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 '${(tasks[index].progress * 100).toStringAsFixed(0)}%',
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: tasks[index].status == 'Completed'
//                                       ? Colors.green // Completed status color
//                                       : AppColors.background,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 4.0),
//                           Text(
//                             tasks[index].description,
//                             style: TextStyle(
//                               fontSize: 16.0,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           SizedBox(height: 8.0),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 tasks[index].status,
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: tasks[index].status == 'Completed'
//                                       ? Colors.green // Completed status color
//                                       : AppColors.background,
//                                 ),
//                               ),
//                               Text(
//                                 tasks[index].dateRange,
//                                 style: TextStyle(
//                                   fontSize: 14.0,
//                                   color: AppColors.background,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 16.0), // Add some space
//                           if (tasks[index].status == 'Completed' &&
//                               tasks[index].documentUrl != null)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.download),
//                                   onPressed: () {
//                                     // Handle download action here
//                                     print('Downloading ${tasks[index].title}');
//                                   },
//                                 ),
//                               ],
//                             ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';
import '../../Backend/models/cover_up_detail.dart';

class TaskScreen extends StatefulWidget {
  final String token;

  const TaskScreen({Key? key, required this.token}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];
  List<CoverUpDetail> coverUps = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final fetchedTasks = await _fetchTasks(); // Placeholder for fetching tasks
      final fetchedCoverUps = await ApiService.getCoverUpDetails(widget.token, 4); // Example employeeId

      setState(() {
        tasks = fetchedTasks;
        coverUps = fetchedCoverUps;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  Future<List<Task>> _fetchTasks() async {
    // Example method to fetch tasks. Replace with actual implementation.
    return [
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
        status: 'Completed',
        progress: 1.0,
        dateRange: '10th May - 15th May',
        documentUrl: 'https://example.com/document',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Tasks',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: CustomSidebar(
        token: widget.token,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  SectionHeader(title: 'Task List'),
                  tasks.isEmpty
                      ? Center(child: Text('No tasks found'))
                      : TaskList(tasks: tasks),
                  SectionHeader(title: 'Cover-Up Approvals'),
                  coverUps.isEmpty
                      ? Center(child: Text('No cover-up approvals found'))
                      : CoverUpList(coverUps: coverUps, token: widget.token),
                ],
              ),
            ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff4d2880),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: ListTile(
            contentPadding: EdgeInsets.all(15.0),
            title: Text(
              tasks[index].title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description: ${tasks[index].description}',
                  style: TextStyle(fontSize: 15.0),
                ),
                Text(
                  'Status: ${tasks[index].status}',
                  style: TextStyle(fontSize: 15.0),
                ),
                Text(
                  'Date Range: ${tasks[index].dateRange}',
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
            trailing: tasks[index].documentUrl != null
                ? IconButton(
                    icon: Icon(Icons.download),
                    onPressed: () {
                      print('Downloading ${tasks[index].title}');
                    },
                  )
                : null,
          ),
        );
      },
    );
  }
}

class CoverUpList extends StatelessWidget {
  final List<CoverUpDetail> coverUps;
  final String token;

  const CoverUpList({Key? key, required this.coverUps, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: coverUps.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: ListTile(
            contentPadding: EdgeInsets.all(15.0),
            title: Text(
              'Date: ${coverUps[index].date}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Leave Type: ${coverUps[index].leaveType}', style: TextStyle(fontSize: 15.0)),
                Text('Time: ${coverUps[index].time}', style: TextStyle(fontSize: 15.0)),
                Text('Reason: ${coverUps[index].reason}', style: TextStyle(fontSize: 15.0)),
                Text('Covered By: ${coverUps[index].extra}', style: TextStyle(fontSize: 15.0)),
              ],
            ),
            trailing: CoverActionButton(
              token: token,
              id: coverUps[index].id,
            ),
          ),
        );
      },
    );
  }
}

class Task {
  final String title;
  final String description;
  final String status;
  final double progress;
  final String dateRange;
  final String? documentUrl;

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.progress,
    required this.dateRange,
    this.documentUrl,
  });
}

class CoverActionButton extends StatelessWidget {
  final String token;
  final int id;

  const CoverActionButton({Key? key, required this.token, required this.id}) : super(key: key);

  Future<void> _showSuccessDialog(BuildContext context, String message, String action) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                action == "approve" ? Icons.check_circle : Icons.error,
                color: action == "approve" ? Colors.green : Colors.red,
              ),
              SizedBox(width: 10),
              Text('Success'),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCommentDialog(BuildContext context, String action) async {
    TextEditingController commentController = TextEditingController();
    bool isLoading = false;
    String? message;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Comment'),
              content: isLoading
                  ? Center(
                      child: SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    )
                  : TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: 'Enter your comment',
                      ),
                    ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss the dialog
                  },
                ),
                TextButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      await ApiService().approveCoverUp(
                        token,
                        [id],
                        action,
                        commentController.text,
                      );
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(dialogContext).pop(); // Dismiss the dialog
                      await _showSuccessDialog(context, 'Cover-up $action successfully!', action);
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                        message = 'Failed to submit. Please try again.';
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "approve"),
          child: Text(
            'Accept',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: 4.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "reject"),
          child: Text(
            'Decline',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
