import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Backend/APIs/Apis.dart';
import '../app_bar.dart';
import '../auth/login.dart';
import '../profile/Info.dart';
import '../profile/career_profile.dart';
import '../profile/contact_info.dart';
import '../profile/personal_info.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String token;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      token = ModalRoute.of(context)!.settings.arguments as String;
      setState(() {});
    });
  }

  Future<void> _logout(BuildContext context) async {
    // Clear session-related data from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastLogin');
    await prefs.remove('cookies');

    // Navigate to the login screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final String token = ModalRoute.of(context)!.settings.arguments as String;
    print('Token in profile is: $token');
    return Scaffold(
      appBar: customAppBar(
        title: 'Profile',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: true, // Show back button instead of hamburger icon
      ),
      drawer: CustomSidebar(token: token),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService.getProfile(token),
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
          String image = userData['image'] ?? '';

          // Construct the full URL for the profile image if it's not null
          // String fullProfileImageUrl =
          //     'http://hris.accelution.lk/api/profile/$image';

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder<Uint8List>(
                        future: ApiService.fetchProfilePicture(token),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return CircleAvatar(
                                radius: 40,
                                child: Center(
                                    child: Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 8),)));
                          } else if (snapshot.hasData) {
                            return CircleAvatar(
                                radius: 40,
                                backgroundImage: MemoryImage(snapshot.data!));
                          } else {
                            return Text('No data');
                          }
                        },
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4d2880),
                              ),
                            ),
                            SizedBox(height: 0.2),
                            Text(
                              designation,
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                                height:
                                    10), // Gap between designation and email
                            Text(
                              'Supervisor: ${userData['supervisor']}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[700],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone,
                                    size: 16, color: Colors.grey[700]),
                                SizedBox(width: 5),
                                Text(
                                  '${userData['officeTel']}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'EPF No: ${userData['epf']}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Divider(thickness: 1),
                ProfileMenuWidget(
                  title: "Personal Information",
                  icon: Icons.person_2_outlined,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalInfo(token: token)),
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
                          builder: (context) => ContactInfo(token: token)),
                    );
                  },
                ),
                ProfileMenuWidget(
                  title: "Career Profile",
                  icon: Icons.work_history_outlined,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CareerProfile(token: token)),
                    );
                  },
                ),
                Divider(thickness: 1),
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
                  onPress: () => _logout(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
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
          icon,
          color: AppColors.background,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: textColor,
        ),
      ),
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
