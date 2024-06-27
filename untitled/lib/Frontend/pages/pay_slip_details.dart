import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
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
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.cloud_download, color: Colors.white),
              label: Text(
                'Download Pay Slip',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.background, // Deep purple color
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                // TODO: Implement the download functionality
              },
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
            icon != null ? Icon(icon, color:AppColors.background) : SizedBox(),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.background,
              ),
            ),
            Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? AppColors.background : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
