// pay_slip.dart
import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';  // Adjust the import according to your project structure
import 'pay_slip_data.dart';  // Import the PaySlipData class
import 'pay_slip_details.dart';  // Import the new PaySlipDetails screen

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
    ),
    'Feb2023': PaySlipData(
      month: 'Feb',
      year: '2023',
      basicSalary: '1000',
      allowances: '200',
      deductions: '50',
      netPay: '1150',
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
            color: Color(0xff4d2880),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(10, (index) => _yearButton(2023 + index)),
            ),
          ),
          // Pay Slip table
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Three months per row
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
                    color: Colors.white, // White theme color
                    child: Center(
                      child: Text(
                        _months[index],
                        style: TextStyle(
                          color: Color(0xff4d2880), // Dark purple text color
                        ),
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
        child: Text(
          year.toString(),
          style: TextStyle(
            color: _selectedYear == year.toString() ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
