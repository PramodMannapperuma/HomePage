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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../app_bar.dart';
import '../../Backend/models/subordinate_model.dart';
import '../../Backend/models/leave_approval.dart';
import '../../Backend/models/att_approval.dart';
import '../../Backend/models/cover_up_detail.dart'; // Import CoverUpDetail model
import 'package:untitled/Backend/APIs/Apis.dart';
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
                : ListView.builder(
                    itemCount: filteredSubordinates.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
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
  List<CoverUpDetail> coverUpDetails = []; // Add this to store cover-up details

  @override
  void initState() {
    super.initState();
    _fetchLeaveRequests();
    _fetchAttendanceRecords();
    _fetchCoverUpDetails(); // Fetch cover-up details
  }

  Future<void> _fetchLeaveRequests() async {
    try {
      final response = await ApiService()
          .fetchLeaveRequests(widget.employeeId, widget.token);
      leaveRequests = response;
      setState(() {
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
      final response = await ApiService()
          .fetchAttendanceRecords(widget.employeeId, widget.token);
      attendanceRecords = response.cast<AttApproval>();
      setState(() {
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
      coverUpDetails = response;
      setState(() {
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
                  AttendanceDetailsTab(attendanceRecords: attendanceRecords),
                  SectionHeader(title: 'Leave Request Details'),
                  LeaveRequestsTab(leaveRequests: leaveRequests),
                  SectionHeader(title: 'Cover-Up Request Details'), // Add Cover-Up section header
                  CoverUpDetailsTab(coverUpDetails: coverUpDetails), // Display Cover-Up details
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

  const AttendanceDetailsTab({Key? key, required this.attendanceRecords})
      : super(key: key);

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
            trailing: ActionButton(), // trailing: ActionButtons(),
          ),
        );
      },
    );
  }
}

class LeaveRequestsTab extends StatelessWidget {
  final List<LeaveApproval> leaveRequests;

  const LeaveRequestsTab({Key? key, required this.leaveRequests})
      : super(key: key);

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
                  'Date: ${leaveRequests[index].date}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text('Leave Type: ${leaveRequests[index].leaveType}',
                    style: TextStyle(fontSize: 15.0)),
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
            trailing: ActionButtons(),
          ),
        );
      },
    );
  }
}

class CoverUpDetailsTab extends StatelessWidget {
  final List<CoverUpDetail> coverUpDetails;

  const CoverUpDetailsTab({Key? key, required this.coverUpDetails}) : super(key: key);

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
            trailing: ActionButtons(),
          ),
        );
      },
    );
  }
}

class ActionButton extends StatelessWidget {
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
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 4.0), // Smaller button
          ),
          onPressed: () {
            // Handle accept action
            //Call POST function to accept the attendance
            //Have to send id in a list and action
          },
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
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 4.0), // Smaller button
          ),
          onPressed: () {
            // Handle decline action
          },
          child: Text(
            'Decline',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
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
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 4.0), // Smaller button
          ),
          onPressed: () {
            // Handle accept action
            //Call POST function to accept the leave
            //Have to send id in a list and action
          },
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
            padding: EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 4.0), // Smaller button
          ),
          onPressed: () {
            // Handle decline action
          },
          child: Text(
            'Decline',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
