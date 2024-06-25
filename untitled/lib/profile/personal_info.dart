import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/profile/profile_detail_column.dart';
import 'package:untitled/profile/profile_detail_row.dart';

import '../APIs/Apis.dart';

class PersonalInfo extends StatefulWidget {
  late String token;

  PersonalInfo({super.key, required this.token});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  // Hardcoded user data
  // final Map<String, dynamic> userData = {
  //   'firstName': 'Demon',
  //   'lastName': 'Silva',
  //   'userId': '123456789012345',
  //   'gender': 'Male',
  //   'Disability Status': 'N/A',
  //   'Blood Group': 'O+',
  //   'email': 'silva@example.com',
  //   'Nationality': 'Sri Lankan',
  //   'Ethnicity': 'Sinhalese',
  //   'Religion': 'Buddhist',
  //   'Address': '12/3, Nugegoda, Sri Lanka.',
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Personal Information',
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: ApiService.getProfile(widget.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final userData = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: AssetImage("assets/images/2.-electronic-evan (1).jpg"),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        '${userData['firstName']} ${userData['surname']}'.trim(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  ],
                ),
                Divider(thickness: 1),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(title: 'First Name', value: '${userData['firstName']}'),
                    ProfileDetailRow(title: 'Last Name', value: '${userData['surname']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(title: 'UserId', value: '${userData['code']}'),
                    ProfileDetailRow(title: 'Sex', value: '${userData['gender']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(title: 'Disability Status', value: '${userData['disabilityStatus']}'),
                    ProfileDetailRow(title: 'Blood Group', value: '${userData['bloodGroup']}'),
                  ],
                ),
                const SizedBox(height: 20),
                ProfileDetailColumn(title: 'Email', value: '${userData['email']}'),
                ProfileDetailColumn(title: 'Nationality', value: '${userData['nationality']}'),
                ProfileDetailColumn(title: 'Ethnicity', value: '${userData['ethnicity']}'),
                ProfileDetailColumn(title: 'Religion', value: '${userData['religion']}'),
                ProfileDetailColumn(title: 'Address', value: '${userData['permanentAddress']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}


