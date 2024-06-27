// import 'package:flutter/material.dart';
//
//
// // Profile overview section
// Container(
// padding: EdgeInsets.all(16),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(8),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 2,
// blurRadius: 5,
// offset: Offset(0, 3), // changes position of shadow
// ),
// ],
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Profile Overview',
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// ),
// ),
// SizedBox(height: 10),
// Row(
// children: [
// _buildProfileInfoItem(
// 'Hours Worked', '150', Colors.blue),
// _buildProfileInfoItem(
// 'Tasks Completed', '30', Colors.green),
// ],
// ),
// Row(
// children: [
// _buildProfileInfoItem('Projects', '5', Colors.orange),
// _buildProfileInfoItem('Overdue Tasks', '2', Colors.red),
// ],
// ),
// ],
// ),
// ),
// SizedBox(height: 20),


// Tasks section
// Container(
// padding: EdgeInsets.all(16),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(8),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 2,
// blurRadius: 5,
// offset: Offset(0, 3), // changes position of shadow
// ),
// ],
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Tasks',
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// ),
// ),
// SizedBox(height: 10),
// _buildTaskItem(
// 'Design new UI', 'Deadline: Tomorrow', Colors.orange),
// _buildTaskItem('Update Flutter dependencies',
// 'Deadline: Today', Colors.red),
// ],
// ),
// ),