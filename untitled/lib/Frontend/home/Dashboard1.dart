// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../Backend/APIs/Apis.dart';
// import '../../Backend/models/dash_model.dart';
// import '../styles/app_colors.dart';
// import '../styles/sidebar.dart';

// class DashMainScreen extends StatefulWidget {
//   final String token;

//   DashMainScreen({super.key, required this.token});

//   @override
//   _DashMainScreenState createState() => _DashMainScreenState();
// }

// class _DashMainScreenState extends State<DashMainScreen> {
//   late Future<DashboardData> futureDashboardData;
//   final ApiService apiService = ApiService();

//   @override
//   void initState() {
//     super.initState();
//     futureDashboardData = apiService.fetchDashboardData(widget.token);
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
//               Navigator.pushNamed(context, '/profile');
//             },
//           ),
//         ],
//       ),
//       drawer: CustomSidebar(),
//       body: FutureBuilder<DashboardData>(
//         future: futureDashboardData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             return const Center(child: Text('No data available'));
//           }

//           DashboardData data = snapshot.data!;

//           String workingDays = data.attendance?.working?.toString() ?? 'N/A' ;
//           String noPay = data.attendance?.nopay?.toString() ?? 'N/A';

//           // Extract attendance data
//           String complete = data.attendance?.attendance?.attendance?.toString() ?? 'N/A';
//           String incomplete = data.attendance?.attendance?.rejected?.toString() ?? 'N/A';
//           String pending = data.attendance?.attendance?.pending?.toString() ?? 'N/A';
//           String rejected = data.attendance?.attendance?.rejected?.toString() ?? 'N/A';

//           // Extract leave balance data
//           String leaveTaken = data.attendance?.leave?.active?.toString() ?? 'N/A';
//           String leavePending = data.attendance?.leave?.pending?.toString() ?? 'N/A';
//           String leaveRejected = data.attendance?.leave?.rejected?.toString() ?? 'N/A';

//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // User Info
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 30,
//                         backgroundImage: AssetImage(
//                             'assets/images/2.-electronic-evan (1).jpg'),
//                       ),
//                       SizedBox(width: 10),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             data.employee?.name ?? 'N/A',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(data.employee?.designation ?? 'N/A'),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),

//                   // Dashboard title
//                   Text(
//                     'Dashboard',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   Container(
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Working Days and No Pay',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buildAttendanceItem('Working Days', workingDays, Colors.green),
//                             _buildAttendanceItem('No Pay', noPay, Colors.red),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   // Attendance section
//                   Container(
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Attendance',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buildAttendanceItem('Complete', complete, Colors.green),
//                             _buildAttendanceItem('Incomplete', incomplete, Colors.orange),
//                             _buildAttendanceItem('Pending', pending, Colors.blue),
//                             _buildAttendanceItem('Rejected', rejected, Colors.red),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   // Leave section
//                   Container(
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3), // changes position of shadow
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Leave Balance',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _buildLeaveItem('Taken', leaveTaken),
//                             _buildLeaveItem('Pending', leavePending),
//                             _buildLeaveItem('Rejected', leaveRejected),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // Widget _buildProfileInfoItem(String title, String value, Color color) {
//   //   return Expanded(
//   //     child: Column(
//   //       children: [
//   //         Text(
//   //           value,
//   //           style: TextStyle(
//   //             fontSize: 24,
//   //             fontWeight: FontWeight.bold,
//   //             color: color,
//   //           ),
//   //         ),
//   //         SizedBox(height: 5),
//   //         Text(
//   //           title,
//   //           style: TextStyle(
//   //             fontSize: 16,
//   //             color: Colors.grey,
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }

//   Widget _buildAttendanceItem(String title, String value, Color color) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLeaveItem(String title, String value) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.blue,
//           ),
//         ),
//         SizedBox(height: 5),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     );
//   }
//   //
//   // Widget _buildTaskItem(String title, String subtitle, Color color) {
//   //   return Padding(
//   //     padding: const EdgeInsets.symmetric(vertical: 8.0),
//   //     child: Row(
//   //       children: [
//   //         Icon(Icons.check_circle_outline, color: color),
//   //         SizedBox(width: 10),
//   //         Column(
//   //           crossAxisAlignment: CrossAxisAlignment.start,
//   //           children: [
//   //             Text(
//   //               title,
//   //               style: TextStyle(
//   //                 fontSize: 16,
//   //                 fontWeight: FontWeight.bold,
//   //               ),
//   //             ),
//   //             SizedBox(height: 5),
//   //             Text(
//   //               subtitle,
//   //               style: TextStyle(
//   //                 fontSize: 14,
//   //                 color: Colors.grey,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }

//------------------------------------code with the calander----------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/Frontend/pages/calender_page.dart';
import '../../Backend/APIs/Apis.dart';
import '../../Backend/models/dash_model.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class DashMainScreen extends StatefulWidget {
  final String token;

  DashMainScreen({super.key, required this.token});

  @override
  _DashMainScreenState createState() => _DashMainScreenState();
}

class _DashMainScreenState extends State<DashMainScreen> {
  late Future<DashboardData> futureDashboardData;
  final ApiService apiService = ApiService();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    futureDashboardData = apiService.fetchDashboardData(widget.token);
    _selectedDay = _focusedDay;
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
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      drawer: CustomSidebar(),
      body: FutureBuilder<DashboardData>(
        future: futureDashboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available'));
          }

          DashboardData data = snapshot.data!;

          String workingDays = data.attendance?.working?.toString() ?? 'N/A';
          String noPay = data.attendance?.nopay?.toString() ?? 'N/A';

          // Extract attendance data
          String complete = data.attendance?.attendance?.attendance?.toString() ?? 'N/A';
          String incomplete = data.attendance?.attendance?.incomplete?.toString() ?? 'N/A';
          String pending = data.attendance?.attendance?.pending?.toString() ?? 'N/A';
          String rejected = data.attendance?.attendance?.rejected?.toString() ?? 'N/A';

          // Extract leave balance data
          String leaveTaken = data.attendance?.leave?.active?.toString() ?? 'N/A';
          String leavePending = data.attendance?.leave?.pending?.toString() ?? 'N/A';
          String leaveRejected = data.attendance?.leave?.rejected?.toString() ?? 'N/A';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/images/2.-electronic-evan (1).jpg'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.employee?.name ?? 'N/A',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(data.employee?.designation ?? 'N/A'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Dashboard title
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Calendar Section
                  // CalendarPage(token:widget.token),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: TableCalendar(
                      rowHeight: 35,
                      headerStyle: HeaderStyle(
                        titleCentered: true,
                      ),
                      focusedDay: _focusedDay,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      onDaySelected: (selectedDate, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDate)) {
                          setState(() {
                            _selectedDay = selectedDate;
                            _focusedDay = focusedDay;
                          });
                        }
                      },
                      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                      firstDay: DateTime.utc(2023, 01, 01),
                      lastDay: DateTime.utc(3030, 12, 31),
                      calendarFormat: _calendarFormat,
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
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

                  // Working Days and No Pay section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Working Days and No Pay',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildAttendanceItem('Working Days', workingDays, Colors.green),
                            _buildAttendanceItem('No Pay', noPay, Colors.red),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Attendance section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildAttendanceItem('Complete', complete, Colors.green),
                            _buildAttendanceItem('Incomplete', incomplete, Colors.orange),
                            _buildAttendanceItem('Pending', pending, Colors.blue),
                            _buildAttendanceItem('Rejected', rejected, Colors.red),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Leave section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Leave Balance',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildLeaveItem('Taken', leaveTaken),
                            _buildLeaveItem('Pending', leavePending),
                            _buildLeaveItem('Rejected', leaveRejected),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAttendanceItem(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildLeaveItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}