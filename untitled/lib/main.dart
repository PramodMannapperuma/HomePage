import 'package:flutter/material.dart';
import 'package:untitled/routes.dart';
import 'Frontend/auth/login.dart';

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
      onGenerateRoute: generateRoute,
      initialRoute: '/login',
    );
  }
}

