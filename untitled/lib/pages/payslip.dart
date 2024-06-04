import 'package:flutter/material.dart';

class PaySlip extends StatefulWidget {
  const PaySlip({super.key});

  @override
  State<PaySlip> createState() => _PaySlipState();
}

class _PaySlipState extends State<PaySlip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PaySlip'),
      ),
      body: Center(
        child: Text('Welcome to PaySlip!'),
      ),
    );
  }
}
