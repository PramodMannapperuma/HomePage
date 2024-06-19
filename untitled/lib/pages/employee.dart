import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/styles/app_colors.dart';

class Employee {
  final String name;
  final String jobTitle;
  final String email;
  final int completion;
  final String initials;
  final String imageUrl;

  Employee({
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.completion,
    required this.initials,
    required this.imageUrl,
  });
}

class EmployeeScreen extends StatelessWidget {
  final List<Employee> employees = [
    Employee(
      name: 'Ekemini Sunday',
      jobTitle: 'UI / UX Designer',
      email: 'ekemini.sunday@example.com',
      completion: 75,
      initials: 'ES',
      imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
    ),
    Employee(
      name: 'Victor Elijah',
      jobTitle: 'Product Designer',
      email: 'victor.elijah@example.com',
      completion: 75,
      initials: 'VE',
      imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
    ),
    Employee(
      name: 'Ajayi O.',
      jobTitle: 'Product Designer',
      email: 'ajayi.o@example.com',
      completion: 75,
      initials: 'AO',
      imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
    ),
    Employee(
      name: 'Ekemini Sunday',
      jobTitle: 'Digital Strategist',
      email: 'ekemini.sunday2@example.com',
      completion: 75,
      initials: 'ES',
      imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
    ),
    Employee(
      name: 'Guy Hawkins',
      jobTitle: 'Digital Strategist',
      email: 'guy.hawkins@example.com',
      completion: 75,
      initials: 'GH',
      imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
    ),
    Employee(
      name: 'Annette Black',
      jobTitle: 'Data Analyst',
      email: 'annette.black@example.com',
      completion: 75,
      initials: 'AB',
      imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Team',  showActions: true,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/images/2.-electronic-evan (1).jpg'), // Supervisor's image URL
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  top: 0,
                  left: 0,
                  child: CircularProgressIndicator(
                    value: 1.0, // Assuming supervisor completion is 100%
                    backgroundColor: Colors.grey[300],
                      color: AppColors.background,
                    strokeWidth: 6,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('David Matthew',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Supervisor', style: TextStyle(fontSize: 16)),
            Text('gmailaddress@gmail.com', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: employees.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage(employees[index].imageUrl),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            top: 0,
                            left: 0,
                            child: CircularProgressIndicator(
                              value: employees[index].completion / 100,
                              backgroundColor: Colors.grey[300],
                              color: AppColors.background,
                              strokeWidth: 4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(employees[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(employees[index].jobTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12)),
                      // Text('${employees[index].completion}% completion',
                      //     style: TextStyle(fontSize: 12)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
