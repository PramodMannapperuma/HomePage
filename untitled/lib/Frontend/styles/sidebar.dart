// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CustomSidebar extends StatelessWidget {
//   final String token;
//   const CustomSidebar({Key? key, required this.token}) : super(key: key);

//   Future<void> _logout(BuildContext context) async {
//     // Clear session-related data from SharedPreferences
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('lastLogin');
//     await prefs.remove('cookies');

//     // Navigate to the login screen
//     Navigator.pop(context); // Close the sidebar
//     Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300.0,
//       child: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromRGBO(77, 40, 128, 0.5),
//                     Color.fromRGBO(77, 40, 128, 0.5),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: Image.asset(
//                       'assets/images/test-bg.png',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.home_outlined,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text(
//                 'Home',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/dashboard', arguments: token);
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.calendar_month,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text('Attendance'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/attendance', arguments: token);
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.beach_access,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text('Leaves'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/leave', arguments: token);
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.list_alt,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text('Requests'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/requests');
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.person_outline,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/profile', arguments: token);
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.payment,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text('PaySlips'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/payslips');
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.approval,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text('Approval Tasks'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/taskScreen');
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.group_add_outlined,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text('My Team'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/employee');
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.newspaper,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text('Policy'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/policies');
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.newspaper,
//                 color: Color.fromRGBO(77, 40, 128, 0.5),
//                 size: 35,
//               ),
//               title: Text('News'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushNamed(context, '/news_screen');
//               },
//             ),
//             Divider(
//               thickness: 0.5,
//             ),
//             ListTile(
//               onTap: () => _logout(context),
//               contentPadding: EdgeInsets.zero,
//               title: Center(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//                   decoration: BoxDecoration(
//                     border: Border.all(width: 2, color: Colors.red),
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.logout, color: Colors.red),
//                       SizedBox(width: 8),
//                       Text(
//                         'Log Out',
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomSidebar extends StatelessWidget {
  final String token;
  const CustomSidebar({Key? key, required this.token}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    // Clear session-related data from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastLogin');
    await prefs.remove('cookies');

    // Navigate to the login screen
    Navigator.pop(context); // Close the sidebar
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
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
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/test-bg.png',
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  LogoutButton(onLogout: () => _logout(context)),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dashboard', arguments: token);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_month,
                color: Color.fromRGBO(77, 40, 128, 0.5),
                size: 35,
              ),
              title: Text('Attendance'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/attendance', arguments: token);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.beach_access,
                color: Color.fromRGBO(77, 40, 128, 0.5),
                size: 35,
              ),
              title: Text('Leaves'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/leave', arguments: token);
              },
            ),
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
            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: Color.fromRGBO(77, 40, 128, 0.5),
                size: 35,
              ),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile', arguments: token);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.payment,
                color: Color.fromRGBO(77, 40, 128, 0.5),
                size: 35,
              ),
              title: Text('PaySlips'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/payslips');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.approval,
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
            ListTile(
              leading: Icon(
                Icons.task_outlined,
                color: Color.fromRGBO(77, 40, 128, 0.5),
                size: 35,
              ),
              title: Text('Policy'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/policies');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.newspaper,
                color: Color.fromRGBO(77, 40, 128, 0.5),
                size: 35,
              ),
              title: Text('News'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/news_screen');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.approval,
                color: Color.fromRGBO(77, 40, 128, 0.5),
                size: 35,
              ),
              title: Text('Approval'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/approval');
              },
            ),
            Divider(
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutButton extends StatefulWidget {
  final VoidCallback onLogout;
  const LogoutButton({Key? key, required this.onLogout}) : super(key: key);

  @override
  _LogoutButtonState createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(2.0, 0.0), // Adjust the end value to slide further out of view
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward().then((_) {
      widget.onLogout();
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.logout, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
