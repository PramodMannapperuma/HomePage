import 'package:flutter/material.dart';

class Leave extends StatefulWidget {
  const Leave({super.key});

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave'),
      ),
      body: Center(
        child: Text('Welcome to Leave!'),
      ),
    );
  }
}
