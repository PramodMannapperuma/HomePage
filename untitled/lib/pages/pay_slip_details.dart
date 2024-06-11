import 'package:flutter/material.dart';
import 'pay_slip_data.dart';

class PaySlipDetails extends StatelessWidget {
  final PaySlipData paySlipData;

  const PaySlipDetails({Key? key, required this.paySlipData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Slip of ${paySlipData.month} ${paySlipData.year}'),
        backgroundColor: Color(0xFF4d2880), // Dark purple color
        foregroundColor: Colors.white, // Text color
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PaySlipItem(label: 'Basic Salary', value: paySlipData.basicSalary),
            PaySlipItem(label: 'Allowances', value: paySlipData.allowances),
            PaySlipItem(label: 'Deductions', value: paySlipData.deductions),
            PaySlipItem(label: 'Net Pay', value: paySlipData.netPay, isHighlight: true),
          ],
        ),
      ),
    );
  }
}

class PaySlipItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isHighlight;

  const PaySlipItem({
    Key? key,
    required this.label,
    required this.value,
    this.isHighlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2880),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? Color(0xFF4d2880) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
