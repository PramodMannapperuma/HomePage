import 'package:flutter/material.dart';
import 'package:untitled/auth/login.dart';
import 'package:untitled/pages/approval_task.dart';
import 'package:untitled/pages/attendance.dart';
import 'package:untitled/graphs/attendance_tracker.dart';
import 'package:untitled/pages/celebrations.dart';
import 'package:untitled/pages/employee.dart';
import 'package:untitled/pages/leave.dart';
import 'package:untitled/pages/msg.dart';
import 'package:untitled/pages/news.dart';
import 'package:untitled/pages/news_screen.dart';
import 'package:untitled/pages/payslip.dart';
import 'package:untitled/pages/policies.dart';
import 'package:untitled/pages/policy_pdf.dart';
import 'package:untitled/pages/profile.dart';
import 'package:untitled/pages/requests.dart';
import 'package:untitled/pages/task_screen.dart';
import 'package:untitled/pages/team_task.dart';
import 'package:untitled/pages/users.dart';
import 'package:untitled/profile/career_profile.dart';
import 'package:untitled/profile/contact_info.dart';
import 'package:untitled/profile/personal_info.dart';

import 'homepage.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => Login(),
  '/home': (context) => MyHomePage(),
  '/attendance': (context) => Attendance(),
  '/leave': (context) => Leave(),
  // '/news': (context) => News(),
  '/news_screen': (context) => NewsScreen(),
  '/policies': (context) => Policies(),
  '/requests': (context) => Requests(),
  '/celebrations': (context) => Celebrations(),
  '/personalInfo': (context) => PersonalInfo(),
  '/payslips': (context) => PaySlip(),
  '/approvalTask': (context) => ApprovalTask(),
  '/msg': (context) => Msg(),
  '/careerProfile': (context) => CareerProfile(),
  '/profile': (context) => ProfilePage(),
  '/contactInfo': (context) => ContactInfo(),
  '/attendanceTracker': (context) => AttendanceTracker(),
  '/taskScreen':(context) => TaskScreen(),
  '/taskList':(context) => TaskListScreen(),
  '/employeeScreen': (context) => EmployeeGridScreen(),
  '/employee':(context) => EmployeeScreen(),
  '/leavePolicy': (context) => LeavePolicy(),
};
