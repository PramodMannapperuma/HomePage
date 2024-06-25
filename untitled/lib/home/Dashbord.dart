import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/APIs/Apis.dart';
import 'package:untitled/pages/attendance.dart';
import 'package:untitled/pages/employee.dart';
import 'package:untitled/pages/leave.dart';
import '../pages/task_screen.dart';
import '../styles/app_colors.dart';

class MainScreen extends StatefulWidget {
  final String token;
  const MainScreen({super.key, required this.token});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2; // Default to Dashboard screen
  // late Future<Map<String, dynamic>> futureProfile;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    print('Token in Min Screen : ${widget.token}');
    // futureProfile = ApiService.getProfile(widget.token);
    _widgetOptions = <Widget>[
      // Initialize here
      Attendance(),
      Leave(),
      DashboardScreen(token: widget.token), // Pass token to DashboardScreen
      TaskScreen(),
      EmployeeScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // static List<Widget> _widgetOptions = <Widget>[
  //   Attendance(),
  //   Leave(),
  //   DashboardScreen(token: widget.token),
  //   TaskScreen(),
  //   EmployeeScreen(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          // backgroundColor: Colors.blueAccent,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month, color: AppColors.background),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.beach_access, color: AppColors.background),
              label: 'Leave',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard, color: AppColors.background),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task, color: AppColors.background),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_add, color: AppColors.background),
              label: 'Tracking',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple,

          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final String token;

  const DashboardScreen({
    super.key,
    required this.token,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    print('Token in DashBordScreen: ${widget.token}');
    return FutureBuilder<Map<String, dynamic>>(
      future: ApiService.getProfile(widget.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data available'));
        } else {
          String name = snapshot.data!['fullName'] ?? 'N/A';
          String email = snapshot.data!['designation'] ?? 'N/A';
          String profileImageUrl = snapshot.data!['profileImageUrl'] ?? '';

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
                      Navigator.pushNamed(context, '/profile', arguments: widget.token);
                    },
                  ),
                ]),
            drawer: Container(
              width: 300.0, // Adjust the width as needed
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(77, 40, 128, 0.5),
                            Color.fromRGBO(77, 40, 128, 0.5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        // fit: StackFit.expand,
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/test-bg.png',
                              // width: 250.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.home_outlined,
                        color: Color.fromRGBO(77, 40, 128, 0.5),
                        size: 35,
                      ),
                      title: Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/home');
                      },
                    ),
                    // Divider(thickness: 0.2,),
                    ListTile(
                      leading: Icon(
                        Icons.event_available,
                        color: Color.fromRGBO(77, 40, 128, 0.5),
                        size: 35,
                      ),
                      title: Text('Attendance'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/attendance');
                      },
                    ),
                    // Divider(thickness: 0.2,),
                    ListTile(
                      leading: Icon(
                        Icons.airplanemode_on_sharp,
                        color: Color.fromRGBO(77, 40, 128, 0.5),
                        size: 35,
                      ),
                      title: Text('Leaves'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/leave');
                      },
                    ),
                    // Divider(thickness: 0.2,),
                    ListTile(
                      leading: Icon(
                        Icons.list_alt,
                        color: Color.fromRGBO(77, 40, 128, 0.5),
                        size: 35,
                      ),
                      title: Text('Requests'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/requests');
                      },
                    ),
                    // Divider(thickness: 0.2,),
                    ListTile(
                      leading: Icon(
                        Icons.person_pin_outlined,
                        color: Color.fromRGBO(77, 40, 128, 0.5),
                        size: 35,
                      ),
                      title: Text('Profile'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    // Divider(thickness: 0.2,),
                    ListTile(
                      leading: Icon(
                        Icons.receipt_long_outlined,
                        color: Color.fromRGBO(77, 40, 128, 0.5),
                        size: 35,
                      ),
                      title: Text('News'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/news_screen');
                      },
                    ),
                    // Divider(thickness: 0.2,),
                    ListTile(
                      leading: Icon(
                        Icons.receipt_long_outlined,
                        color: Color.fromRGBO(77, 40, 128, 0.5),
                        size: 35,
                      ),
                      title: Text('PaySlips'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/payslips');
                      },
                    ),
                    // Divider(thickness: 0.2,),
                    ListTile(
                      leading: Icon(
                        Icons.assignment_turned_in_outlined,
                        color: Color.fromRGBO(77, 40, 128, 0.5),
                        size: 35,
                      ),
                      title: Text('Approval Tasks'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/taskScreen');
                      },
                    ),

                    ListTile(
                      leading: Icon(
                        Icons.group_add_outlined,
                        color: Color.fromRGBO(77, 40, 128, 0.5),
                        size: 35,
                      ),
                      title: Text('My Team'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/employee');
                      },
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                        Navigator.pushNamed(context, '/login');
                      },
                      contentPadding: EdgeInsets.zero, // Remove default padding
                      title: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 30),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.red),
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.logout, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Log Out',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // dense: true,
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('Your Token is: $token'),
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
                              '$name',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('$email'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 2,
                      height: 10,
                    ),
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
                          icon: Icons.calendar_today,
                          route: '/attendance',
                          token: widget.token,
                        ),
                        CategoryCard(
                          title: 'Task',
                          icon: Icons.task_outlined,
                          route: '/taskScreen',
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
                          icon: Icons.request_page_outlined,
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
                          title: 'News',
                          icon: Icons.newspaper,
                          route: '/news_screen',
                          token: widget.token,
                        ),
                        CategoryCard(
                          title: 'Payslips',
                          icon: Icons.payment,
                          route: '/payslips',
                          token: widget.token,
                        ),
                        CategoryCard(
                          title: 'Approval Task',
                          icon: Icons.approval,
                          route: '/taskScreen',
                          token: widget.token,
                        ),
                        CategoryCard(
                          title: 'My Team',
                          icon: Icons.group_add_outlined,
                          route: '/employee',
                          token: widget.token,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 2,
                      height: 10,
                    ),
                    SizedBox(height: 10),

                    // Today's Task
                    Text(
                      'Today\'s Task',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TaskCard(
                            title: 'Lorem Ipsum Dolor',
                            time: '9:00 AM',
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TaskCard(
                            title: 'Lorem Ipsum Dolor',
                            time: '9:00 AM',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 2,
                      height: 10,
                    ),
                    SizedBox(height: 10),

                    // Recent Leave Request
                    Text(
                      'Recent Leave Request',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    RecentLeaveRequestCard(
                      leaveType: '3 Days Leave',
                      status: 'Processing',
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final String token;

  const CategoryCard(
      {required this.title,
      required this.icon,
      required this.route,
      required this.token});

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

class TaskCard extends StatelessWidget {
  final String title;
  final String time;

  const TaskCard({required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(time, style: TextStyle(color: Colors.grey)),
                  TextButton(
                    onPressed: () {},
                    child: Text('View'),
                  ),
                ],
              ),
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
