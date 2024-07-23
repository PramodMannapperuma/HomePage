import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import 'package:untitled/Backend/models/leave_balance_model.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

// class Leave extends StatefulWidget {
//   final String token;
//
//   const Leave({Key? key, required this.token}) : super(key: key);
//
//   @override
//   State<Leave> createState() => _LeaveState();
// }
//
// class _LeaveState extends State<Leave> {
//   List<LeaveBalanceData>? leaveBalanceData;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchLeaveBalance();
//   }
//
//   Future<void> _fetchLeaveBalance() async {
//     try {
//       final data = await ApiService().fetchLeaveBalance(widget.token);
//       setState(() {
//         leaveBalanceData = data;
//         isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching leave balance: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/hrislogo2.png',
//               height: 40.0,
//             ),
//             SizedBox(
//               width: screenWidth * 0.03,
//             ),
//           ],
//         ),
//         centerTitle: true,
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.dark,
//         ),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return Padding(
//               padding: EdgeInsets.all(screenWidth * 0.03),
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.menu_outlined,
//                   color: AppColors.background,
//                 ),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//               ),
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.person,
//               color: AppColors.background,
//             ),
//             onPressed: () {
//               Navigator.pushNamed(context, '/profile', arguments: widget.token);
//             },
//           ),
//         ],
//       ),
//       drawer: CustomSidebar(
//         token: widget.token,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(screenWidth * 0.03),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Leave Details',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff4d2880),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : leaveBalanceData != null && leaveBalanceData!.isNotEmpty
//                       ? Card(
//                           elevation: 4,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(screenWidth * 0.03),
//                             child: Center(
//                               child: _buildLeaveTable(),
//                             ),
//                           ),
//                         )
//                       : Center(
//                           child: Text(
//                             'No leave balance data available.',
//                             style: TextStyle(fontSize: 14),
//                           ),
//                         ),
//               SizedBox(height: screenHeight * 0.03),
//               Divider(thickness: 1),
//               SizedBox(height: screenHeight * 0.03),
//               Text(
//                 'Request Leaves',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff4d2880),
//                 ),
//               ),
//               SizedBox(height: screenHeight * 0.03),
//               RequestLeavesRow(),
//               SizedBox(height: screenHeight * 0.03),
//               RequestLeavesForm(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLeaveTable() {
//     return DataTable(
//       columnSpacing: 10,
//       headingRowHeight: 30,
//       dataRowHeight: 30,
//       columns: [
//         DataColumn(
//             label: Text('Leave',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
//         DataColumn(
//             label: Text('Entitled',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
//         DataColumn(
//             label: Text('Utilized',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
//         DataColumn(
//             label: Text('Pending',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
//         DataColumn(
//             label: Text('Available',
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
//       ],
//       rows: leaveBalanceData!.map((data) {
//         return DataRow(cells: [
//           DataCell(
//             Center(child: Text(data.leave, style: TextStyle(fontSize: 13))),
//           ),
//           DataCell(
//             Center(child: Text(data.total.toString(), style: TextStyle(fontSize: 13))),
//           ),
//           DataCell(
//             Center(child: Text(data.utilized.toString(), style: TextStyle(fontSize: 13))),
//           ),
//           DataCell(
//             Center(child: Text(data.pending.toString(), style: TextStyle(fontSize: 13))),
//           ),
//           DataCell(
//             Center(child: Text(data.available.toString(), style: TextStyle(fontSize: 13))),
//           ),
//         ]);
//       }).toList(),
//     );
//   }
// }

class Leave extends StatefulWidget {
  final String token;

  const Leave({Key? key, required this.token}) : super(key: key);

  @override
  State<Leave> createState() => _LeaveState();
}

class _LeaveState extends State<Leave> {
  List<LeaveBalanceData>? leaveBalanceData;
  bool isLoading = true;
  String selectedLeaveType = 'Casual';

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

  List<LeaveBalanceData>? getSelectedLeaveData() {
    if (leaveBalanceData == null) return [];
    return leaveBalanceData!
        .where((data) => data.leave == selectedLeaveType)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xff4d2880),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/hrislogo2.png',
              height: 40.0,
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(35.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Leave",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 0.2,
              ),
            ],
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  Icons.menu_outlined,
                  color: AppColors.background,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              color: AppColors.background,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/profile',arguments: widget.token);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
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
                  SizedBox(height: 15),
                  DropdownButton<String>(
                    value: selectedLeaveType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLeaveType = newValue!;
                      });
                    },
                    items: <String>['Annual', 'Casual', 'Medical']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 8),
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
                      child: Center(
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildLeaveTable() {
    List<LeaveBalanceData>? selectedData = getSelectedLeaveData();
    return selectedData == null || selectedData.isEmpty
        ? Text('No data available for $selectedLeaveType leave.')
        : DataTable(
      columnSpacing: 16,
      headingRowHeight: 35,
      dataRowHeight: 38,
      columns: [
        DataColumn(
            label: Text('Leave',
                style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Entitled',
                style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Utilized',
                style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Pending',
                style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(
            label: Text('Available',
                style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: selectedData.map((data) {
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
    final screenWidth = MediaQuery.of(context).size.width;

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
          radius: 28,
          backgroundColor: Colors.grey.shade300,
          child: Icon(icon, size: 30, color: AppColors.background),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.02),
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
                  child: ElevatedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        setState(() {
                          startDate = picked;
                        });
                      }
                    },
                    child: Text(
                      startDate != null
                          ? 'Start Date: ${startDate!.toLocal()}'.split(' ')[0]
                          : 'Pick Start Date',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null) {
                        setState(() {
                          endDate = picked;
                        });
                      }
                    },
                    child: Text(
                      endDate != null
                          ? 'End Date: ${endDate!.toLocal()}'.split(' ')[0]
                          : 'Pick End Date',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Notify Employee',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter notification details';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  notifyEmployee = value;
                });
              },
            ),
            SizedBox(height: screenHeight * 0.03),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red, side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle the submit action
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
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
