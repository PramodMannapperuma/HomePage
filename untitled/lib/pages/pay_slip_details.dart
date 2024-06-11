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
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PaySlipItem(
              label: 'Employee Number',
              value: paySlipData.employeeNumber,
              icon: Icons.badge_outlined,
            ),
            PaySlipItem(
              label: 'Basic Salary',
              value: paySlipData.basicSalary,
              icon: Icons.account_balance_wallet_outlined,
            ),
            PaySlipItem(
              label: 'Allowances',
              value: paySlipData.allowances,
              icon: Icons.monetization_on_outlined,
            ),
            PaySlipItem(
              label: 'Deductions',
              value: paySlipData.deductions,
              icon: Icons.remove_circle_outline,
            ),
            PaySlipItem(
              label: 'Deductions Details',
              value: paySlipData.deductionDetails,
              icon: Icons.info_outline,
            ),
            PaySlipItem(
              label: 'Net Pay',
              value: paySlipData.netPay,
              isHighlight: true,
              icon: Icons.attach_money,
            ),
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
  final IconData? icon;

  const PaySlipItem({
    Key? key,
    required this.label,
    required this.value,
    this.isHighlight = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 18),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon != null ? Icon(icon, color: Color(0xFF4d2880)) : SizedBox(),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4d2880),
              ),
            ),
            Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
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
