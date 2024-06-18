import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/profile/career_profile.dart';
import 'package:untitled/profile/contact_info.dart';
import '../auth/login.dart';
import '../profile/Info.dart';
import '../profile/personal_info.dart';
import 'package:untitled/app_colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hardcoded user data
    final Map<String, dynamic> userData = {
      'firstName': 'Demon',
      'lastName': 'Silva',
      'userId': '123456789012345',
      'gender': 'Male',
      'email': 'johndoe@example.com',
    };

    return Scaffold(
      appBar: customAppBar(
        title: 'Profile',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true, // Show back button instead of hamburger icon
      ),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');
                },
              ),
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
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: const AssetImage(
                      "assets/images/2.-electronic-evan (1).jpg"),
                ),
                // Positioned(
                //   bottom: 2,
                //   right: 4,
                //   child: Container(
                //     width: 28,
                //     height: 28,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(100),
                //       color: Colors.blueGrey.withOpacity(0.8),
                //     ),
                //     child: GestureDetector(
                //       onTap: () {
                //         showModalBottomSheet(
                //           context: context,
                //           builder: ((build) => bottomSheet()),
                //         );
                //       },
                //       child: const Icon(
                //         Icons.edit,
                //         color: Colors.black54,
                //         size: 20,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),

            const SizedBox(height: 10),
            Column(
              children: [
                Text(
                  "${userData['firstName']} ${userData['lastName']}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  userData['email'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1),
            ProfileMenuWidget(
              title: "Personal Information",
              icon: Icons.person_2_outlined,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalInfo()),
                );
              },
            ),
            ProfileMenuWidget(
              title: "Contact Information",
              icon: Icons.contact_phone_outlined,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactInfo()),
                );
              },
            ),
            ProfileMenuWidget(
              title: "Career Profile",
              icon: Icons.work_history_outlined,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CareerProfile()),
                );
              },
            ),
            const Divider(thickness: 1),
            ProfileMenuWidget(
              title: "Info",
              icon: Icons.info,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FAQAndPricingScreen()),
                );
              },
            ),
            ProfileMenuWidget(
              title: "Log Out",
              icon: Icons.logout,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

// Widget bottomSheet() {
//   return Container(
//     height: 100.0,
//     width: double.infinity,
//     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//     child: Column(
//       children: <Widget>[
//         const Text(
//           "Choose Profile Photo",
//           style: TextStyle(fontSize: 20.0),
//         ),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextButton.icon(
//               icon: const Icon(Icons.camera),
//               onPressed: () {},
//               label: const Text("Camera"),
//             ),
//             TextButton.icon(
//               icon: const Icon(Icons.image),
//               onPressed: () {},
//               label: const Text("Gallery"),
//             ),
//           ],
//         )
//       ],
//     ),
//   );
// }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.blueGrey.withOpacity(0.1),
        ),
        child: Icon(
          icon, color: AppColors.background,
        ),
      ),
      title: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: textColor, fontSize: 17.0)),
      trailing: endIcon
          ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black.withOpacity(0.1),
        ),
        child: const Icon(
          Icons.keyboard_arrow_right,
          color: Color.fromRGBO(77, 40, 128, 0.5),
        ),
      )
          : null,
    );
  }
}
