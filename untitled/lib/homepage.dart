import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'home/module_grid.dart';
import 'user_section.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Homepage', showActions: true),
      body:
      // Foreground content
      const Column(
        children: [
          UserSection(),
          ModuleGrid(),
        ],
      ),
    );
  }
}
