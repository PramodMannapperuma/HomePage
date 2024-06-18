// pay_slip.dart
import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';  // Adjust the import according to your project structure
import 'pay_slip_data.dart';  // Import the PaySlipData class
import 'pay_slip_details.dart';  // Import the new PaySlipDetails screen
import 'package:untitled/app_colors.dart';

class PaySlip extends StatefulWidget {
  const PaySlip({Key? key}) : super(key: key);

  @override
  _PaySlipState createState() => _PaySlipState();
}

class _PaySlipState extends State<PaySlip> {
  // Current selected year
  String _selectedYear = '2023';

  // Dummy data for payslip months
  final List<String> _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  // Dummy data for pay slips
  final Map<String, PaySlipData> paySlipData = {
    'Jan2023': PaySlipData(
      month: 'Jan',
      year: '2023',
      basicSalary: '1000',
      allowances: '200',
      deductions: '50',
      netPay: '1150',
      employeeNumber: 'EMP12345',
      deductionDetails: 'Tax: 30, Insurance: 20',
    ),
    'Feb2023': PaySlipData(
      month: 'Feb',
      year: '2023',
      basicSalary: '1000',
      allowances: '200',
      deductions: '50',
      netPay: '1150',
      employeeNumber: 'EMP12345',
      deductionDetails: 'Tax: 30, Insurance: 20',
    ),
    // Add more data for other months and years
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Pay Slips',
        showActions: true,
        showLeading: true,
        context: context,
      ),

      body: Column(
        children: [
          // Year selector
          Container(
            height: 60,
            color: AppColors.background,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (index) => _yearButton(2023 + index)),
            ),
          ),
          // Pay Slip table
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _months.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the PaySlipDetails screen
                    String key = '${_months[index]}$_selectedYear';
                    PaySlipData? data = paySlipData[key];
                    if (data != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaySlipDetails(paySlipData: data),
                        ),
                      );
                    } else {
                      // Handle case where no data is available for the selected month and year
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('No data available for ${_months[index]} $_selectedYear')),
                      );
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt, // Change this icon to any of the above suggestions
                            color: AppColors.background,
                            size: 30,
                          ),
                          SizedBox(height: 8),
                          Text(
                            _months[index],
                            style: TextStyle(
                              color: AppColors.background,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Year button widget
  Widget _yearButton(int year) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedYear = year.toString();
        });
      },
      child: Container(
        width: 75,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          year.toString(),
          style: TextStyle(
            color: _selectedYear == year.toString() ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
