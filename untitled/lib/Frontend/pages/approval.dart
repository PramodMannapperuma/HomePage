// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../app_bar.dart';
// import '../../Backend/models/subordinate_model.dart';
// import '../../Backend/models/leave_approval.dart';
// import '../../Backend/models/att_approval.dart';
// import 'package:untitled/Backend/APIs/Apis.dart';
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
//           .where((subordinate) =>
//           subordinate.name
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
//                 : ListView.builder(
//               itemCount: filteredSubordinates.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   contentPadding: EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 10.0),
//                   title: Text(
//                     filteredSubordinates[index].name,
//                     style: TextStyle(
//                       fontSize: 17.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     filteredSubordinates[index].designation,
//                     style: TextStyle(
//                       fontSize: 15.0,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                   trailing: Icon(
//                     Icons.arrow_forward_ios,
//                     color: Colors.grey[600],
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             EmployeeDetailsScreen(
//                               employeeName:
//                               filteredSubordinates[index].name,
//                               employeeId: filteredSubordinates[index].id,
//                               token: widget.token,
//                             ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
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
//   //ID list to be sent

//   @override
//   void initState() {
//     super.initState();
//     _fetchLeaveRequests();
//     _fetchAttendanceRecords();
//     //POST of leave and attendance approval
//   }

//   Future<void> _fetchLeaveRequests() async {
//     try {
//       final response = await ApiService()
//           .fetchLeaveRequests(widget.employeeId, widget.token);
//       leaveRequests = response;
//       setState(() {
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
//       attendanceRecords = response.cast<AttApproval>();
//       setState(() {
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print('Error fetching attendance records: $e');
//     }
//   }
//   //post to send attenace and leave

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
//                   AttendanceDetailsTab(attendanceRecords: attendanceRecords),
//                   SectionHeader(title: 'Leave Request Details'),
//                   LeaveRequestsTab(leaveRequests: leaveRequests),
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

//   const AttendanceDetailsTab({Key? key, required this.attendanceRecords})
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
//                     style: TextStyle(fontSize: 15.0),
//                 ),
//                 Text(
//                   'Time Out: ${attendanceRecords[index].amdOut}',
//                     style: TextStyle(fontSize: 15.0),
//                   ),

//                 Text(
//                   'Comment: ${attendanceRecords[index].amdComment}',
//                     style: TextStyle(fontSize: 15.0),
//                 ),
//               ],
//             ),
//             trailing: ActionButton(), // trailing: ActionButtons(),
//           ),
//         );
//       },
//     );
//   }
// }

// class LeaveRequestsTab extends StatelessWidget {
//   final List<LeaveApproval> leaveRequests;

//   const LeaveRequestsTab({Key? key, required this.leaveRequests})
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
//             trailing: ActionButtons(),
//           ),
//         );
//       },
//     );
//   }
// }
// class ActionButton extends StatelessWidget {
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
//             padding: EdgeInsets.symmetric(
//                 horizontal: 8.0, vertical: 4.0), // Smaller button
//           ),
//           onPressed: () {
//             // Handle accept action
//             //Call POST function to accept the attendance
//             //Have to send id ina list and action
//           },
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
//             padding: EdgeInsets.symmetric(
//                 horizontal: 8.0, vertical: 4.0), // Smaller button
//           ),
//           onPressed: () {
//             // Handle decline action
//           },
//           child: Text(
//             'Decline',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ActionButtons extends StatelessWidget {
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
//             padding: EdgeInsets.symmetric(
//                 horizontal: 8.0, vertical: 4.0), // Smaller button
//           ),
//           onPressed: () {
//             // Handle accept action
//             //Call POST function to accept the leave
//             //Have to send id ina list and action
//           },
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
//             padding: EdgeInsets.symmetric(
//                 horizontal: 8.0, vertical: 4.0), // Smaller button
//           ),
//           onPressed: () {
//             // Handle decline action
//           },
//           child: Text(
//             'Decline',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../app_bar.dart';
import '../../Backend/models/subordinate_model.dart';
import '../../Backend/models/cover_up_detail.dart';
import '../../Backend/models/leave_approval.dart';
import '../../Backend/models/att_approval.dart';
import '../styles/sidebar.dart';

class ApprovalScreen extends StatefulWidget {
  final String token;

  const ApprovalScreen({Key? key, required this.token}) : super(key: key);

  @override
  _ApprovalScreenState createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
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
      body: EmployeeListScreen(token: widget.token),
    );
  }
}

class EmployeeListScreen extends StatefulWidget {
  final String token;

  const EmployeeListScreen({Key? key, required this.token}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Subordinate> subordinates = [];
  List<Subordinate> filteredSubordinates = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSubordinates();
    searchController.addListener(_filterSubordinates);
  }

  Future<void> _fetchSubordinates() async {
    try {
      subordinates = await ApiService().fetchSubordinates(widget.token);
      setState(() {
        filteredSubordinates = subordinates;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching subordinates: $e');
    }
  }

  void _filterSubordinates() {
    setState(() {
      filteredSubordinates = subordinates
          .where((subordinate) =>
              subordinate.name.toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              hintText: 'Search Employees',
              hintStyle: TextStyle(color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredSubordinates.isEmpty
                    ? Center(child: Text('No employees found'))
                    : ListView.builder(
                        itemCount: filteredSubordinates.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            title: Text(
                              filteredSubordinates[index].name,
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              filteredSubordinates[index].designation,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[600],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmployeeDetailsScreen(
                                    employeeName: filteredSubordinates[index].name,
                                    employeeId: filteredSubordinates[index].id,
                                    token: widget.token,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class EmployeeDetailsScreen extends StatefulWidget {
  final String employeeName;
  final String employeeId;
  final String token;

  const EmployeeDetailsScreen({
    Key? key,
    required this.employeeName,
    required this.employeeId,
    required this.token,
  }) : super(key: key);

  @override
  _EmployeeDetailsScreenState createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  bool isLoading = true;
  List<LeaveApproval> leaveRequests = [];
  List<AttApproval> attendanceRecords = [];
  List<CoverUpDetail> coverUpDetails = [];

  @override
  void initState() {
    super.initState();
    _fetchLeaveRequests();
    _fetchAttendanceRecords();
    _fetchCoverUpDetails();
  }

  Future<void> _fetchLeaveRequests() async {
    try {
      final response = await ApiService().fetchLeaveRequests(widget.employeeId, widget.token);
      setState(() {
        leaveRequests = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching leave requests: $e');
    }
  }

  Future<void> _fetchAttendanceRecords() async {
    try {
      final response = await ApiService().fetchAttendanceRecords(widget.employeeId, widget.token);
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

  Future<void> _fetchCoverUpDetails() async {
    try {
      final response = await ApiService.getCoverUpDetails(widget.token, int.parse(widget.employeeId));
      setState(() {
        coverUpDetails = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching cover-up details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: '${widget.employeeName} - Approval Details',
        showActions: false,
        showLeading: true,
        context: context,
        showBackButton: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  SectionHeader(title: 'Attendance Details'),
                  attendanceRecords.isEmpty
                      ? Center(child: Text('No attendance records found'))
                      : AttendanceDetailsTab(attendanceRecords: attendanceRecords, token: widget.token),
                  SectionHeader(title: 'Leave Request Details'),
                  leaveRequests.isEmpty
                      ? Center(child: Text('No leave requests found'))
                      : LeaveRequestsTab(leaveRequests: leaveRequests, token: widget.token),
                  SectionHeader(title: 'Cover-Up Request Details'),
                  coverUpDetails.isEmpty
                      ? Center(child: Text('No cover-up requests found'))
                      : CoverUpRequestTab(coverUpDetails: coverUpDetails, token: widget.token),
                ],
              ),
            ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff4d2880),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class AttendanceDetailsTab extends StatelessWidget {
  final List<AttApproval> attendanceRecords;
  final String token;

  const AttendanceDetailsTab({Key? key, required this.attendanceRecords, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
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
              token: token,
              id: attendanceRecords[index].id,
            ),
          ),
        );
      },
    );
  }
}

class LeaveRequestsTab extends StatelessWidget {
  final List<LeaveApproval> leaveRequests;
  final String token;

  const LeaveRequestsTab({Key? key, required this.leaveRequests, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: leaveRequests.length,
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
                  'ID: ${leaveRequests[index].id}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text(
                  'Date: ${leaveRequests[index].date}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text('Leave Type: ${leaveRequests[index].leaveType}', style: TextStyle(fontSize: 15.0)),
                Text(
                  'Reason: ${leaveRequests[index].reason}',
                  style: TextStyle(fontSize: 15.0),
                ),
                Text(
                  'Time: ${leaveRequests[index].time}',
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
            trailing: LeaveActionButton(
              token: token,
              id: leaveRequests[index].id,
            ),
          ),
        );
      },
    );
  }
}

class CoverUpRequestTab extends StatelessWidget {
  final List<CoverUpDetail> coverUpDetails;
  final String token;

  const CoverUpRequestTab({Key? key, required this.coverUpDetails, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: coverUpDetails.length,
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
                  'Date: ${coverUpDetails[index].date}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text('Leave Type: ${coverUpDetails[index].leaveType}',
                    style: TextStyle(fontSize: 15.0)),
                Text(
                  'Reason: ${coverUpDetails[index].reason}',
                  style: TextStyle(fontSize: 15.0),
                ),
                Text(
                  'Time: ${coverUpDetails[index].time}',
                  style: TextStyle(fontSize: 15.0),
                ),
                Text(
                  'Covered By: ${coverUpDetails[index].extra}',
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
            trailing: CoverActionButton(
              token: token,
              id: coverUpDetails[index].id,
            ),
          ),
        );
      },
    );
  }
}

class AttActionButton extends StatelessWidget {
  final String token;
  final int id;

  const AttActionButton({Key? key, required this.token, required this.id}) : super(key: key);

  Future<void> _showSuccessDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
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
    bool isSubmitted = false;
    String? errorMessage;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Comment'),
              content: isLoading
                  ? Center(
                      child: SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Enter your comment',
                            errorText: errorMessage,
                          ),
                        ),
                        if (isSubmitted)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: FlareActor(
                                "assets/checkmark.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: "checkmark",
                              ),
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
                            errorMessage = null;
                          });

                          try {
                            await ApiService().approveAttendance(
                              token,
                              [id],
                              action,
                              commentController.text,
                            );
                            setState(() {
                              isSubmitted = true;
                            });
                            await Future.delayed(Duration(seconds: 2)); // Wait for animation
                            Navigator.of(dialogContext).pop(); // Dismiss the dialog
                            await _showSuccessDialog(context, 'Attendance $action successfully!');
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                              errorMessage = 'Failed to submit. Please try again.';
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

class LeaveActionButton extends StatelessWidget {
  final String token;
  final int id;

  const LeaveActionButton({Key? key, required this.token, required this.id}) : super(key: key);

  Future<void> _showSuccessDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
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
    bool isSubmitted = false;
    String? errorMessage;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Comment'),
              content: isLoading
                  ? Center(
                      child: SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Enter your comment',
                            errorText: errorMessage,
                          ),
                        ),
                        if (isSubmitted)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: FlareActor(
                                "assets/checkmark.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: "checkmark",
                              ),
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
                            errorMessage = null;
                          });

                          try {
                            await ApiService().approveLeave(
                              token,
                              [id],
                              action,
                              commentController.text,
                            );
                            setState(() {
                              isSubmitted = true;
                            });
                            await Future.delayed(Duration(seconds: 2)); // Wait for animation
                            Navigator.of(dialogContext).pop(); // Dismiss the dialog
                            await _showSuccessDialog(context, 'Leave $action successfully!');
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                              errorMessage = 'Failed to submit. Please try again.';
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

class CoverActionButton extends StatelessWidget {
  final String token;
  final int id;

  const CoverActionButton({Key? key, required this.token, required this.id}) : super(key: key);

  Future<void> _showSuccessDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK', style: TextStyle(color: Theme.of(context).primaryColor)),
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
    bool isSubmitted = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Comment'),
              content: isLoading
                  ? Center(
                      child: SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Enter your comment',
                          ),
                        ),
                        if (isSubmitted)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: FlareActor(
                                "assets/checkmark.flr",
                                alignment: Alignment.center,
                                fit: BoxFit.contain,
                                animation: "checkmark",
                              ),
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
                              isSubmitted = true;
                            });
                            await Future.delayed(Duration(seconds: 2)); // Wait for animation
                            Navigator.of(dialogContext).pop(); // Dismiss the dialog
                            await _showSuccessDialog(context, 'Cover-Up $action successfully!');
                          } catch (e) {
                            Navigator.of(dialogContext).pop(); // Dismiss the dialog
                            print('Error $action cover-up: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to ${action == "approve" ? "approve" : "reject"} cover-up',
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
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
