import 'package:flutter/material.dart';
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
      drawer: CustomSidebar(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService.getProfile(token),
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

            return SingleChildScrollView(
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
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        email,
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
                            builder: (context) => PersonalInfo(token:token)),
                      );
                    },
                  ),
                  ProfileMenuWidget(
                    title: "Contact Information",
                    icon: Icons.contact_phone_outlined,
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactInfo(token: token)),
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
            );
          }
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
