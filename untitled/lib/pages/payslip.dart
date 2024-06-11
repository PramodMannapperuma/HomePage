import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Slip'),
        backgroundColor: Colors.white, // Dark purple theme color
      ),
      body: Column(
        children: [
          // Year selector
          Container(
            height: 60,
            color: Colors.blueAccent, // Dark blue theme color
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
                return Card(
                  color: Colors.white, // White theme color
                  child: Center(
                    child: Text(
                      _months[index],
                      style: TextStyle(
                        color: Color(0xff4d2880), // Dark purple text color
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
