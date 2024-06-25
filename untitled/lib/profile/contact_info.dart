import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/profile/profile_detail_column.dart';
import 'package:untitled/profile/profile_detail_row.dart';

import '../APIs/Apis.dart';

class ContactInfo extends StatefulWidget {
  final String token;

  const ContactInfo({super.key, required this.token});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  // final Map<String, dynamic> contactData = {
  //   'firstName': 'Demon',
  //   'lastName': 'Silva',
  //   'DL NO': 'N/A',
  //   'PP NO': 'N/A',
  //   'Mobile1': '071 123 1232',
  //   'Mobile2': '0776767567',
  //   'Office Mobile': '0112323456',
  //   'Office Mobile 2': '0113434123',
  //   'Resident Tel': '0114545456',
  //   'Resident Tel2': '0114545765',
  //   'Office Tel': '0116767678',
  //   'Office Extension': 'N/A',
  //   'Personal Email': "demon@gmail.com",
  //   'Office Email': 'silva@gmail.com',
  //   'Permanent Address': 'No.123/4, Nawala Rd, Rajagiriya.',
  //   'Resident Address': 'No 23/8, Kohuwala, Dehiwala.',
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Contact Information',
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

          final contactData = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: AssetImage(
                            "assets/images/2.-electronic-evan (1).jpg"),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        '${contactData['firstName']} ${contactData['surname']}'
                            .trim(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                        title: 'DL Number', value: '${contactData['dlNo']}'),
                    ProfileDetailRow(
                        title: 'PP Number', value: '${contactData['ppNo']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                      title: 'Mobile No',
                      value: '${contactData['mobile1']}',
                    ),
                    ProfileDetailRow(
                        title: 'Office Mobile',
                        value: '${contactData['officeMobile']}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ProfileDetailRow(
                      title: 'Resident Tel',
                      value: '${contactData['residentialTel']}',
                    ),
                    ProfileDetailRow(
                        title: 'Office Tel',
                        value: '${contactData['officeTel']}'),
                  ],
                ),
                const SizedBox(height: 20),
                ProfileDetailColumn(
                    title: 'Office Email',
                    value: '${contactData['officeEmail']}'),
                ProfileDetailColumn(
                    title: 'Personal Email',
                    value: '${contactData['personalEmail']}'),
                ProfileDetailColumn(
                    title: 'Office Mobile 2',
                    value: '${contactData['mobile2']}'),
                ProfileDetailColumn(
                    title: 'Resident Tel 2',
                    value: '${contactData['otherTel']}'),
                ProfileDetailColumn(
                    title: 'Permanent Address',
                    value: '${contactData['permanentAddress']}'),
                ProfileDetailColumn(
                    title: 'Resident Address',
                    value: '${contactData['residentialAddress']}'),
                ProfileDetailColumn(
                    title: 'Office Ext',
                    value: '${contactData['officeExt']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
