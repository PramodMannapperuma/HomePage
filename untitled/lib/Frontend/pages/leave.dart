import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import 'package:untitled/Backend/models/leave_balance_model.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class Leave extends StatefulWidget {
  final String token;

  const Leave({Key? key, required this.token}) : super(key: key);

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  List<LeaveBalanceData>? leaveBalanceData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLeaveBalance();
  }

  Future<void> _fetchLeaveBalance() async {
    try {
      final data = await ApiService().fetchLeaveBalance(widget.token);
      setState(() {
        leaveBalanceData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching leave balance: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

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
      drawer: CustomSidebar(
        token: widget.token,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Leave Details',
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4d2880),
                ),
              ),
              SizedBox(height: 16),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : leaveBalanceData != null && leaveBalanceData!.isNotEmpty
                      ? Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: _buildLeaveTable(),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            'No leave balance data available.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
              SizedBox(height: 20),
              Divider(thickness: 1),
              SizedBox(height: 20),
              Text(
                'Request Leaves',
                style: TextStyle(
                  fontSize: 18.5,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4d2880),
                ),
              ),
              SizedBox(height: 20),
              RequestLeavesRow(),
              SizedBox(height: 20),
              RequestLeavesForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveTable() {
    return DataTable(
      columnSpacing: 16,
      columns: [
        DataColumn(label: Text('Leave')),
        DataColumn(label: Text('Entitled')),
        DataColumn(label: Text('Utilized')),
        DataColumn(label: Text('Pending')),
        DataColumn(label: Text('Available')),
      ],
      rows: leaveBalanceData!.map((data) {
        return DataRow(cells: [
          DataCell(Text(data.leave)),
          DataCell(Text(data.total.toString())),
          DataCell(Text(data.utilized.toString())),
          DataCell(Text(data.pending.toString())),
          DataCell(Text(data.available.toString())),
        ]);
      }).toList(),
    );
  }
}

class RequestLeavesRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        LeaveRequestOption(icon: Icons.flight, label: 'Annual'),
        LeaveRequestOption(icon: Icons.beach_access, label: 'Casual'),
        LeaveRequestOption(icon: Icons.local_hospital, label: 'Medical'),
      ],
    );
  }
}

class LeaveRequestOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const LeaveRequestOption({Key? key, required this.icon, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade300,
          child: Icon(icon, size: 25, color: AppColors.background),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class RequestLeavesForm extends StatefulWidget {
  @override
  _RequestLeavesFormState createState() => _RequestLeavesFormState();
}

class _RequestLeavesFormState extends State<RequestLeavesForm> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
            errorText: errorMessages['description'],
          ),
          maxLines: 3,
          onChanged: (value) {
            setState(() {
              description = value;
              if (value.isNotEmpty) {
                errorMessages['description'] = null;
              }
            });
          },
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              'Dates',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != startDate) {
                        setState(() {
                          startDate = picked;
                          errorMessages['startDate'] = null;
                        });
                      }
                    },
                    child: Text(
                      startDate == null
                          ? 'Start Date'
                          : '${startDate!.toLocal()}'.split(' ')[0],
                    ),
                  ),
                  if (errorMessages['startDate'] != null)
                    Text(
                      errorMessages['startDate']!,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != endDate) {
                        setState(() {
                          endDate = picked;
                          errorMessages['endDate'] = null;
                        });
                      }
                    },
                    child: Text(
                      endDate == null
                          ? 'End Date'
                          : '${endDate!.toLocal()}'.split(' ')[0],
                    ),
                  ),
                  if (errorMessages['endDate'] != null)
                    Text(
                      errorMessages['endDate']!,
                      style: TextStyle(color: Colors.red),
                    ),
                ],
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
                  Navigator.pop(context);
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
    );
  }

  void _submitForm() {
    // Validate the form
    if (_validateForm()) {
      // Form is valid, save or process data
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Leave Request Submitted'),
          content: Text('Your leave request has been successfully submitted.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Navigate back
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
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
}

class LeaveBar extends StatelessWidget {
  final List<int> leaveData;
  const LeaveBar({super.key, required this.leaveData});

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
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: leaveData[0].toDouble(),
                color: AppColors.background,
                borderRadius: BorderRadius.circular(0),
                width: 50,
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: leaveData[1].toDouble(),
                color: AppColors.background,
                borderRadius: BorderRadius.circular(0),
                width: 50,
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: leaveData[2].toDouble(),
                color: AppColors.background,
                borderRadius: BorderRadius.circular(0),
                width: 50,
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: leaveData[3].toDouble(),
                color: AppColors.background,
                borderRadius: BorderRadius.circular(0),
                width: 50,
              ),
            ],
          ),
        ],
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear,
    );
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
