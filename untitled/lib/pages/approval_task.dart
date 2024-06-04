import 'package:flutter/material.dart';

class ApprovalTask extends StatefulWidget {
  const ApprovalTask({super.key});

  @override
  State<ApprovalTask> createState() => _ApprovalTaskState();
}

class _ApprovalTaskState extends State<ApprovalTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approval Task'),
      ),
      body: Center(
        child: Text('Welcome to Approval Task!'),
      ),
    );
  }
}
