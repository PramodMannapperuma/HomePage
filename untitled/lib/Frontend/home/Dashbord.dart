// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled/Backend/APIs/Apis.dart';
// import 'package:untitled/Frontend/geolocation.dart';
// import 'package:untitled/Frontend/pages/pending_leave.dart';
// import 'package:untitled/Frontend/pages/pending_attendance.dart';
// import '../../../Frontend/pages/attendance.dart';
// import '../../../Frontend/pages/leave.dart';
// import '../pages/employee.dart';
// import '../styles/app_colors.dart';
// import '../styles/sidebar.dart';
// import 'Dashboard1.dart';
// import 'dart:typed_data';

// class MainScreen extends StatefulWidget {
//   final String token;

//   const MainScreen({super.key, required this.token});

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 2; // Default to Dashboard screen
//   late List<Widget> _widgetOptions;
//   String? _lastLogin;

//   @override
//   void initState() {
//     super.initState();
//     _saveCurrentLogin();
//     _loadLastLogin();
//     print('Token in Main Screen: ${widget.token}');
//     _widgetOptions = <Widget>[
//       Attendance(token: widget.token),
//       Leave(token: widget.token),
//       DashboardScreen(token: widget.token, lastLogin: _lastLogin),
//       DashMainScreen(token: widget.token),
//       EmployeeScreen(token: widget.token),
//     ];
//   }

//   Future<void> _saveCurrentLogin() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String currentLogin = DateTime.now().toIso8601String();
//     await prefs.setString('lastLogin', currentLogin);
//   }

//   Future<void> _loadLastLogin() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? lastLogin = prefs.getString('lastLogin');
//     setState(() {
//       _lastLogin = lastLogin;
//       _widgetOptions[2] =
//           DashboardScreen(token: widget.token, lastLogin: _lastLogin);
//     });
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (index == 2) {
//         _widgetOptions[2] =
//             DashboardScreen(token: widget.token, lastLogin: _lastLogin);
//       }
//     });
//   }

//   Future<bool> _onWillPop() async {
//     bool? shouldLogout = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Confirm Logout'),
//         content: Text('Are you sure you want to log out from the app?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: Text('No'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: Text('Yes'),
//           ),
//         ],
//       ),
//     );

//     if (shouldLogout ?? false) {
//       Navigator.of(context).pushReplacementNamed('/login');
//       return true;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WillPopScope(
//         onWillPop: _onWillPop,
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: Container(
//         height: 86,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             BottomNavigationBar(
//               items: [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.calendar_month, color: AppColors.background),
//                   label: 'Attendance',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.beach_access_outlined,
//                       color: AppColors.background),
//                   label: 'Leave',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home_outlined, color: AppColors.background),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.dashboard_customize_outlined,
//                       color: AppColors.background),
//                   label: 'Dashboard',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.group_add_outlined,
//                       color: AppColors.background),
//                   label: 'My Team',
//                 ),
//               ],
//               currentIndex: _selectedIndex,
//               selectedItemColor: Colors.purple,
//               onTap: _onItemTapped,
//               selectedLabelStyle: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//               unselectedLabelStyle: TextStyle(
//                 fontWeight: FontWeight.normal,
//               ),
//             ),
//             FadeInText(), // Custom widget for animated text
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FadeInText extends StatefulWidget {
//   @override
//   _FadeInTextState createState() => _FadeInTextState();
// }

// class _FadeInTextState extends State<FadeInText>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _controller;
//   Animation<double>? _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//     _opacityAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
//     _controller!.forward();
//   }

//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: _opacityAnimation!,
//       child: Text(
//         '© Powered by Accelution',
//         style: TextStyle(
//           fontSize: 16,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }
// }

// class DashboardScreen extends StatefulWidget {
//   final String token;
//   final String? lastLogin;

//   const DashboardScreen({
//     super.key,
//     required this.token,
//     required this.lastLogin,
//   });

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   final List<Map<String, String>> birthdays = [
//     {'name': 'Mark', 'birthday': 'August 3'},
//     {'name': 'Sophia', 'birthday': 'September 12'},
//     {'name': 'John', 'birthday': 'October 7'},
//     {'name': 'Lisa', 'birthday': 'August 22'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     print('Token in DashboardScreen: ${widget.token}');
//     final currentMonth = DateFormat('MMMM').format(DateTime.now());

//     final filteredBirthdays = birthdays.where((birthday) {
//       final birthdayMonth = birthday['birthday']!.split(' ')[0];
//       return birthdayMonth == currentMonth;
//     }).toList();

//     return FutureBuilder<Map<String, dynamic>>(
//       future: ApiService.getProfile(widget.token),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data == null) {
//           return Center(child: Text('No data available'));
//         }

//         final userData = snapshot.data!;
//         String name = userData['fullName'] ?? 'N/A';
//         String designation = userData['designation'] ?? 'N/A';

//         return Scaffold(
//           appBar: AppBar(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/hrislogo2.png',
//                   height: 40.0,
//                 ),
//                 SizedBox(width: 8.0),
//               ],
//             ),
//             centerTitle: true,
//             systemOverlayStyle: const SystemUiOverlayStyle(
//               statusBarColor: Colors.transparent,
//               statusBarIconBrightness: Brightness.dark,
//             ),
//             leading: Builder(
//               builder: (BuildContext context) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.menu_outlined,
//                       color: AppColors.background,
//                     ),
//                     onPressed: () {
//                       Scaffold.of(context).openDrawer();
//                     },
//                   ),
//                 );
//               },
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.notifications_active_outlined,
//                   color: AppColors.background,
//                 ),
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/coverupRequest',
//                       arguments: widget.token);
//                 },
//               ),
//               IconButton(
//                 icon: const Icon(
//                   Icons.person,
//                   color: AppColors.background,
//                 ),
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/profile',
//                       arguments: widget.token);
//                 },
//               ),
//             ],
//           ),
//           drawer: CustomSidebar(token: widget.token),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.pushNamed(context, '/profile',
//                           arguments: widget.token);
//                     },
//                     child: Row(
//                       children: [
//                         FutureBuilder<Uint8List>(
//                           future: ApiService.fetchProfilePicture(widget.token),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return CircleAvatar(
//                                 radius: 45,
//                                 child: Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                               );
//                             } else if (snapshot.hasError) {
//                               return CircleAvatar(
//                                 radius: 45,
//                                 backgroundImage:
//                                     AssetImage('assets/images/profile.png'),
//                               );
//                             } else if (snapshot.hasData) {
//                               return CircleAvatar(
//                                 radius: 45,
//                                 backgroundImage: MemoryImage(snapshot.data!),
//                               );
//                             } else {
//                               return CircleAvatar(
//                                 radius: 45,
//                                 backgroundImage:
//                                     AssetImage('assets/images/profile.png'),
//                               );
//                             }
//                           },
//                         ),
//                         SizedBox(width: 10),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               name,
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(designation),
//                             if (widget.lastLogin != null)
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Last Login:',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Text(
//                                     _formatDateTime(widget.lastLogin!),
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey[700],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Divider(thickness: 2, height: 10),
//                   SizedBox(height: 10),

//                   // Categories
//                   Text(
//                     'Categories',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   GridView.count(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                     childAspectRatio: 7 / 5,
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       CategoryCard(
//                         title: 'Attendance',
//                         icon: Icons.calendar_month,
//                         route: '/attendance',
//                         token: widget.token,
//                       ),
//                       CategoryCard(
//                         title: 'Leave',
//                         icon: Icons.beach_access,
//                         route: '/leave',
//                         token: widget.token,
//                       ),
//                       CategoryCard(
//                         title: 'Requests',
//                         icon: Icons.list_alt,
//                         route: '/requests',
//                         token: widget.token,
//                       ),
//                       CategoryCard(
//                         title: 'Profile',
//                         icon: Icons.person_outline,
//                         route: '/profile',
//                         token: widget.token,
//                       ),
//                       CategoryCard(
//                         title: 'Payslips',
//                         icon: Icons.payment,
//                         route: '/payslips',
//                         token: widget.token,
//                       ),
//                       CategoryCard(
//                         title: 'Approval',
//                         icon: Icons.file_copy_outlined,
//                         route: '/approval',
//                         token: widget.token,
//                       ),
//                       CategoryCard(
//                         title: 'My Team',
//                         icon: Icons.group_add_outlined,
//                         route: '/employee',
//                         token: widget.token,
//                       ),
//                       CategoryCard(
//                         title: 'Policy',
//                         icon: Icons.task_outlined,
//                         route: '/policies',
//                         token: widget.token,
//                       ),
//                       CategoryCard(
//                         title: 'News',
//                         icon: Icons.newspaper,
//                         route: '/taskScreen',
//                         token: widget.token,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Divider(thickness: 2, height: 10),
//                   SizedBox(height: 10),

//                   // Recent Leave Request
//                   Text(
//                     'Recent Requests',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   // RecentLeaveRequestCard(
//                   //   leaveType: '3 Days Leave',
//                   //   status: 'Processing',
//                   // ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               LeaveDetailsScreen(token: widget.token),
//                         ),
//                       );
//                     },
//                     child: RecentLeaveRequestCard(
//                       leaveType: 'Leaves',
//                       status: 'Processing',
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               PendingAttendanceScreen(token: widget.token),
//                         ),
//                       );
//                     },
//                     child: RecentLeaveRequestCard(
//                       leaveType: 'Attendance',
//                       status: 'Processing',
//                     ),
//                   ),
//                   RecentLeaveRequestCard(
//                     leaveType: 'Visa Letter',
//                     status: 'Processing',
//                   ),

//                   SizedBox(height: 20),
//                   Divider(thickness: 2, height: 10),

//                   // Employee Birthdays
//                   if (filteredBirthdays.isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Birthdays',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         ...filteredBirthdays.map((birthday) {
//                           return EmployeeBirthdayCard(
//                             name: birthday['name']!,
//                             birthday: birthday['birthday']!,
//                             imagePath: 'assets/images/profile.png',
//                           );
//                         }).toList(),
//                       ],
//                     )
//                   else
//                     Text(
//                       'No birthdays this month.',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _formatDateTime(String dateTimeString) {
//     final dateTime = DateTime.parse(dateTimeString);
//     final formatter = DateFormat('MMMM dd, yyyy hh:mm a');
//     return formatter.format(dateTime);
//   }
// }

// class CategoryCard extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final String route;
//   final String token;

//   const CategoryCard(
//       {required this.title,
//       required this.icon,
//       required this.route,
//       required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 10,
//       width: 10,
//       child: Card(
//         child: InkWell(
//           onTap: () {
//             Navigator.pushNamed(
//               context,
//               route,
//               arguments: token,
//             );
//           },
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 25, color: AppColors.background),
//               SizedBox(height: 10),
//               Text(title, style: TextStyle(fontSize: 14)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class RecentLeaveRequestCard extends StatelessWidget {
//   final String leaveType;
//   final String status;

//   const RecentLeaveRequestCard({required this.leaveType, required this.status});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(leaveType),
//         trailing: Text(
//           status,
//           style: TextStyle(color: Colors.blue),
//         ),
//       ),
//     );
//   }
// }

// class EmployeeBirthdayCard extends StatelessWidget {
//   final String name;
//   final String birthday;
//   final String imagePath;

//   const EmployeeBirthdayCard({
//     required this.name,
//     required this.birthday,
//     required this.imagePath,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final DateTime date = DateFormat('MMMM d').parse(birthday);
//     final String day = DateFormat('d').format(date);
//     final String month = DateFormat('MMM').format(date);

//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 25, // Reduced radius to decrease the height
//               backgroundImage: AssetImage(imagePath),
//             ),
//             const SizedBox(width: 12), // Adjusted spacing
//             Expanded(
//               child: Text(
//                 name,
//                 style: TextStyle(
//                   fontSize: 16, // Slightly reduced font size for balance
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(
//                   vertical: 6,
//                   horizontal: 10), // Reduced padding to decrease height
//               decoration: BoxDecoration(
//                 color: Colors.purple[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     month,
//                     style: TextStyle(
//                       fontSize: 13, // Slightly reduced font size for balance
//                       fontWeight: FontWeight.bold,
//                       color: Colors.purple[800],
//                     ),
//                   ),
//                   Text(
//                     day,
//                     style: TextStyle(
//                       fontSize: 22, // Slightly reduced font size for balance
//                       fontWeight: FontWeight.bold,
//                       color: Colors.purple[800],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import 'package:untitled/Frontend/pages/pending_leave.dart';
import 'package:untitled/Frontend/pages/pending_attendance.dart';
import '../../../Frontend/pages/attendance.dart';
import '../../../Frontend/pages/leave.dart';
import '../pages/employee.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';
import 'Dashboard1.dart';
import 'dart:typed_data';
import 'package:untitled/Frontend/pages/celebrations.dart';

class MainScreen extends StatefulWidget {
  final String token;

  const MainScreen({super.key, required this.token});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2; // Default to Dashboard screen
  late List<Widget> _widgetOptions;
  String? _lastLogin;

  @override
  void initState() {
    super.initState();
    _saveCurrentLogin();
    _loadLastLogin();
    print('Token in Main Screen: ${widget.token}');
    _widgetOptions = <Widget>[
      Attendance(token: widget.token),
      Leave(token: widget.token),
      DashboardScreen(token: widget.token, lastLogin: _lastLogin),
      DashMainScreen(token: widget.token),
      EmployeeScreen(token: widget.token),
    ];
  }

  Future<void> _saveCurrentLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String currentLogin = DateTime.now().toIso8601String();
    await prefs.setString('lastLogin', currentLogin);
  }

  Future<void> _loadLastLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? lastLogin = prefs.getString('lastLogin');
    setState(() {
      _lastLogin = lastLogin;
      _widgetOptions[2] =
          DashboardScreen(token: widget.token, lastLogin: _lastLogin);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        _widgetOptions[2] =
            DashboardScreen(token: widget.token, lastLogin: _lastLogin);
      }
    });
  }

  Future<bool> _onWillPop() async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to log out from the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    if (shouldLogout ?? false) {
      Navigator.of(context).pushReplacementNamed('/login');
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 86,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month, color: AppColors.background),
                  label: 'Attendance',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.beach_access_outlined,
                      color: AppColors.background),
                  label: 'Leave',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, color: AppColors.background),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_customize_outlined,
                      color: AppColors.background),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.group_add_outlined,
                      color: AppColors.background),
                  label: 'My Team',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.purple,
              onTap: _onItemTapped,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            FadeInText(), // Custom widget for animated text
          ],
        ),
      ),
    );
  }
}

class FadeInText extends StatefulWidget {
  @override
  _FadeInTextState createState() => _FadeInTextState();
}

class _FadeInTextState extends State<FadeInText>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation!,
      child: Text(
        '© Powered by Accelution',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final String token;
  final String? lastLogin;

  const DashboardScreen({
    super.key,
    required this.token,
    required this.lastLogin,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, String>> birthdays = [
    {'name': 'Mark', 'birthday': 'August 3'},
    {'name': 'Sophia', 'birthday': 'September 12'},
    {'name': 'John', 'birthday': 'October 7'},
    {'name': 'Lisa', 'birthday': 'August 22'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBirthdayPopupIfNeeded();
    });
  }

// Show birthday popup if there are birthdays in the current month
//   void _showBirthdayPopupIfNeeded() {
//     final currentMonth = DateFormat('MMMM').format(DateTime.now());
//
//     final filteredBirthdays = birthdays.where((birthday) {
//       final birthdayMonth = birthday['birthday']!.split(' ')[0];
//       return birthdayMonth == currentMonth;
//     }).toList();
//
//     if (filteredBirthdays.isNotEmpty) {
//       _showBirthdayPopup(filteredBirthdays);
//     }
//   }

  // Show birthday popup if there are birthdays in the current month
  Future<void> _showBirthdayPopupIfNeeded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPopupShown = prefs.getBool('birthdayPopupShown') ?? false;

    if (isPopupShown) return;  // If popup was already shown, return early

    final currentMonth = DateFormat('MMMM').format(DateTime.now());

    final filteredBirthdays = birthdays.where((birthday) {
      final birthdayMonth = birthday['birthday']!.split(' ')[0];
      return birthdayMonth == currentMonth;
    }).toList();

    if (filteredBirthdays.isNotEmpty) {
      _showBirthdayPopup(filteredBirthdays);
      await prefs.setBool('birthdayPopupShown', true);  // Mark the popup as shown
    }
  }

// Show a popup dialog for birthdays
  void _showBirthdayPopup(List<Map<String, String>> birthdayList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final mediaQuery = MediaQuery.of(context);
        final screenWidth = mediaQuery.size.width;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 16,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.9, // Maximum width 90% of screen width
            ),
            padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
            child: IntrinsicHeight(
              // Adjusts height based on content
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Employee Birthdays 🎉',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05, // Responsive font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  // Use a ListView if there are many birthdays, otherwise Wrap in Column
                  birthdayList.isNotEmpty
                      ? Column(
                          children: birthdayList.map((birthday) {
                            return ListTile(
                              leading: CircleAvatar(
                                radius: screenWidth *
                                    0.08, // Responsive avatar size
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                              ),
                              title: Text(
                                birthday['name']!,
                                style: TextStyle(
                                    fontSize: screenWidth *
                                        0.045), // Responsive text size
                              ),
                              subtitle: Text(
                                'Birthday: ${birthday['birthday']}',
                                style: TextStyle(
                                    fontSize: screenWidth *
                                        0.035), // Responsive subtitle size
                              ),
                              onTap: () {
                                Navigator.of(context).pop(); // Close dialog
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Celebrations(),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        )
                      : Center(
                          child: Text('No birthdays found'),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // void _showBirthdayPopup(List<Map<String, String>> birthdayList) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(15),
  //         ),
  //         elevation: 16,
  //         child: Container(
  //           padding: EdgeInsets.all(16),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     'Employee Birthdays 🎉',
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   IconButton(
  //                     icon: Icon(Icons.close),
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 ],
  //               ),
  //               Divider(),
  //               ...birthdayList.map((birthday) {
  //                 return ListTile(
  //                   leading: CircleAvatar(
  //                     radius: 25,
  //                     backgroundImage: AssetImage('assets/images/profile.png'),
  //                   ),
  //                   title: Text(birthday['name']!),
  //                   subtitle: Text('Birthday: ${birthday['birthday']}'),
  //                   onTap: () {
  //                     // Close the popup first, then navigate to the Celebrations page
  //                     Navigator.of(context).pop(); // Close the popup
  //                     Navigator.of(context).push(
  //                       MaterialPageRoute(
  //                         builder: (context) => Celebrations(),
  //                       ),
  //                     );
  //                   },
  //                 );
  //               }).toList(),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ApiService.getProfile(widget.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data available'));
        }

        final userData = snapshot.data!;
        String name = userData['fullName'] ?? 'N/A';
        String designation = userData['designation'] ?? 'N/A';

        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/hrislogo2.png',
                  height: 40.0,
                ),
                SizedBox(width: 8.0),
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
                  Icons.notifications_active_outlined,
                  color: AppColors.background,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/coverupRequest',
                      arguments: widget.token);
                },
              ),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile',
                          arguments: widget.token);
                    },
                    child: Row(
                      children: [
                        FutureBuilder<Uint8List>(
                          future: ApiService.fetchProfilePicture(widget.token),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircleAvatar(
                                radius: 45,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return CircleAvatar(
                                radius: 45,
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                              );
                            } else if (snapshot.hasData) {
                              return CircleAvatar(
                                radius: 45,
                                backgroundImage: MemoryImage(snapshot.data!),
                              );
                            } else {
                              return CircleAvatar(
                                radius: 45,
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                              );
                            }
                          },
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(designation),
                            if (widget.lastLogin != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Last Login:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    _formatDateTime(widget.lastLogin!),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 2, height: 10),
                  SizedBox(height: 10),

                  // Categories
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 7 / 5,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      CategoryCard(
                        title: 'Attendance',
                        icon: Icons.calendar_month,
                        route: '/attendance',
                        token: widget.token,
                      ),
                      CategoryCard(
                        title: 'Leave',
                        icon: Icons.beach_access,
                        route: '/leave',
                        token: widget.token,
                      ),
                      CategoryCard(
                        title: 'Requests',
                        icon: Icons.list_alt,
                        route: '/requests',
                        token: widget.token,
                      ),
                      CategoryCard(
                        title: 'Profile',
                        icon: Icons.person_outline,
                        route: '/profile',
                        token: widget.token,
                      ),
                      CategoryCard(
                        title: 'Payslips',
                        icon: Icons.payment,
                        route: '/payslips',
                        token: widget.token,
                      ),
                      CategoryCard(
                        title: 'Approval',
                        icon: Icons.file_copy_outlined,
                        route: '/approval',
                        token: widget.token,
                      ),
                      CategoryCard(
                        title: 'My Team',
                        icon: Icons.group_add_outlined,
                        route: '/employee',
                        token: widget.token,
                      ),
                      CategoryCard(
                        title: 'Policy',
                        icon: Icons.task_outlined,
                        route: '/policies',
                        token: widget.token,
                      ),
                      CategoryCard(
                        title: 'News',
                        icon: Icons.newspaper,
                        route: '/taskScreen',
                        token: widget.token,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 2, height: 10),
                  SizedBox(height: 10),

                  // Recent Leave Request
                  Text(
                    'Recent Requests',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LeaveDetailsScreen(token: widget.token),
                        ),
                      );
                    },
                    child: RecentLeaveRequestCard(
                      leaveType: 'Leaves',
                      status: 'Processing',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PendingAttendanceScreen(token: widget.token),
                        ),
                      );
                    },
                    child: RecentLeaveRequestCard(
                      leaveType: 'Attendance',
                      status: 'Processing',
                    ),
                  ),
                  RecentLeaveRequestCard(
                    leaveType: 'Visa Letter',
                    status: 'Processing',
                  ),
                  // SizedBox(height: 20),
                  // Divider(thickness: 2, height: 10),

                  // Employee Birthdays
                  // The birthdays section will now show as a popup on screen entry
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDateTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formatter = DateFormat('MMMM dd, yyyy hh:mm a');
    return formatter.format(dateTime);
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final String token;

  const CategoryCard({
    required this.title,
    required this.icon,
    required this.route,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      width: 10,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              route,
              arguments: token,
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 25, color: AppColors.background),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentLeaveRequestCard extends StatelessWidget {
  final String leaveType;
  final String status;

  const RecentLeaveRequestCard({required this.leaveType, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(leaveType),
        trailing: Text(
          status,
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}

class EmployeeBirthdayCard extends StatelessWidget {
  final String name;
  final String birthday;
  final String imagePath;

  const EmployeeBirthdayCard({
    required this.name,
    required this.birthday,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime date = DateFormat('MMMM d').parse(birthday);
    final String day = DateFormat('d').format(date);
    final String month = DateFormat('MMM').format(date);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    month,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                    ),
                  ),
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
