import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../../Backend/models/att_model.dart';
import '../app_bar.dart'; // Import the custom app bar
import '../styles/sidebar.dart'; // Import sidebar for drawer if needed

class PendingAttendanceScreen extends StatefulWidget {
  final String token;

  const PendingAttendanceScreen({super.key, required this.token});

  @override
  _PendingAttendanceScreenState createState() => _PendingAttendanceScreenState();
}

class _PendingAttendanceScreenState extends State<PendingAttendanceScreen> {

  Future<List<AttendanceData>> _fetchAllAttendance() async {
    Set<AttendanceData> uniqueAttendance = {}; // Use a set to ensure uniqueness
    DateTime today = DateTime.now();
    int daysToFetch = 30; // Adjust this number based on how far back you want to fetch

    for (int i = 0; i < daysToFetch; i++) {
      DateTime targetDate = today.subtract(Duration(days: i));
      try {
        // Fetch attendance for a single day
        List<AttendanceData> dailyAttendance =
        await ApiService().fetchAttendanceData(widget.token, targetDate);

        // Filter the fetched data for status == "pending" and add only unique records
        dailyAttendance
            .where((attendance) => attendance.status == 'pending')
            .forEach((attendance) => uniqueAttendance.add(attendance));
      } catch (e) {
        // Optionally handle errors for individual days
        print('Failed to fetch attendance for $targetDate: $e');
      }
    }

    return uniqueAttendance.toList(); // Convert set to list before returning
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Pending Attendance details',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      body: FutureBuilder<List<AttendanceData>>(
        future: _fetchAllAttendance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No pending attendance requests.'));
          }

          List<AttendanceData> pendingAttendance = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: pendingAttendance.length,
              itemBuilder: (context, index) {
                AttendanceData attendance = pendingAttendance[index];

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
                          'Attendance Date: ${attendance.date}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4d2880),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${attendance.status}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black, // Amber color for status text
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (attendance.comment != null &&
                            attendance.comment!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Comment: ${attendance.comment}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
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
