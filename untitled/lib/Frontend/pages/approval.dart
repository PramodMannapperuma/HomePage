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
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:untitled/Backend/models/att_approval.dart';
import 'package:untitled/Backend/models/cover_up_detail.dart';
import 'package:untitled/Backend/models/leave_approval.dart';
import '../../Backend/models/approval_items.dart';
import '../../Backend/APIs/Apis.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';

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

  // Function to fetch the employee's profile picture using the approval item ID (employeeId)
  Future<Uint8List?> _fetchProfilePicture(String employeeId) async {
    try {
      return await ApiService.fetchEmployeeProfilePicture(widget.token, employeeId);
    } catch (e) {
      print('Failed to load profile picture: $e');
      return null; // Return null if an error occurs
    }
  }

  void _handleApprovalTap(ApprovalItem approval) {
    switch (approval.item) {
      case 'Leave Approval':
        _navigateToLeaveRequestPage(approval.id);
        break;
      case 'Attendance Amendment':
        _navigateToAttendancePage(approval.id);
        break;
      case 'Cover-Up Approval':
        _navigateToCoverUpPage(approval.id);
        break;
      default:
        print('Unknown approval item');
    }
  }

  void _navigateToLeaveRequestPage(int approvalId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaveRequestsTab(
          approvalId: approvalId,
          token: widget.token,
          onActionCompleted: _refreshApprovals,
        ),
      ),
    );
  }

  void _navigateToAttendancePage(int approvalId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceDetailsTab(
          approvalId: approvalId,
          token: widget.token,
          onActionCompleted: _refreshApprovals,
        ),
      ),
    );
  }

  void _navigateToCoverUpPage(int approvalId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoverUpRequestTab(
          approvalId: approvalId,
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: customAppBar(
        title: 'Approval Panel',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: CustomSidebar(token: widget.token),
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

              // Fetch the profile image where ApprovalItem ID equals employeeId
              return FutureBuilder<Uint8List?>(
                future: _fetchProfilePicture(approval.id.toString()),
                builder: (context, imageSnapshot) {
                  Widget profileImage;

                  if (imageSnapshot.connectionState == ConnectionState.waiting) {
                    profileImage = const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    );
                  } else if (imageSnapshot.hasError || imageSnapshot.data == null) {
                    profileImage = const CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ); // Placeholder image in case of error
                  } else {
                    profileImage = CircleAvatar(
                      radius: 24,
                      backgroundImage: MemoryImage(imageSnapshot.data!),
                    );
                  }

                  return Card(
                    margin: EdgeInsets.all(screenWidth * 0.03), // Responsive margin
                    child: ListTile(
                      contentPadding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
                      leading: profileImage,
                      title: Text(
                        approval.employee,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045, // Responsive font size
                        ),
                        maxLines: 1, // Restrict to one line
                        overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                      ),
                      subtitle: Text(approval.designation),
                      trailing: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenWidth * 0.018,
                          horizontal: screenWidth * 0.03, // Responsive padding
                        ),
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
          );
        },
      ),
    );
  }
}

class AttendanceDetailsTab extends StatefulWidget {
  final String token;
  final int approvalId; // New parameter
  final Future<void> Function() onActionCompleted;

  const AttendanceDetailsTab({
    Key? key,
    required this.token,
    required this.approvalId, // New parameter
    required this.onActionCompleted,
  }) : super(key: key);

  @override
  _AttendanceDetailsTabState createState() => _AttendanceDetailsTabState();
}

class _AttendanceDetailsTabState extends State<AttendanceDetailsTab> {
  late List<AttApproval> attendanceRecords = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAttendanceRecords();
  }

  Future<void> _fetchAttendanceRecords() async {
    try {
      final response = await ApiService.fetchAttendanceRecords(widget.approvalId.toString(), widget.token);
      setState(() {
        attendanceRecords = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching attendance records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: customAppBar(
        title: 'Attendance Details',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: CustomSidebar(token: widget.token), // Add your custom sidebar here
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : ListView.builder(
        shrinkWrap: true,
        itemCount: attendanceRecords.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: EdgeInsets.all(15.0),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${attendanceRecords[index].id}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(
                    'Date: ${attendanceRecords[index].date}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(
                    'Time In: ${attendanceRecords[index].amdIn}',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    'Time Out: ${attendanceRecords[index].amdOut}',
                    style: TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    'Comment: ${attendanceRecords[index].amdComment}',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
              trailing: AttActionButton(
                token: widget.token,  // Correctly referencing the token from the widget
                id: attendanceRecords[index].id,
                onActionCompleted: widget.onActionCompleted,  // Correctly referencing onActionCompleted
              ),
            ),
          );
        },
      ),
    );
  }
}


class AttActionButton extends StatelessWidget {
  final String token;
  final int id;
  final Future<void> Function() onActionCompleted; // Added refresh function

  const AttActionButton({Key? key, required this.token, required this.id, required this.onActionCompleted})
      : super(key: key);

  Future<void> _showSuccessDialog(
      BuildContext context, String message, String action) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                action == "approve" ? Icons.check_circle : Icons.error,
                color: action == "approve" ? Colors.green : Colors.red,
              ),
              SizedBox(width: 10),
              Text('Success'),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCommentDialog(BuildContext context, String action) async {
    TextEditingController commentController = TextEditingController();
    bool isLoading = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Comment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: commentController,
                    decoration: InputDecoration(hintText: 'Enter your comment'),
                  ),
                  if (isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss the dialog
                  },
                ),
                TextButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await ApiService().approveAttendance(
                              token,
                              [id],
                              action,
                              commentController.text,
                            );
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(dialogContext)
                                .pop(); // Dismiss the dialog
                            await _showSuccessDialog(context,
                                'Attendance $action successfully!', action);
                            onActionCompleted(); // Trigger page refresh
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "approve"),
          child: Text(
            'Accept',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: 4.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "reject"),
          child: Text(
            'Decline',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class LeaveRequestsTab extends StatefulWidget {
  final String token;
  final int approvalId; // New parameter for fetching leave requests
  final Future<void> Function() onActionCompleted;

  const LeaveRequestsTab({
    Key? key,
    required this.token,
    required this.approvalId, // New parameter
    required this.onActionCompleted,
  }) : super(key: key);

  @override
  _LeaveRequestsTabState createState() => _LeaveRequestsTabState();
}

class _LeaveRequestsTabState extends State<LeaveRequestsTab> {
  late List<LeaveApproval> leaveRequests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLeaveRequests();
  }

  Future<void> _fetchLeaveRequests() async {
    try {
      final response = await ApiService.fetchLeaveRequests(widget.approvalId.toString(), widget.token);
      setState(() {
        leaveRequests = response; // Update the state with fetched leave requests
        isLoading = false; // Data fetching completed
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Handle loading state on error
      });
      print('Error fetching leave requests: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: customAppBar(
        title: 'Leave Requests',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: CustomSidebar(token: widget.token), // Add your custom sidebar here
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
        shrinkWrap: true,
        itemCount: leaveRequests.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(15.0),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${leaveRequests[index].id}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(
                    'Date: ${leaveRequests[index].date}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(
                    'Leave Type: ${leaveRequests[index].leaveType}',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    'Reason: ${leaveRequests[index].reason}',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    'Time: ${leaveRequests[index].time}',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
              trailing: LeaveActionButton(
                token: widget.token,
                id: leaveRequests[index].id,
                onActionCompleted: widget.onActionCompleted,
              ),
            ),
          );
        },
      ),
    );
  }
}

class LeaveActionButton extends StatelessWidget {
  final String token;
  final int id;
  final Future<void> Function() onActionCompleted; // Added refresh function

  const LeaveActionButton({Key? key, required this.token, required this.id, required this.onActionCompleted})
      : super(key: key);

  Future<void> _showSuccessDialog(
      BuildContext context, String message, String action) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                action == "approve" ? Icons.check_circle : Icons.error,
                color: action == "approve" ? Colors.green : Colors.red,
              ),
              SizedBox(width: 10),
              Text('Success'),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCommentDialog(BuildContext context, String action) async {
    TextEditingController commentController = TextEditingController();
    bool isLoading = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Comment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: commentController,
                    decoration: InputDecoration(hintText: 'Enter your comment'),
                  ),
                  if (isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss the dialog
                  },
                ),
                TextButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await ApiService().approveLeave(
                              token,
                              [id],
                              action,
                              commentController.text,
                            );
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(dialogContext)
                                .pop(); // Dismiss the dialog
                            await _showSuccessDialog(
                                context, 'Leave $action successfully!', action);
                                onActionCompleted(); // Trigger page refresh
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "approve"),
          child: Text(
            'Accept',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: 4.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "reject"),
          child: Text(
            'Decline',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class CoverUpRequestTab extends StatefulWidget {
  final String token;
  final int approvalId; // New parameter for fetching cover-up requests
  final Future<void> Function() onActionCompleted;

  const CoverUpRequestTab({
    Key? key,
    required this.token,
    required this.approvalId, // New parameter
    required this.onActionCompleted,
  }) : super(key: key);

  @override
  _CoverUpRequestTabState createState() => _CoverUpRequestTabState();
}

class _CoverUpRequestTabState extends State<CoverUpRequestTab> {
  late List<CoverUpDetail> coverUpDetails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCoverUpRequests();
  }

  Future<void> _fetchCoverUpRequests() async {
    try {
      // Pass approvalId as int directly to the API
      final response = await ApiService.getCoverUpDetails(widget.approvalId as String, widget.token as int);
      setState(() {
        coverUpDetails = response; // Update the state with fetched cover-up details
        isLoading = false; // Data fetching completed
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Handle loading state on error
      });
      print('Error fetching cover-up requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: customAppBar(
        title: 'Cover-Up Requests',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      drawer: CustomSidebar(token: widget.token), // Add your custom sidebar here
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: coverUpDetails.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(15.0),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${coverUpDetails[index].date}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(
                    'Leave Type: ${coverUpDetails[index].leaveType}',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    'Reason: ${coverUpDetails[index].reason}',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    'Time: ${coverUpDetails[index].time}',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  Text(
                    'Covered By: ${coverUpDetails[index].extra}',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
              trailing: CoverActionButton(
                token: widget.token,
                id: coverUpDetails[index].id,
                onActionCompleted: widget.onActionCompleted,
              ),
            ),
          );
        },
      ),
    );
  }
}


class CoverActionButton extends StatelessWidget {
  final String token;
  final int id;
  final Future<void> Function() onActionCompleted; // Added refresh function

  const CoverActionButton({Key? key, required this.token, required this.id, required this.onActionCompleted})
      : super(key: key);

  Future<void> _showSuccessDialog(
      BuildContext context, String message, String action) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                action == "approve" ? Icons.check_circle : Icons.error,
                color: action == "approve" ? Colors.green : Colors.red,
              ),
              SizedBox(width: 10),
              Text('Success'),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCommentDialog(BuildContext context, String action) async {
    TextEditingController commentController = TextEditingController();
    bool isLoading = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Comment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: commentController,
                    decoration: InputDecoration(hintText: 'Enter your comment'),
                  ),
                  if (isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss the dialog
                  },
                ),
                TextButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await ApiService().approveCoverUp(
                              token,
                              [id],
                              action,
                              commentController.text,
                            );
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(dialogContext)
                                .pop(); // Dismiss the dialog
                            await _showSuccessDialog(context,
                                'Cover-up $action successfully!', action);
                                 onActionCompleted(); // Trigger page refresh
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "approve"),
          child: Text(
            'Accept',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: 4.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "reject"),
          child: Text(
            'Decline',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}