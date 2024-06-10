import 'dart:math';
import 'package:flutter/material.dart';

class AttendanceTracker extends StatelessWidget {
  final List<AttendanceRecord> data = generateSampleData();

  @override
  Widget build(BuildContext context) {
    return Container( // Wrap Scaffold with Container
      height: MediaQuery.of(context).size.height / 2.8, // Specify a fixed height
      child: Scaffold(
        appBar: AppBar(
          title: Text('Attendance'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AttendanceGraph(data: data),
        ),
      ),
    );
  }
}

class AttendanceGraph extends StatelessWidget {
  final List<AttendanceRecord> data;

  const AttendanceGraph({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.7 ,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10, // Show 7 days a week
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final attendance = data[index];
              return Container(
                decoration: BoxDecoration(
                  color: _getColorForStatus(attendance.status),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text(
                    '${attendance.date.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color _getColorForStatus(int status) {
    switch (status) {
      case 0:
        return Colors.red[700]!; // Absent
      case 1:
        return Colors.green[700]!; // Attended
      case 2:
        return Colors.yellow[700]!; // Leave
      // case 3:
      //   return Colors.blue[700]!; // Holiday
      default:
        return Colors.grey[300]!;
    }
  }
}

class AttendanceRecord {
  final DateTime date;
  final int status;

  AttendanceRecord({required this.date, required this.status});
}

List<AttendanceRecord> generateSampleData() {
  final now = DateTime.now();
  final random = Random();
  return List.generate(60, (index) {
    return AttendanceRecord(
      date: now.subtract(Duration(days: index)),
      status: random.nextInt(3), // Random status from 0 to 3
    );
  }).reversed.toList();
}