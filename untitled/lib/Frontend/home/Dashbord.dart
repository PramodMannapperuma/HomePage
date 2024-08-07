import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Frontend/geolocation.dart';
import '../../Backend/APIs/Apis.dart';
import '../../../Frontend/pages/attendance.dart';
import '../../../Frontend/pages/leave.dart';
import '../pages/employee.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';
import 'Dashboard1.dart';
import 'dart:typed_data';

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
      EmployeeScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
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
                  label: 'Tracking',
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
        '© Powerd by Accelution',
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
  @override
  Widget build(BuildContext context) {
    print('Token in DashboardScreen: ${widget.token}');
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
                  Navigator.pushNamed(context, '/news_screen',
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
                      CategoryCard(
                        title: 'Policy',
                        icon: Icons.task_outlined,
                        route: '/policies',
                        token: widget.token,
                      ),
                      CategoryCard(
                        title: 'News',
                        icon: Icons.newspaper,
                        route: '/news_screen',
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
                  RecentLeaveRequestCard(
                    leaveType: '3 Days Leave',
                    status: 'Processing',
                  ),
                  RecentLeaveRequestCard(
                    leaveType: 'Attendance',
                    status: 'Processing',
                  ),
                  RecentLeaveRequestCard(
                    leaveType: 'Visa Letter',
                    status: 'Processing',
                  ),
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
