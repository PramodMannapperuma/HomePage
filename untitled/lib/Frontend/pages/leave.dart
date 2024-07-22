// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/services.dart';
// import 'package:untitled/Backend/APIs/Apis.dart';
// import 'package:untitled/Backend/models/leave_balance_model.dart';
// import '../app_bar.dart';
// import '../styles/app_colors.dart';
// import '../styles/sidebar.dart';

// // class Leave extends StatefulWidget {
// //   final String token;
// //
// //   const Leave({Key? key, required this.token}) : super(key: key);
// //
// //   @override
// //   State<Leave> createState() => _LeaveState();
// // }
// //
// // class _LeaveState extends State<Leave> {
// //   List<LeaveBalanceData>? leaveBalanceData;
// //   bool isLoading = true;
// //   String selectedLeaveType = 'Casual';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchLeaveBalance();
// //   }
// //
// //   Future<void> _fetchLeaveBalance() async {
// //     try {
// //       final data = await ApiService().fetchLeaveBalance(widget.token);
// //       setState(() {
// //         leaveBalanceData = data;
// //         isLoading = false;
// //       });
// //     } catch (e) {
// //       print('Error fetching leave balance: $e');
// //       setState(() {
// //         isLoading = false;
// //       });
// //     }
// //   }
// //
// //   List<LeaveBalanceData>? getSelectedLeaveData() {
// //     if (leaveBalanceData == null) return [];
// //     return leaveBalanceData!
// //         .where((data) => data.leave == selectedLeaveType)
// //         .toList();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         // backgroundColor: const Color(0xff4d2880),
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Image.asset(
// //               'assets/images/hrislogo2.png',
// //               height: 40.0,
// //             ),
// //             SizedBox(
// //               width: 8.0,
// //             ),
// //           ],
// //         ),
// //         bottom: PreferredSize(
// //           preferredSize: Size.fromHeight(35.0),
// //           child: Column(
// //             children: [
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //                 child: Text(
// //                   "Leave",
// //                   style: TextStyle(
// //                     fontSize: 18.0,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //               ),
// //               Divider(
// //                 color: Colors.black,
// //                 thickness: 0.2,
// //               ),
// //             ],
// //           ),
// //         ),
// //         centerTitle: true,
// //         systemOverlayStyle: const SystemUiOverlayStyle(
// //           statusBarColor: Colors.transparent,
// //           statusBarIconBrightness: Brightness.dark,
// //         ),
// //         leading: Builder(
// //           builder: (BuildContext context) {
// //             return Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: IconButton(
// //                 icon: const Icon(
// //                   Icons.menu_outlined,
// //                   color: AppColors.background,
// //                 ),
// //                 onPressed: () {
// //                   Scaffold.of(context).openDrawer();
// //                 },
// //               ),
// //             );
// //           },
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(
// //               Icons.person,
// //               color: AppColors.background,
// //             ),
// //             onPressed: () {
// //               Navigator.pushNamed(context, '/profile',arguments: widget.token);
// //             },
// //           ),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: LayoutBuilder(
// //           builder: (context, constraints) {
// //             return SingleChildScrollView(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Leave Details',
// //                     style: TextStyle(
// //                       fontSize: 18.5,
// //                       fontWeight: FontWeight.bold,
// //                       color: Color(0xff4d2880),
// //                     ),
// //                   ),
// //                   SizedBox(height: 15),
// //                   DropdownButton<String>(
// //                     value: selectedLeaveType,
// //                     onChanged: (String? newValue) {
// //                       setState(() {
// //                         selectedLeaveType = newValue!;
// //                       });
// //                     },
// //                     items: <String>['Annual', 'Casual', 'Medical']
// //                         .map<DropdownMenuItem<String>>((String value) {
// //                       return DropdownMenuItem<String>(
// //                         value: value,
// //                         child: Text(value),
// //                       );
// //                     }).toList(),
// //                   ),
// //                   SizedBox(height: 8),
// //                   isLoading
// //                       ? Center(child: CircularProgressIndicator())
// //                       : leaveBalanceData != null && leaveBalanceData!.isNotEmpty
// //                       ? Card(
// //                     elevation: 3,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                     ),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(16.0),
// //                       child: Center(
// //                         child: _buildLeaveTable(),
// //                       ),
// //                     ),
// //                   )
// //                       : Center(
// //                     child: Text(
// //                       'No leave balance data available.',
// //                       style: TextStyle(fontSize: 16),
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   Divider(thickness: 1),
// //                   SizedBox(height: 20),
// //                   Text(
// //                     'Request Leaves',
// //                     style: TextStyle(
// //                       fontSize: 18.5,
// //                       fontWeight: FontWeight.bold,
// //                       color: Color(0xff4d2880),
// //                     ),
// //                   ),
// //                   SizedBox(height: 20),
// //                   RequestLeavesRow(),
// //                   SizedBox(height: 20),
// //                   RequestLeavesForm(),
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLeaveTable() {
// //     List<LeaveBalanceData>? selectedData = getSelectedLeaveData();
// //     return selectedData == null || selectedData.isEmpty
// //         ? Text('No data available for $selectedLeaveType leave.')
// //         : DataTable(
// //       columnSpacing: 16,
// //       headingRowHeight: 35,
// //       dataRowHeight: 38,
// //       columns: [
// //         DataColumn(
// //             label: Text('Leave',
// //                 style: TextStyle(fontWeight: FontWeight.bold))),
// //         DataColumn(
// //             label: Text('Entitled',
// //                 style: TextStyle(fontWeight: FontWeight.bold))),
// //         DataColumn(
// //             label: Text('Utilized',
// //                 style: TextStyle(fontWeight: FontWeight.bold))),
// //         DataColumn(
// //             label: Text('Pending',
// //                 style: TextStyle(fontWeight: FontWeight.bold))),
// //         DataColumn(
// //             label: Text('Available',
// //                 style: TextStyle(fontWeight: FontWeight.bold))),
// //       ],
// //       rows: selectedData.map((data) {
// //         return DataRow(cells: [
// //           DataCell(Text(data.leave)),
// //           DataCell(Text(data.total.toString())),
// //           DataCell(Text(data.utilized.toString())),
// //           DataCell(Text(data.pending.toString())),
// //           DataCell(Text(data.available.toString())),
// //         ]);
// //       }).toList(),
// //     );
// //   }
// // }

// class Leave extends StatefulWidget {
//   final String token;

//   const Leave({Key? key, required this.token}) : super(key: key);

//   @override
//   State<Leave> createState() => _LeaveState();
// }

// class _LeaveState extends State<Leave> {
//   List<LeaveBalanceData>? leaveBalanceData;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchLeaveBalance();
//   }

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

//   @override
//   Widget build(BuildContext context) {
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
//               width: 8.0,
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
//               padding: const EdgeInsets.all(8.0),
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
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Leave Details',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff4d2880),
//                 ),
//               ),
//               SizedBox(height: 16),
//               isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : leaveBalanceData != null && leaveBalanceData!.isNotEmpty
//                       ? Card(
//                           elevation: 4,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Center(
//                               child: _buildLeaveTable(),
//                             ),
//                           ),
//                         )
//                       : Center(
//                           child: Text(
//                             'No leave balance data available.',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//               SizedBox(height: 20),
//               Divider(thickness: 1),
//               SizedBox(height: 20),
//               Text(
//                 'Request Leaves',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff4d2880),
//                 ),
//               ),
//               SizedBox(height: 20),
//               RequestLeavesRow(),
//               SizedBox(height: 20),
//               RequestLeavesForm(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLeaveTable() {
//     return DataTable(
//       columnSpacing: 10,
//       headingRowHeight: 30,
//       dataRowHeight: 32,
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
//             Center(child: Text(data.leave, style: TextStyle(fontSize: 14))),
//           ),
//           DataCell(
//             Center(
//                 child: Text(data.total.toString(),
//                     style: TextStyle(fontSize: 14))),
//           ),
//           DataCell(
//             Center(
//                 child: Text(data.utilized.toString(),
//                     style: TextStyle(fontSize: 14))),
//           ),
//           DataCell(
//             Center(
//                 child: Text(data.pending.toString(),
//                     style: TextStyle(fontSize: 14))),
//           ),
//           DataCell(
//             Center(
//                 child: Text(data.available.toString(),
//                     style: TextStyle(fontSize: 14))),
//           ),
//         ]);
//       }).toList(),
//     );
//   }
// }

// class RequestLeavesRow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         LeaveRequestOption(icon: Icons.flight, label: 'Annual'),
//         LeaveRequestOption(icon: Icons.beach_access, label: 'Casual'),
//         LeaveRequestOption(icon: Icons.local_hospital, label: 'Medical'),
//       ],
//     );
//   }
// }

// class LeaveRequestOption extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const LeaveRequestOption({Key? key, required this.icon, required this.label})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 28,
//           backgroundColor: Colors.grey.shade300,
//           child: Icon(icon, size: 24, color: AppColors.background),
//         ),
//         SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }
// }

// class RequestLeavesForm extends StatefulWidget {
//   @override
//   _RequestLeavesFormState createState() => _RequestLeavesFormState();
// }

// class _RequestLeavesFormState extends State<RequestLeavesForm> {
//   DateTime? startDate;
//   DateTime? endDate;
//   String? description;
//   String? notifyEmployee;

//   // Error messages map
//   final Map<String, String?> errorMessages = {
//     'description': null,
//     'startDate': null,
//     'endDate': null,
//     'notifyEmployee': null,
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextField(
//           decoration: InputDecoration(
//             labelText: 'Description',
//             border: OutlineInputBorder(),
//             errorText: errorMessages['description'],
//           ),
//           maxLines: 3,
//           onChanged: (value) {
//             setState(() {
//               description = value;
//               if (value.isNotEmpty) {
//                 errorMessages['description'] = null;
//               }
//             });
//           },
//         ),
//         SizedBox(height: 10),
//         Row(
//           children: [
//             Text(
//               'Dates',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Spacer(),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   startDate = null;
//                   endDate = null;
//                 });
//               },
//               child: Text('Clear'),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       final picked = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (picked != null && picked != startDate) {
//                         setState(() {
//                           startDate = picked;
//                           errorMessages['startDate'] = null;
//                         });
//                       }
//                     },
//                     child: Text(
//                       startDate == null
//                           ? 'Start Date'
//                           : '${startDate!.toLocal()}'.split(' ')[0],
//                     ),
//                   ),
//                   if (errorMessages['startDate'] != null)
//                     Text(
//                       errorMessages['startDate']!,
//                       style: TextStyle(color: Colors.red, fontSize: 12),
//                     ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 8),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () async {
//                       final picked = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (picked != null && picked != endDate) {
//                         setState(() {
//                           endDate = picked;
//                           errorMessages['endDate'] = null;
//                         });
//                       }
//                     },
//                     child: Text(
//                       endDate == null
//                           ? 'End Date'
//                           : '${endDate!.toLocal()}'.split(' ')[0],
//                     ),
//                   ),
//                   if (errorMessages['endDate'] != null)
//                     Text(
//                       errorMessages['endDate']!,
//                       style: TextStyle(color: Colors.red, fontSize: 12),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 16),
//         TextField(
//           decoration: InputDecoration(
//             labelText: 'Notify Employee',
//             border: OutlineInputBorder(),
//             errorText: errorMessages['notifyEmployee'],
//           ),
//           maxLines: 3,
//           onChanged: (value) {
//             setState(() {
//               notifyEmployee = value;
//               if (value.isNotEmpty) {
//                 errorMessages['notifyEmployee'] = null;
//               }
//             });
//           },
//         ),
//         SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('Cancel'),
//               ),
//             ),
//             SizedBox(width: 8),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   _submitForm();
//                 },
//                 child: Text('Save'),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   void _submitForm() {
//     // Validate the form
//     if (_validateForm()) {
//       // Form is valid, save or process data
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Leave Request Submitted'),
//           content: Text('Your leave request has been successfully submitted.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.pop(context); // Navigate back
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } else {
//       // Form is not valid, show error messages
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Validation Error'),
//           content: Text('Please fill all required fields.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   bool _validateForm() {
//     bool isValid = true;

//     // Validate description
//     if (description == null || description!.isEmpty) {
//       errorMessages['description'] = 'Please enter a description';
//       isValid = false;
//     } else {
//       errorMessages['description'] = null;
//     }

//     // Validate startDate
//     if (startDate == null) {
//       errorMessages['startDate'] = 'Please select start date';
//       isValid = false;
//     } else {
//       errorMessages['startDate'] = null;
//     }

//     // Validate endDate
//     if (endDate == null) {
//       errorMessages['endDate'] = 'Please select end date';
//       isValid = false;
//     } else {
//       errorMessages['endDate'] = null;
//     }

//     // Validate notifyEmployee
//     if (notifyEmployee == null || notifyEmployee!.isEmpty) {
//       errorMessages['notifyEmployee'] = 'Please enter notification details';
//       isValid = false;
//     } else {
//       errorMessages['notifyEmployee'] = null;
//     }

//     setState(() {}); // Update UI with error messages

//     return isValid;
//   }
// }

// class LeaveBar extends StatelessWidget {
//   final List<int> leaveData;
//   const LeaveBar({super.key, required this.leaveData});

//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         maxY: 40,
//         minY: 0,
//         gridData: FlGridData(show: false),
//         borderData: FlBorderData(show: true),
//         titlesData: FlTitlesData(
//           show: true,
//           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: getBottomTitles,
//             ),
//           ),
//         ),
//         barGroups: [
//           BarChartGroupData(
//             x: 0,
//             barRods: [
//               BarChartRodData(
//                 toY: leaveData[0].toDouble(),
//                 color: AppColors.background,
//                 borderRadius: BorderRadius.circular(8),
//                 width: 40,
//               ),
//             ],
//           ),
//           BarChartGroupData(
//             x: 1,
//             barRods: [
//               BarChartRodData(
//                 toY: leaveData[1].toDouble(),
//                 color: AppColors.background,
//                 borderRadius: BorderRadius.circular(8),
//                 width: 40,
//               ),
//             ],
//           ),
//           BarChartGroupData(
//             x: 2,
//             barRods: [
//               BarChartRodData(
//                 toY: leaveData[2].toDouble(),
//                 color: AppColors.background,
//                 borderRadius: BorderRadius.circular(8),
//                 width: 40,
//               ),
//             ],
//           ),
//           BarChartGroupData(
//             x: 3,
//             barRods: [
//               BarChartRodData(
//                 toY: leaveData[3].toDouble(),
//                 color: AppColors.background,
//                 borderRadius: BorderRadius.circular(8),
//                 width: 40,
//               ),
//             ],
//           ),
//         ],
//       ),
//       swapAnimationDuration: Duration(milliseconds: 150), // Optional
//       swapAnimationCurve: Curves.linear,
//     );
//   }
// }

// Widget getBottomTitles(double value, TitleMeta meta) {
//   const style = TextStyle(
//     color: AppColors.background,
//     fontWeight: FontWeight.bold,
//     fontSize: 12,
//   );

//   switch (value.toInt()) {
//     case 0:
//       return SideTitleWidget(
//           child: const Text('Entitled', style: style), axisSide: meta.axisSide);
//     case 1:
//       return SideTitleWidget(
//           child: const Text('Utilized', style: style), axisSide: meta.axisSide);
//     case 2:
//       return SideTitleWidget(
//           child: const Text('Pending', style: style), axisSide: meta.axisSide);
//     case 3:
//       return SideTitleWidget(
//           child: const Text('Available', style: style),
//           axisSide: meta.axisSide);
//     default:
//       return SideTitleWidget(
//           child: const Text('Unknown', style: style), axisSide: meta.axisSide);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/hrislogo2.png',
              height: 40.0,
            ),
            SizedBox(
              width: screenWidth * 0.02,
            ),
          ],
        ),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
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
              Navigator.pushNamed(context, '/profile', arguments: widget.token);
            },
          ),
        ],
      ),
      drawer: CustomSidebar(
        token: widget.token,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Leave Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4d2880),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : leaveBalanceData != null && leaveBalanceData!.isNotEmpty
                      ? Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.02),
                            child: Center(
                              child: _buildLeaveTable(),
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            'No leave balance data available.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
              SizedBox(height: screenHeight * 0.02),
              Divider(thickness: 1),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Request Leaves',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4d2880),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              RequestLeavesRow(),
              SizedBox(height: screenHeight * 0.02),
              RequestLeavesForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveTable() {
    return DataTable(
      columnSpacing: 8,
      headingRowHeight: 24,
      dataRowHeight: 30,
      columns: [
        DataColumn(
            label: Text('Leave',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        DataColumn(
            label: Text('Entitled',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        DataColumn(
            label: Text('Utilized',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        DataColumn(
            label: Text('Pending',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
        DataColumn(
            label: Text('Available',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
      ],
      rows: leaveBalanceData!.map((data) {
        return DataRow(cells: [
          DataCell(
            Center(child: Text(data.leave, style: TextStyle(fontSize: 12))),
          ),
          DataCell(
            Center(child: Text(data.total.toString(), style: TextStyle(fontSize: 12))),
          ),
          DataCell(
            Center(child: Text(data.utilized.toString(), style: TextStyle(fontSize: 12))),
          ),
          DataCell(
            Center(child: Text(data.pending.toString(), style: TextStyle(fontSize: 12))),
          ),
          DataCell(
            Center(child: Text(data.available.toString(), style: TextStyle(fontSize: 12))),
          ),
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
          radius: 24,
          backgroundColor: Colors.grey.shade300,
          child: Icon(icon, size: 20, color: AppColors.background),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
      padding: EdgeInsets.all(screenWidth * 0.02),
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
            SizedBox(height: screenHeight * 0.01),
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
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
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
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
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
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.red,
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
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
