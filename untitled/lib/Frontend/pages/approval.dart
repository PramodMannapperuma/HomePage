// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:untitled/Backend/APIs/Apis.dart';
// import '../app_bar.dart';
// import '../../Backend/models/subordinate_model.dart';
// import '../../Backend/models/cover_up_detail.dart';
// import '../../Backend/models/leave_approval.dart';
// import '../../Backend/models/att_approval.dart';
// import '../styles/sidebar.dart';

// class ApprovalScreen extends StatefulWidget {
//   final String token;

//   const ApprovalScreen({Key? key, required this.token}) : super(key: key);

//   @override
//   _ApprovalScreenState createState() => _ApprovalScreenState();
// }

// class _ApprovalScreenState extends State<ApprovalScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(
//         title: 'Approval Panel',
//         showActions: true,
//         showLeading: true,
//         context: context,
//         showBackButton: true,
//       ),
//       drawer: CustomSidebar(
//         token: widget.token,
//       ),
//       body: EmployeeListScreen(token: widget.token),
//     );
//   }
// }

// class EmployeeListScreen extends StatefulWidget {
//   final String token;

//   const EmployeeListScreen({Key? key, required this.token}) : super(key: key);

//   @override
//   _EmployeeListScreenState createState() => _EmployeeListScreenState();
// }

// class _EmployeeListScreenState extends State<EmployeeListScreen> {
//   List<Subordinate> subordinates = [];
//   List<Subordinate> filteredSubordinates = [];
//   TextEditingController searchController = TextEditingController();
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchSubordinates();
//     searchController.addListener(_filterSubordinates);
//   }

//   Future<void> _fetchSubordinates() async {
//     try {
//       subordinates = await ApiService().fetchSubordinates(widget.token);
//       setState(() {
//         filteredSubordinates = subordinates;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error fetching subordinates: $e');
//     }
//   }

//   void _filterSubordinates() {
//     setState(() {
//       filteredSubordinates = subordinates
//           .where((subordinate) => subordinate.name
//               .toLowerCase()
//               .contains(searchController.text.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           TextField(
//             controller: searchController,
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
//               hintText: 'Search Employees',
//               hintStyle: TextStyle(color: Colors.grey[600]),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide.none,
//               ),
//               filled: true,
//               fillColor: Colors.grey[200],
//             ),
//           ),
//           SizedBox(height: 10.0),
//           Expanded(
//             child: isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : filteredSubordinates.isEmpty
//                     ? Center(child: Text('No employees found'))
//                     : ListView.builder(
//                         itemCount: filteredSubordinates.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 20.0, vertical: 10.0),
//                             title: Text(
//                               filteredSubordinates[index].name,
//                               style: TextStyle(
//                                 fontSize: 17.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             subtitle: Text(
//                               filteredSubordinates[index].designation,
//                               style: TextStyle(
//                                 fontSize: 15.0,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             trailing: Icon(
//                               Icons.arrow_forward_ios,
//                               color: Colors.grey[600],
//                             ),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => EmployeeDetailsScreen(
//                                     employeeName:
//                                         filteredSubordinates[index].name,
//                                     employeeId: filteredSubordinates[index].id,
//                                     token: widget.token,
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EmployeeDetailsScreen extends StatefulWidget {
//   final String employeeName;
//   final String employeeId;
//   final String token;

//   const EmployeeDetailsScreen({
//     Key? key,
//     required this.employeeName,
//     required this.employeeId,
//     required this.token,
//   }) : super(key: key);

//   @override
//   _EmployeeDetailsScreenState createState() => _EmployeeDetailsScreenState();
// }

// class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
//   bool isLoading = true;
//   List<LeaveApproval> leaveRequests = [];
//   List<AttApproval> attendanceRecords = [];
//   List<CoverUpDetail> coverUpDetails = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchLeaveRequests();
//     _fetchAttendanceRecords();
//     _fetchCoverUpDetails();
//   }

//   Future<void> _fetchLeaveRequests() async {
//     try {
//       final response = await ApiService()
//           .fetchLeaveRequests(widget.employeeId, widget.token);
//       setState(() {
//         leaveRequests = response;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error fetching leave requests: $e');
//     }
//   }

//   Future<void> _fetchAttendanceRecords() async {
//     try {
//       final response = await ApiService()
//           .fetchAttendanceRecords(widget.employeeId, widget.token);
//       setState(() {
//         attendanceRecords = response;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error fetching attendance records: $e');
//     }
//   }

//   Future<void> _fetchCoverUpDetails() async {
//     try {
//       final response = await ApiService.getCoverUpDetails(
//           widget.token, int.parse(widget.employeeId));
//       setState(() {
//         coverUpDetails = response;
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error fetching cover-up details: $e');
//     }
//   }

//   // This method refreshes the page after accepting or rejecting a attendance, leave or a coverup
//   Future<void> _refreshPage() async {
//     await _fetchAttendanceRecords();
//     await _fetchCoverUpDetails();
//     await _fetchLeaveRequests();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(
//         title: '${widget.employeeName} - Approval Details',
//         showActions: false,
//         showLeading: true,
//         context: context,
//         showBackButton: true,
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: ListView(
//                 children: [
//                   SectionHeader(title: 'Attendance Details'),
//                   attendanceRecords.isEmpty
//                       ? Center(child: Text('No attendance records found'))
//                       : AttendanceDetailsTab(
//                           attendanceRecords: attendanceRecords,
//                           token: widget.token,
//                     onActionCompleted: _refreshPage), // Trigger refresh
//                   SectionHeader(title: 'Leave Request Details'),
//                   leaveRequests.isEmpty
//                       ? Center(child: Text('No leave requests found'))
//                       : LeaveRequestsTab(
//                           leaveRequests: leaveRequests, token: widget.token,
//                       onActionCompleted: _refreshPage),
//                   SectionHeader(title: 'Cover-Up Request Details'),
//                   coverUpDetails.isEmpty
//                       ? Center(child: Text('No cover-up requests found'))
//                       : CoverUpRequestTab(
//                           coverUpDetails: coverUpDetails, token: widget.token,
//                       onActionCompleted: _refreshPage),
//                 ],
//               ),
//             ),
//     );
//   }
// }

// class SectionHeader extends StatelessWidget {
//   final String title;

//   const SectionHeader({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Center(
//         child: Text(
//           title,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color(0xff4d2880),
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }

// class AttendanceDetailsTab extends StatelessWidget {
//   final List<AttApproval> attendanceRecords;
//   final String token;
//   final Future<void> Function() onActionCompleted; // Added refresh function

//   const AttendanceDetailsTab(
//       {Key? key, required this.attendanceRecords, required this.token, required this.onActionCompleted})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: attendanceRecords.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           elevation: 2,
//           child: ListTile(
//             contentPadding: EdgeInsets.all(15.0),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'ID: ${attendanceRecords[index].id}',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//                 ),
//                 Text(
//                   'Date: ${attendanceRecords[index].date}',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//                 ),
//                 Text(
//                   'Time In: ${attendanceRecords[index].amdIn}',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//                 Text(
//                   'Time Out: ${attendanceRecords[index].amdOut}',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//                 Text(
//                   'Comment: ${attendanceRecords[index].amdComment}',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//               ],
//             ),
//             trailing: AttActionButton(
//               token: token,
//               id: attendanceRecords[index].id,
//               onActionCompleted: onActionCompleted,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class LeaveRequestsTab extends StatelessWidget {
//   final List<LeaveApproval> leaveRequests;
//   final String token;
//   final Future<void> Function() onActionCompleted; // Added refresh function

//   const LeaveRequestsTab(
//       {Key? key, required this.leaveRequests, required this.token, required this.onActionCompleted})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: leaveRequests.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           elevation: 2,
//           child: ListTile(
//             contentPadding: EdgeInsets.all(15.0),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'ID: ${leaveRequests[index].id}',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//                 ),
//                 Text(
//                   'Date: ${leaveRequests[index].date}',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//                 ),
//                 Text('Leave Type: ${leaveRequests[index].leaveType}',
//                     style: TextStyle(fontSize: 15.0)),
//                 Text(
//                   'Reason: ${leaveRequests[index].reason}',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//                 Text(
//                   'Time: ${leaveRequests[index].time}',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//               ],
//             ),
//             trailing: LeaveActionButton(
//               token: token,
//               id: leaveRequests[index].id,
//               onActionCompleted: onActionCompleted,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class CoverUpRequestTab extends StatelessWidget {
//   final List<CoverUpDetail> coverUpDetails;
//   final String token;
//   final Future<void> Function() onActionCompleted; // Added refresh function

//   const CoverUpRequestTab(
//       {Key? key, required this.coverUpDetails, required this.token, required this.onActionCompleted})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: coverUpDetails.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           elevation: 2,
//           child: ListTile(
//             contentPadding: EdgeInsets.all(15.0),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Date: ${coverUpDetails[index].date}',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//                 ),
//                 Text('Leave Type: ${coverUpDetails[index].leaveType}',
//                     style: TextStyle(fontSize: 15.0)),
//                 Text(
//                   'Reason: ${coverUpDetails[index].reason}',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//                 Text(
//                   'Time: ${coverUpDetails[index].time}',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//                 Text(
//                   'Covered By: ${coverUpDetails[index].extra}',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//               ],
//             ),
//             trailing: CoverActionButton(
//               token: token,
//               id: coverUpDetails[index].id,
//               onActionCompleted: onActionCompleted,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class AttActionButton extends StatelessWidget {
//   final String token;
//   final int id;
//   final Future<void> Function() onActionCompleted; // Added refresh function

//   const AttActionButton({Key? key, required this.token, required this.id, required this.onActionCompleted})
//       : super(key: key);

//   Future<void> _showSuccessDialog(
//       BuildContext context, String message, String action) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(
//             children: [
//               Icon(
//                 action == "approve" ? Icons.check_circle : Icons.error,
//                 color: action == "approve" ? Colors.green : Colors.red,
//               ),
//               SizedBox(width: 10),
//               Text('Success'),
//             ],
//           ),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK',
//                   style: TextStyle(color: Theme.of(context).primaryColor)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _showCommentDialog(BuildContext context, String action) async {
//     TextEditingController commentController = TextEditingController();
//     bool isLoading = false;

//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               title: Text('Add Comment'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: commentController,
//                     decoration: InputDecoration(hintText: 'Enter your comment'),
//                   ),
//                   if (isLoading)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: SpinKitCircle(
//                         color: Theme.of(context).primaryColor,
//                         size: 50.0,
//                       ),
//                     ),
//                 ],
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(dialogContext).pop(); // Dismiss the dialog
//                   },
//                 ),
//                 TextButton(
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: isLoading
//                       ? null
//                       : () async {
//                           setState(() {
//                             isLoading = true;
//                           });

//                           try {
//                             await ApiService().approveAttendance(
//                               token,
//                               [id],
//                               action,
//                               commentController.text,
//                             );
//                             setState(() {
//                               isLoading = false;
//                             });
//                             Navigator.of(dialogContext)
//                                 .pop(); // Dismiss the dialog
//                             await _showSuccessDialog(context,
//                                 'Attendance $action successfully!', action);
//                             onActionCompleted(); // Trigger page refresh
//                           } catch (e) {
//                             setState(() {
//                               isLoading = false;
//                             });
//                           }
//                         },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.green,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.0),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//           ),
//           onPressed: () => _showCommentDialog(context, "approve"),
//           child: Text(
//             'Accept',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         SizedBox(width: 4.0),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.red,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.0),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//           ),
//           onPressed: () => _showCommentDialog(context, "reject"),
//           child: Text(
//             'Decline',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class LeaveActionButton extends StatelessWidget {
//   final String token;
//   final int id;
//   final Future<void> Function() onActionCompleted; // Added refresh function

//   const LeaveActionButton({Key? key, required this.token, required this.id, required this.onActionCompleted})
//       : super(key: key);

//   Future<void> _showSuccessDialog(
//       BuildContext context, String message, String action) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(
//             children: [
//               Icon(
//                 action == "approve" ? Icons.check_circle : Icons.error,
//                 color: action == "approve" ? Colors.green : Colors.red,
//               ),
//               SizedBox(width: 10),
//               Text('Success'),
//             ],
//           ),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK',
//                   style: TextStyle(color: Theme.of(context).primaryColor)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _showCommentDialog(BuildContext context, String action) async {
//     TextEditingController commentController = TextEditingController();
//     bool isLoading = false;

//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               title: Text('Add Comment'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: commentController,
//                     decoration: InputDecoration(hintText: 'Enter your comment'),
//                   ),
//                   if (isLoading)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: SpinKitCircle(
//                         color: Theme.of(context).primaryColor,
//                         size: 50.0,
//                       ),
//                     ),
//                 ],
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(dialogContext).pop(); // Dismiss the dialog
//                   },
//                 ),
//                 TextButton(
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: isLoading
//                       ? null
//                       : () async {
//                           setState(() {
//                             isLoading = true;
//                           });

//                           try {
//                             await ApiService().approveLeave(
//                               token,
//                               [id],
//                               action,
//                               commentController.text,
//                             );
//                             setState(() {
//                               isLoading = false;
//                             });
//                             Navigator.of(dialogContext)
//                                 .pop(); // Dismiss the dialog
//                             await _showSuccessDialog(
//                                 context, 'Leave $action successfully!', action);
//                                 onActionCompleted(); // Trigger page refresh
//                           } catch (e) {
//                             setState(() {
//                               isLoading = false;
//                             });
//                           }
//                         },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.green,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.0),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//           ),
//           onPressed: () => _showCommentDialog(context, "approve"),
//           child: Text(
//             'Accept',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         SizedBox(width: 4.0),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.red,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.0),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//           ),
//           onPressed: () => _showCommentDialog(context, "reject"),
//           child: Text(
//             'Decline',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CoverActionButton extends StatelessWidget {
//   final String token;
//   final int id;
//   final Future<void> Function() onActionCompleted; // Added refresh function

//   const CoverActionButton({Key? key, required this.token, required this.id, required this.onActionCompleted})
//       : super(key: key);

//   Future<void> _showSuccessDialog(
//       BuildContext context, String message, String action) async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Row(
//             children: [
//               Icon(
//                 action == "approve" ? Icons.check_circle : Icons.error,
//                 color: action == "approve" ? Colors.green : Colors.red,
//               ),
//               SizedBox(width: 10),
//               Text('Success'),
//             ],
//           ),
//           content: Text(message),
//           actions: <Widget>[
//             TextButton(
//               child: Text('OK',
//                   style: TextStyle(color: Theme.of(context).primaryColor)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _showCommentDialog(BuildContext context, String action) async {
//     TextEditingController commentController = TextEditingController();
//     bool isLoading = false;

//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext dialogContext) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return AlertDialog(
//               title: Text('Add Comment'),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: commentController,
//                     decoration: InputDecoration(hintText: 'Enter your comment'),
//                   ),
//                   if (isLoading)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: SpinKitCircle(
//                         color: Theme.of(context).primaryColor,
//                         size: 50.0,
//                       ),
//                     ),
//                 ],
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.of(dialogContext).pop(); // Dismiss the dialog
//                   },
//                 ),
//                 TextButton(
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   onPressed: isLoading
//                       ? null
//                       : () async {
//                           setState(() {
//                             isLoading = true;
//                           });

//                           try {
//                             await ApiService().approveCoverUp(
//                               token,
//                               [id],
//                               action,
//                               commentController.text,
//                             );
//                             setState(() {
//                               isLoading = false;
//                             });
//                             Navigator.of(dialogContext)
//                                 .pop(); // Dismiss the dialog
//                             await _showSuccessDialog(context,
//                                 'Cover-up $action successfully!', action);
//                                  onActionCompleted(); // Trigger page refresh
//                           } catch (e) {
//                             setState(() {
//                               isLoading = false;
//                             });
//                           }
//                         },
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.green,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.0),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//           ),
//           onPressed: () => _showCommentDialog(context, "approve"),
//           child: Text(
//             'Accept',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         SizedBox(width: 4.0),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.red,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6.0),
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//           ),
//           onPressed: () => _showCommentDialog(context, "reject"),
//           child: Text(
//             'Decline',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/Backend/models/att_approval.dart';
import 'package:untitled/Backend/models/cover_up_detail.dart';
import 'package:untitled/Backend/models/leave_approval.dart';
import '../../Backend/models/approval_items.dart';
import '../../Backend/APIs/Apis.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';


// Main ApprovalPendings page
class ApprovalPendings extends StatefulWidget {
  final String token;

  const ApprovalPendings({Key? key, required this.token}) : super(key: key);

  @override
  _ApprovalPendingsState createState() => _ApprovalPendingsState();
}

class _ApprovalPendingsState extends State<ApprovalPendings> {
  late Future<List<ApprovalItem>> _pendingApprovals;

  @override
  void initState() {
    super.initState();
    _pendingApprovals = ApiService.fetchPendingApprovals(widget.token);
  }

  void _handleApprovalTap(ApprovalItem approval) {
    switch (approval.item) {
      case 'Leave Request':
        _navigateToLeaveRequestPage();
        break;
      case 'Attendance Record':
        _navigateToAttendancePage();
        break;
      case 'Cover-Up Request':
        _navigateToCoverUpPage();
        break;
      default:
        print('Unknown approval item');
    }
  }

  void _navigateToLeaveRequestPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaveRequestsTab(
          leaveRequests: [], // You can pass actual data here
          token: widget.token,
          onActionCompleted: _refreshApprovals,
        ),
      ),
    );
  }

  void _navigateToAttendancePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceDetailsTab(
          attendanceRecords: [], // You can pass actual data here
          token: widget.token,
          onActionCompleted: _refreshApprovals,
        ),
      ),
    );
  }

  void _navigateToCoverUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoverUpRequestTab(
          coverUpDetails: [], // You can pass actual data here
          token: widget.token,
          onActionCompleted: _refreshApprovals,
        ),
      ),
    );
  }

  Future<void> _refreshApprovals() async {
    setState(() {
      _pendingApprovals = ApiService.fetchPendingApprovals(widget.token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Approval Panel',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: CustomSidebar(
        token: widget.token,
      ),
      body: FutureBuilder<List<ApprovalItem>>(
        future: _pendingApprovals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No pending approvals found.'));
          }

          List<ApprovalItem> approvals = snapshot.data!;
          return ListView.builder(
            itemCount: approvals.length,
            itemBuilder: (context, index) {
              ApprovalItem approval = approvals[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(
                        'assets/images/profile.png'), // Placeholder image
                  ),
                  title: Text(
                    approval.employee,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(approval.designation),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      approval.item,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () => _handleApprovalTap(approval),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Attendance Details Tab
class AttendanceDetailsTab extends StatelessWidget {
  final List<AttApproval> attendanceRecords;
  final String token;
  final Future<void> Function() onActionCompleted;

  const AttendanceDetailsTab({
    Key? key,
    required this.attendanceRecords,
    required this.token,
    required this.onActionCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Records')),
      body: ListView.builder(
        itemCount: attendanceRecords.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(attendanceRecords[index].id.toString()),
              subtitle: Text(attendanceRecords[index].date),
              trailing: Text(attendanceRecords[index].amdIn),
            ),
          );
        },
      ),
    );
  }
}

// Leave Requests Tab
class LeaveRequestsTab extends StatelessWidget {
  final List<LeaveApproval> leaveRequests;
  final String token;
  final Future<void> Function() onActionCompleted;

  const LeaveRequestsTab({
    Key? key,
    required this.leaveRequests,
    required this.token,
    required this.onActionCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leave Requests')),
      body: ListView.builder(
        itemCount: leaveRequests.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(leaveRequests[index].id.toString()),
              subtitle: Text(leaveRequests[index].leaveType),
              trailing: Text(leaveRequests[index].reason),
            ),
          );
        },
      ),
    );
  }
}

// Cover-Up Request Tab
class CoverUpRequestTab extends StatelessWidget {
  final List<CoverUpDetail> coverUpDetails;
  final String token;
  final Future<void> Function() onActionCompleted;

  const CoverUpRequestTab({
    Key? key,
    required this.coverUpDetails,
    required this.token,
    required this.onActionCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cover-Up Requests')),
      body: ListView.builder(
        itemCount: coverUpDetails.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(coverUpDetails[index].id.toString()),
              subtitle: Text(coverUpDetails[index].date),
              trailing: Text(coverUpDetails[index].leaveType),
            ),
          );
        },
      ),
    );
  }
}
