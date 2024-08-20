import 'package:flutter/material.dart';
import 'package:untitled/Frontend/geolocation.dart';
import 'Frontend/graphs/attendance_tracker.dart';
import 'Frontend/pages/approval.dart';
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
import 'Frontend/home/Dashbord.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments as String?;

  switch (settings.name) {
    case '/login':
      return MaterialPageRoute(builder: (context) => Login());
    case '/home':
      return MaterialPageRoute(builder: (context) => MyHomePage(token: args));
    case '/dashbord':
      return MaterialPageRoute(builder: (context) => MainScreen(token: args ?? ''));
    case '/attendance':
      return MaterialPageRoute(
          builder: (context) => Attendance(token: args ?? ''));
    case '/leave':
      return MaterialPageRoute(builder: (context) => Leave(token: args ?? ''));
    case '/geolocation':
      return MaterialPageRoute(
          builder: (context) => GeoLocation(token: args ?? ''));
    case '/news_screen':
      return MaterialPageRoute(builder: (context) => NewsScreen());
    case '/policies':
      return MaterialPageRoute(
          builder: (context) => Policies(
                token: args ?? '',
              ));
    case '/requests':
      return MaterialPageRoute(builder: (context) => Requests());
    case '/celebrations':
      return MaterialPageRoute(builder: (context) => Celebrations());
    case '/personalInfo':
      return MaterialPageRoute(
          builder: (context) => PersonalInfo(token: args ?? ''));
    case '/payslips':
      return MaterialPageRoute(builder: (context) => PaySlip());
    case '/careerProfile':
      return MaterialPageRoute(
          builder: (context) => CareerProfile(token: args ?? ''));
    case '/profile':
      return MaterialPageRoute(
          builder: (context) => ProfilePage(token: args ?? ''));
    case '/contactInfo':
      return MaterialPageRoute(
          builder: (context) => ContactInfo(token: args ?? ''));
    case '/attendanceTracker':
      return MaterialPageRoute(builder: (context) => AttendanceTracker());
    case '/taskScreen':
      return MaterialPageRoute(builder: (context) => TaskScreen());
    case '/taskList':
      return MaterialPageRoute(builder: (context) => TaskListScreen());
    case '/employeeScreen':
      return MaterialPageRoute(builder: (context) => EmployeeGridScreen());
    case '/employee':
      return MaterialPageRoute(builder: (context) => EmployeeScreen(token: args ?? ''));
    case '/approval':
      return MaterialPageRoute(
          builder: (context) => ApprovalScreen(
                token: args ?? '',
              ));
    case '/leavePolicy':
      return MaterialPageRoute(
          builder: (context) => LeavePolicy(
                token: args ?? '',
              ));
    default:
      return MaterialPageRoute(builder: (context) => Login()); // Default route
  }
}
