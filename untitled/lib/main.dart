import 'package:flutter/material.dart';
import 'package:untitled/auth/login.dart';
import 'package:untitled/homepage.dart';
import 'package:untitled/pages/attendance.dart';
import 'package:untitled/pages/leave.dart';
import 'package:untitled/pages/profile.dart';
import 'package:untitled/pages/personal_info.dart';
import 'package:untitled/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
        useMaterial3: true,
      ),
      home: ProfilePage(),
      routes: routes,
    );
  }
}


