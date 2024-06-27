import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class Leave extends StatefulWidget {
  const Leave({super.key});

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  String? selectedLeaveType;
  DateTime? startDate;
  DateTime? endDate;
  String? description;
  String? notifyEmployee;

  // Error messages map
  final Map<String, String?> errorMessages = {
    'description': null,
    'startDate': null,
    'endDate': null,
    'notifyEmployee': null,
  };
  final leaveTypes = ['Annual Leave', 'Casual Leave', 'Medical Leave'];
  final leaveDetails = {
    'Entitled': 30,
    'Utilized': 10,
    'Pending': 2,
    'Available': 18,
  };

  final additionalDetails = {
    'Attendance': 200,
    'Leave': 12,
    'No Pay': 3,
    'Working Days': 220,
    'Leave Balance': 18,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Leaves',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: CustomSidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: 8),
              // Text('Leave Chart',
              //     style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.purple)),
              // SizedBox(height: 8),
              // SizedBox(
              //   height: 200,
              //   child: LeaveBar(
              //     leaveData: leaveDetails.values.toList(),
              //   ),
              // ),
              // SizedBox(
              //   height: 4,
              // ),
              // Divider(
              //   thickness: 1,
              // ),
              // SizedBox(height: 4),
              // Leave Details Section
              Text('Leave Details',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background)),
              SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: leaveDetails.entries.map((entry) {
                  return _buildDetailCard(entry.key, entry.value);
                }).toList(),
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 5),

              Text('Request Leaves',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.flight,
                            size: 25, color: AppColors.background),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Annual',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.beach_access,
                            size: 25, color: AppColors.background),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Casual',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.local_hospital,
                            size: 25, color: AppColors.background),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Medical',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  errorText: errorMessages['description'],
                ),
                maxLines: 3,
                  onChanged: (value) {
                    setState(() {
                      notifyEmployee = value;
                      if (value.isNotEmpty) {
                        errorMessages['description'] = null;
                      }
                    });
                  },
              ),

              SizedBox(height: 5),
              Row(
                children: [
                  Text('Dates',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        startDate = null;
                        endDate = null;
                      });
                    },
                    child: Text('Clear'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != startDate)
                          setState(() {
                            startDate = picked;
                            errorMessages['startDate'] = null;
                          });
                      },
                      child: Text(
                        startDate == null
                            ? 'Start Date'
                            : '${startDate!.toLocal()}'.split(' ')[0],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != endDate)
                          setState(() {
                            endDate = picked;
                            errorMessages['endDate'] = null;
                          });
                      },
                      child: Text(
                        endDate == null
                            ? 'Due Date'
                            : '${endDate!.toLocal()}'.split(' ')[0],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Notify Employee',
                  border: OutlineInputBorder(),
                  errorText: errorMessages['notifyEmployee'],
                ),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    notifyEmployee = value;
                    if (value.isNotEmpty) {
                      errorMessages['notifyEmployee'] = null;
                    }
                  });
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // Navigate back
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    // Validate the form
    if (_validateForm()) {
      // Form is valid, save or process data
      Navigator.pushNamed(context, '/home');
    } else {
      // Form is not valid, show error messages
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Validation Error'),
          content: Text('Please fill all required fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  bool _validateForm() {
    bool isValid = true;

    // Validate description
    if (description == null || description!.isEmpty) {
      errorMessages['description'] = 'Please enter a description';
      isValid = false;
    } else {
      errorMessages['description'] = null;
    }

    // Validate startDate
    if (startDate == null) {
      errorMessages['startDate'] = 'Please select start date';
      isValid = false;
    } else {
      errorMessages['startDate'] = null;
    }

    // Validate endDate
    if (endDate == null) {
      errorMessages['endDate'] = 'Please select end date';
      isValid = false;
    } else {
      errorMessages['endDate'] = null;
    }

    // Validate notifyEmployee
    if (notifyEmployee == null || notifyEmployee!.isEmpty) {
      errorMessages['notifyEmployee'] = 'Please enter notification details';
      isValid = false;
    } else {
      errorMessages['notifyEmployee'] = null;
    }

    setState(() {}); // Update UI with error messages

    return isValid;
  }

  Widget _buildDetailCard(String title, int value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.background,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '$value days',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveBar extends StatefulWidget {
  final List<int> leaveData;
  const LeaveBar({super.key, required this.leaveData});

  @override
  State<LeaveBar> createState() => _LeaveBarState();
}

class _LeaveBarState extends State<LeaveBar> {
  late BarData myBarData;

  @override
  void initState() {
    super.initState();
    myBarData = BarData(
      entitledAmount: widget.leaveData[0].toDouble(),
      utilizedAmount: widget.leaveData[1].toDouble(),
      pendingAmount: widget.leaveData[2].toDouble(),
      availableAmount: widget.leaveData[3].toDouble(),
    );
    myBarData.initializeBarData();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        maxY: 40,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: true),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(
                  x: data.x,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(0),
                      width: 50,
                    )
                  ],
                ))
            .toList(),
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear,
    );
  }
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double entitledAmount;
  final double utilizedAmount;
  final double pendingAmount;
  final double availableAmount;

  BarData(
      {required this.entitledAmount,
      required this.pendingAmount,
      required this.utilizedAmount,
      required this.availableAmount});

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: entitledAmount),
      IndividualBar(x: 1, y: utilizedAmount),
      IndividualBar(x: 2, y: pendingAmount),
      IndividualBar(x: 3, y: availableAmount),
    ];
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: AppColors.background,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  switch (value.toInt()) {
    case 0:
      return SideTitleWidget(
          child: const Text('Entitled', style: style), axisSide: meta.axisSide);
    case 1:
      return SideTitleWidget(
          child: const Text('Utilized', style: style), axisSide: meta.axisSide);
    case 2:
      return SideTitleWidget(
          child: const Text('Pending', style: style), axisSide: meta.axisSide);
    case 3:
      return SideTitleWidget(
          child: const Text('Available', style: style),
          axisSide: meta.axisSide);
    default:
      return SideTitleWidget(
          child: const Text('Unknown', style: style), axisSide: meta.axisSide);
  }
}
