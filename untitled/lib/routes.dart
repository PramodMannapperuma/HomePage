import 'package:flutter/material.dart';
import 'package:untitled/Frontend/geolocation.dart';
import 'Frontend/graphs/attendance_tracker.dart';
import 'Frontend/pages/celebrations.dart';
import 'Frontend/pages/employee.dart';
import 'Frontend/pages/leave.dart';
import 'Frontend/pages/attendance.dart';
import 'Frontend/auth/login.dart';
import 'Frontend/homepage.dart';
import 'Frontend/pages/news_screen.dart';
import 'Frontend/pages/payslip.dart';
import 'Frontend/pages/policies.dart';
import 'Frontend/pages/policy_pdf.dart';
import 'Frontend/pages/profile.dart';
import 'Frontend/pages/requests.dart';
import 'Frontend/pages/task_screen.dart';
import 'Frontend/pages/team_task.dart';
import 'Frontend/pages/users.dart';
import 'Frontend/profile/career_profile.dart';
import 'Frontend/profile/contact_info.dart';
import 'Frontend/profile/personal_info.dart';

final Map<String, WidgetBuilder> routes = {
  '/login': (context) => Login(),
  '/home': (context) => MyHomePage(token: null,),
  '/attendance': (context) => Attendance(token: '',),
  '/leave': (context) => Leave(),
  // '/news': (context) => News(),
  '/geolocation': (context) => GeoLocation(token:''),
  '/news_screen': (context) => NewsScreen(),
  '/policies': (context) => Policies(),
  '/requests': (context) => Requests(),
  '/celebrations': (context) => Celebrations(),
  '/personalInfo': (context) => PersonalInfo(token: '',),
  '/payslips': (context) => PaySlip(),
  //'/approvalTask': (context) => ApprovalTask(),
  '/careerProfile': (context) => CareerProfile(token: '',),
  '/profile': (context) => ProfilePage(),
  '/contactInfo': (context) => ContactInfo(token: '',),
  '/attendanceTracker': (context) => AttendanceTracker(),
  '/taskScreen':(context) => TaskScreen(),
  '/taskList':(context) => TaskListScreen(),
  '/employeeScreen': (context) => EmployeeGridScreen(),
  '/employee':(context) => EmployeeScreen(),
  '/leavePolicy': (context) => LeavePolicy(),
  // '/dashboard':(context) => MainScreen(token: ''),
};
