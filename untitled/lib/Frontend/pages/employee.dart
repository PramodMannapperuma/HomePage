import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

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
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      drawer: CustomSidebar(token: '',),
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
