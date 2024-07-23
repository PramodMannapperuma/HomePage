// import 'package:flutter/material.dart';
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
// //   @override
// //   Widget build(BuildContext context) {
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final screenHeight = MediaQuery.of(context).size.height;
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Image.asset(
// //               'assets/images/hrislogo2.png',
// //               height: 40.0,
// //             ),
// //             SizedBox(
// //               width: screenWidth * 0.03,
// //             ),
// //           ],
// //         ),
// //         centerTitle: true,
// //         systemOverlayStyle: const SystemUiOverlayStyle(
// //           statusBarColor: Colors.transparent,
// //           statusBarIconBrightness: Brightness.dark,
// //         ),
// //         leading: Builder(
// //           builder: (BuildContext context) {
// //             return Padding(
// //               padding: EdgeInsets.all(screenWidth * 0.03),
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
// //               Navigator.pushNamed(context, '/profile', arguments: widget.token);
// //             },
// //           ),
// //         ],
// //       ),
// //       drawer: CustomSidebar(
// //         token: widget.token,
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(screenWidth * 0.03),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Leave Details',
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                   color: Color(0xff4d2880),
// //                 ),
// //               ),
// //               SizedBox(height: screenHeight * 0.03),
// //               isLoading
// //                   ? Center(child: CircularProgressIndicator())
// //                   : leaveBalanceData != null && leaveBalanceData!.isNotEmpty
// //                       ? Card(
// //                           elevation: 4,
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                           child: Padding(
// //                             padding: EdgeInsets.all(screenWidth * 0.03),
// //                             child: Center(
// //                               child: _buildLeaveTable(),
// //                             ),
// //                           ),
// //                         )
// //                       : Center(
// //                           child: Text(
// //                             'No leave balance data available.',
// //                             style: TextStyle(fontSize: 14),
// //                           ),
// //                         ),
// //               SizedBox(height: screenHeight * 0.03),
// //               Divider(thickness: 1),
// //               SizedBox(height: screenHeight * 0.03),
// //               Text(
// //                 'Request Leaves',
// //                 style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                   color: Color(0xff4d2880),
// //                 ),
// //               ),
// //               SizedBox(height: screenHeight * 0.03),
// //               RequestLeavesRow(),
// //               SizedBox(height: screenHeight * 0.03),
// //               RequestLeavesForm(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLeaveTable() {
// //     return DataTable(
// //       columnSpacing: 10,
// //       headingRowHeight: 30,
// //       dataRowHeight: 30,
// //       columns: [
// //         DataColumn(
// //             label: Text('Leave',
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
// //         DataColumn(
// //             label: Text('Entitled',
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
// //         DataColumn(
// //             label: Text('Utilized',
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
// //         DataColumn(
// //             label: Text('Pending',
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
// //         DataColumn(
// //             label: Text('Available',
// //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
// //       ],
// //       rows: leaveBalanceData!.map((data) {
// //         return DataRow(cells: [
// //           DataCell(
// //             Center(child: Text(data.leave, style: TextStyle(fontSize: 13))),
// //           ),
// //           DataCell(
// //             Center(child: Text(data.total.toString(), style: TextStyle(fontSize: 13))),
// //           ),
// //           DataCell(
// //             Center(child: Text(data.utilized.toString(), style: TextStyle(fontSize: 13))),
// //           ),
// //           DataCell(
// //             Center(child: Text(data.pending.toString(), style: TextStyle(fontSize: 13))),
// //           ),
// //           DataCell(
// //             Center(child: Text(data.available.toString(), style: TextStyle(fontSize: 13))),
// //           ),
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
//   String selectedLeaveType = 'Casual';

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

//   List<LeaveBalanceData>? getSelectedLeaveData() {
//     if (leaveBalanceData == null) return [];
//     return leaveBalanceData!
//         .where((data) => data.leave == selectedLeaveType)
//         .toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: const Color(0xff4d2880),
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
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(35.0),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Text(
//                   "Leave",
//                   style: TextStyle(
//                     fontSize: 18.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Divider(
//                 color: Colors.black,
//                 thickness: 0.2,
//               ),
//             ],
//           ),
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
//               Navigator.pushNamed(context, '/profile',arguments: widget.token);
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Leave Details',
//                     style: TextStyle(
//                       fontSize: 18.5,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff4d2880),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   DropdownButton<String>(
//                     value: selectedLeaveType,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         selectedLeaveType = newValue!;
//                       });
//                     },
//                     items: <String>['Annual', 'Casual', 'Medical']
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                   SizedBox(height: 8),
//                   isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : leaveBalanceData != null && leaveBalanceData!.isNotEmpty
//                       ? Card(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Center(
//                         child: _buildLeaveTable(),
//                       ),
//                     ),
//                   )
//                       : Center(
//                     child: Text(
//                       'No leave balance data available.',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Divider(thickness: 1),
//                   SizedBox(height: 20),
//                   Text(
//                     'Request Leaves',
//                     style: TextStyle(
//                       fontSize: 18.5,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xff4d2880),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   RequestLeavesRow(),
//                   SizedBox(height: 20),
//                   RequestLeavesForm(),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildLeaveTable() {
//     List<LeaveBalanceData>? selectedData = getSelectedLeaveData();
//     return selectedData == null || selectedData.isEmpty
//         ? Text('No data available for $selectedLeaveType leave.')
//         : DataTable(
//       columnSpacing: 16,
//       headingRowHeight: 35,
//       dataRowHeight: 38,
//       columns: [
//         DataColumn(
//             label: Text('Leave',
//                 style: TextStyle(fontWeight: FontWeight.bold))),
//         DataColumn(
//             label: Text('Entitled',
//                 style: TextStyle(fontWeight: FontWeight.bold))),
//         DataColumn(
//             label: Text('Utilized',
//                 style: TextStyle(fontWeight: FontWeight.bold))),
//         DataColumn(
//             label: Text('Pending',
//                 style: TextStyle(fontWeight: FontWeight.bold))),
//         DataColumn(
//             label: Text('Available',
//                 style: TextStyle(fontWeight: FontWeight.bold))),
//       ],
//       rows: selectedData.map((data) {
//         return DataRow(cells: [
//           DataCell(Text(data.leave)),
//           DataCell(Text(data.total.toString())),
//           DataCell(Text(data.utilized.toString())),
//           DataCell(Text(data.pending.toString())),
//           DataCell(Text(data.available.toString())),
//         ]);
//       }).toList(),
//     );
//   }
// }

// class RequestLeavesRow extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

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
//           child: Icon(icon, size: 30, color: AppColors.background),
//         ),
//         SizedBox(height: 6),
//         Text(
//           label,
//           style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Padding(
//       padding: EdgeInsets.all(screenWidth * 0.03),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 2,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter a description';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 setState(() {
//                   description = value;
//                 });
//               },
//             ),
//             SizedBox(height: screenHeight * 0.02),
//             Row(
//               children: [
//                 Text(
//                   'Dates',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Spacer(),
//                 TextButton(
//                   onPressed: () {
//                     setState(() {
//                       startDate = null;
//                       endDate = null;
//                     });
//                   },
//                   child: Text('Clear'),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final picked = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (picked != null) {
//                         setState(() {
//                           startDate = picked;
//                         });
//                       }
//                     },
//                     child: Text(
//                       startDate != null
//                           ? 'Start Date: ${startDate!.toLocal()}'.split(' ')[0]
//                           : 'Pick Start Date',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.03),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final picked = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );
//                       if (picked != null) {
//                         setState(() {
//                           endDate = picked;
//                         });
//                       }
//                     },
//                     child: Text(
//                       endDate != null
//                           ? 'End Date: ${endDate!.toLocal()}'.split(' ')[0]
//                           : 'Pick End Date',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: screenHeight * 0.03),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Notify Employee',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 2,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter notification details';
//                 }
//                 return null;
//               },
//               onChanged: (value) {
//                 setState(() {
//                   notifyEmployee = value;
//                 });
//               },
//             ),
//             SizedBox(height: screenHeight * 0.03),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text('Cancel'),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.red, side: BorderSide(color: Colors.red),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: screenWidth * 0.03),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState?.validate() ?? false) {
//                         // Handle the submit action
//                         showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: Text('Leave Request Submitted'),
//                             content: Text('Your leave request has been successfully submitted.'),
//                             actions: <Widget>[
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                   Navigator.pop(context); // Navigate back
//                                 },
//                                 child: Text('OK'),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                     },
//                     child: Text('Save'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../../Backend/models/leave_balance_model.dart';
import '../../Backend/models/leave_model.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class Leave extends StatefulWidget {
  final String token;

  const Leave({Key? key, required this.token}) : super(key: key);

  @override
  State<Leave> createState() => _LeavePageState();
}

class _LeavePageState extends State<Leave> {
  List<LeaveBalanceData>? leaveBalanceData;
  bool isLoading = true;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime today = DateTime.now();

  Map<DateTime, List<LeaveEvent>> events = {};
  TextEditingController _commentController = TextEditingController();
  String? _selectedLeaveType;
  String? _selectedTimeOfDay;
  String? _selectedCoverUp;
  String? _attachmentPath;

  late final ValueNotifier<List<LeaveEvent>> _selectedEvents;
  late Future<List<LeaveData>> futureLeaveData;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchLeaveBalance();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    futureLeaveData = apiService.fetchLeaveData(widget.token, _selectedDay!);
    print('Token in leave page is ${widget.token}');
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDate)) {
      setState(() {
        _selectedDay = selectedDate;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDate);
        futureLeaveData = apiService.fetchLeaveData(widget.token, selectedDate);
        print('Token in onDaySelected ${widget.token}');
      });
    }
  }

  List<LeaveEvent> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  Future<void> _pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _attachmentPath = result.files.single.path;
      });
    }
  }

  void _clearForm() {
    setState(() {
      _selectedLeaveType = null;
      _selectedTimeOfDay = null;
      _commentController.clear();
      _attachmentPath = null;
      _selectedCoverUp = null;
    });
  }

  Future<void> _showAddLeaveBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add Leave",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedLeaveType,
                      decoration: InputDecoration(
                        labelText: "Leave Type",
                      ),
                      items: ["Annual", "Casual", "Medical"].map((String leaveType) {
                        return DropdownMenuItem<String>(
                          value: leaveType,
                          child: Text(leaveType),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLeaveType = newValue;
                          if (newValue != "Medical") {
                            _attachmentPath = null;
                          }
                        });
                      },
                    ),
                    if (_selectedLeaveType == "Annual")
                      DropdownButtonFormField<String>(
                        value: _selectedCoverUp,
                        decoration: InputDecoration(
                          labelText: "Cover up",
                        ),
                        items: ["Employee 1", "Employee 2", "Employee 3"].map((String employeeName) {
                          return DropdownMenuItem<String>(
                            value: employeeName,
                            child: Text(employeeName),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCoverUp = newValue;
                          });
                        },
                      ),
                    if (_selectedLeaveType == "Medical")
                      Column(
                        children: [
                          TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: "Attachment",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.attach_file),
                                onPressed: () async {
                                  FilePickerResult? result = await FilePicker.platform.pickFiles();

                                  if (result != null) {
                                    setState(() {
                                      _attachmentPath = result.files.single.path;
                                    });
                                  }
                                },
                              ),
                            ),
                            controller: TextEditingController(text: _attachmentPath),
                          ),
                          if (_attachmentPath != null)
                            Text("Selected file: ${_attachmentPath!.split('/').last}"),
                        ],
                      ),
                    DropdownButtonFormField<String>(
                      value: _selectedTimeOfDay,
                      decoration: InputDecoration(
                        labelText: "Time of the Day",
                      ),
                      items: ["Full Day", "Half Day-Morning", "Half Day-Evening"].map((String timeOfDay) {
                        return DropdownMenuItem<String>(
                          value: timeOfDay,
                          child: Text(timeOfDay),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTimeOfDay = newValue;
                        });
                      },
                    ),
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: "Reason",
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            _clearForm();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(14.0),
                            backgroundColor: Color(0xff4d2880),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (_selectedLeaveType != null &&
                                _selectedTimeOfDay != null &&
                                _commentController.text.isNotEmpty &&
                                (_selectedLeaveType != "Annual" || _selectedCoverUp != null) &&
                                (_selectedLeaveType != "Medical" || _attachmentPath != null)) {
                              setState(() {
                                events[_selectedDay!] = [
                                  LeaveEvent(
                                    _selectedLeaveType!,
                                    _selectedTimeOfDay!,
                                    _commentController.text,
                                    _selectedCoverUp,
                                    _attachmentPath,
                                  )
                                ];
                              });

                              _clearForm();
                              Navigator.of(context).pop();
                              _selectedEvents.value = _getEventsForDay(_selectedDay!);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please enter all fields"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/hrislogo2.png',
                height: isPortrait ? 40.0 : 30.0,
              ),
              SizedBox(width: 8.0),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(35.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                Navigator.pushNamed(context, '/profile',
                    arguments: widget.token);
              },
            ),
          ],
        ),
        drawer: CustomSidebar(token: widget.token),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff4d2880),
          onPressed: () {
            _showAddLeaveBottomSheet(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Column(children: [
          Container(
            child: TableCalendar(
              rowHeight: 40,
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: Color(0xff4d2880),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4d2880),
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Color(0xff4d2880),
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Color(0xff4d2880),
                ),
              ),
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              firstDay: DateTime.utc(2023, 01, 01),
              lastDay: DateTime.utc(3030, 12, 31),
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                todayDecoration: BoxDecoration(
                  color: Color(0xff4d2880),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Color(0xff9575cd),
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Color(0xff9575cd),
                  shape: BoxShape.circle,
                ),
              ),
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
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
                      padding: EdgeInsets.all(screenWidth * 0.03),
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
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Expanded(
            child: ValueListenableBuilder<List<LeaveEvent>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.01,
                      ),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          title: Text(
                            value[index].leaveType,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Time: ${value[index].timeOfDay}"),
                              Text("Reason: ${value[index].reason}"),
                              if (value[index].coverUp != null)
                                Text("Cover up: ${value[index].coverUp!}"),
                              if (value[index].attachment != null)
                                Text(
                                    "Attachment: ${value[index].attachment!.split('/').last}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]));
  }

  Widget _buildLeaveTable() {
    return DataTable(
      columnSpacing: 10,
      headingRowHeight: 30,
      dataRowHeight: 30,
      columns: [
        DataColumn(
            label: Text('Leave',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
        DataColumn(
            label: Text('Entitled',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
        DataColumn(
            label: Text('Utilized',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
        DataColumn(
            label: Text('Pending',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
        DataColumn(
            label: Text('Available',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
      ],
      rows: leaveBalanceData!.map((data) {
        return DataRow(cells: [
          DataCell(
            Center(child: Text(data.leave, style: TextStyle(fontSize: 13))),
          ),
          DataCell(
            Center(
                child: Text(data.total.toString(),
                    style: TextStyle(fontSize: 13))),
          ),
          DataCell(
            Center(
                child: Text(data.utilized.toString(),
                    style: TextStyle(fontSize: 13))),
          ),
          DataCell(
            Center(
                child: Text(data.pending.toString(),
                    style: TextStyle(fontSize: 13))),
          ),
          DataCell(
            Center(
                child: Text(data.available.toString(),
                    style: TextStyle(fontSize: 13))),
          ),
        ]);
      }).toList(),
    );
  }
}

class LeaveEvent {
  final String leaveType;
  final String timeOfDay;
  final String reason;
  final String? coverUp;
  final String? attachment;

  LeaveEvent(this.leaveType, this.timeOfDay, this.reason,
      [this.coverUp, this.attachment]);
}