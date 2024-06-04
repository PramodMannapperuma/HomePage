import 'package:flutter/material.dart';
import 'package:untitled/home/pages/approval_task.dart';
import 'package:untitled/home/pages/attendance.dart';
import 'package:untitled/home/pages/celebrations.dart';
import 'package:untitled/home/pages/msg.dart';
import 'package:untitled/home/pages/news.dart';
import 'package:untitled/home/pages/payslip.dart';
import 'package:untitled/home/pages/policie.dart';
import 'package:untitled/home/pages/profile_view.dart';
import 'package:untitled/home/pages/requests.dart';
import 'package:untitled/homepage.dart';

import 'home/pages/leave.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (context) => MyHomePage(),
  '/attendance': (context) => Attendance(),
  '/leave': (context) => Leave(),
  '/news': (context) => News(),
  '/policies': (context) => Policies(),
  '/requests': (context) => Requests(),
  '/celebrations': (context) => Celebrations(),
  '/profile': (context) => ProfileView(),
  '/payslips': (context) => PaySlip(),
  '/approvalTask': (context) => ApprovalTask(),
  '/msg': (context) => Msg(),
};