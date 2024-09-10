import 'package:flutter/material.dart';
import 'package:untitled/Backend/APIs/Apis.dart'; // Ensure the correct path
import '../../Backend/models/leave_model.dart'; // Ensure the correct path
import '../app_bar.dart'; // Reuse the custom app bar from the policies.dart file

class LeaveDetailsScreen extends StatefulWidget {
  final String token;

  const LeaveDetailsScreen({super.key, required this.token});

  @override
  _LeaveDetailsScreenState createState() => _LeaveDetailsScreenState();
}

class _LeaveDetailsScreenState extends State<LeaveDetailsScreen> {
  Future<List<LeaveData>> _fetchLeaveData() async {
    DateTime today = DateTime
        .now(); // You can change this to fetch for any specific range or all data
    List<LeaveData> allLeaveData =
        await ApiService().fetchLeaveData(widget.token, today);

    // Filter the list to only include records where status == 'leave'
    return allLeaveData.where((leave) => leave.status == 'leave').toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Reuse the customAppBar
      appBar: customAppBar(
        title: 'Pending leave details',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true, // Show back button instead of menu icon
      ),
      body: FutureBuilder<List<LeaveData>>(
        future: _fetchLeaveData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No leave data available.'));
          }

          List<LeaveData> leaveDetails = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: leaveDetails.length,
              itemBuilder: (context, index) {
                LeaveData leave = leaveDetails[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Leave Date: ${leave.date}',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff4d2880),
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${leave.status}',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        if (leave.comment != null && leave.comment!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Comment: ${leave.comment}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
