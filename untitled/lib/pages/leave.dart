import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Leave extends StatefulWidget {
  const Leave({super.key});

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  String? selectedLeaveType;
  DateTime? startDate;
  DateTime? endDate;
  String? reason;

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

  List<charts.Series<LeaveDetail, String>> _createLeaveDetailsData() {
    final data = leaveDetails.entries
        .map((entry) => LeaveDetail(entry.key, entry.value))
        .toList();

    return [
      charts.Series<LeaveDetail, String>(
        id: 'Leave Details',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (LeaveDetail detail, _) => detail.type,
        measureFn: (LeaveDetail detail, _) => detail.days,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Leaves',
          showActions: true,
          showLeading: false,
          context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text('Leave Chart',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
              SizedBox(height: 8),
              SizedBox(
                height: 150,
                child: charts.BarChart(
                  _createLeaveDetailsData(),
                  animate: true,
                ),
              ),
              SizedBox(height: 4,),
              Divider(thickness: 1,),
              SizedBox(height: 4),
              // Leave Details Section
              Text('Leave Details',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
              SizedBox(height: 16),
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
              SizedBox(height: 8,),
              Divider(thickness: 1,),
              SizedBox(height: 8),

              Text('Request Leaves',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.flight, size: 25, color: Colors.black87),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Annual',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.beach_access, size: 25, color: Colors.black54),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Casual',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.local_hospital, size: 25, color: Colors.purple),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Medical',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
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
                          });
                      },
                      child: Text(startDate == null
                          ? 'Start Date'
                          : '${startDate!.toLocal()}'.split(' ')[0]),
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
                          });
                      },
                      child: Text(endDate == null
                          ? 'Due Date'
                          : '${endDate!.toLocal()}'.split(' ')[0]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Notify Employee',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
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

  Widget _buildDetailCard(String title, int value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
            SizedBox(height: 8),
            Text(
              '$value days',
              style: TextStyle(fontSize: 10, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveDetail {
  final String type;
  final int days;

  LeaveDetail(this.type, this.days);
}
