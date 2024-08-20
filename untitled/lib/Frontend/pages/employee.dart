// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../app_bar.dart';
// import '../styles/app_colors.dart';
// import '../styles/sidebar.dart';

// class Employee {
//   final String name;
//   final String jobTitle;
//   final String email;
//   final int completion;
//   final String initials;
//   final String imageUrl;

//   Employee({
//     required this.name,
//     required this.jobTitle,
//     required this.email,
//     required this.completion,
//     required this.initials,
//     required this.imageUrl,
//   });
// }

// class EmployeeScreen extends StatelessWidget {
//   final List<Employee> employees = [
//     Employee(
//       name: 'Ekemini Sunday',
//       jobTitle: 'UI / UX Designer',
//       email: 'ekemini.sunday@example.com',
//       completion: 75,
//       initials: 'ES',
//       imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
//     ),
//     Employee(
//       name: 'Victor Elijah',
//       jobTitle: 'Product Designer',
//       email: 'victor.elijah@example.com',
//       completion: 75,
//       initials: 'VE',
//       imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
//     ),
//     Employee(
//       name: 'Ajayi O.',
//       jobTitle: 'Product Designer',
//       email: 'ajayi.o@example.com',
//       completion: 75,
//       initials: 'AO',
//       imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
//     ),
//     Employee(
//       name: 'Ekemini Sunday',
//       jobTitle: 'Digital Strategist',
//       email: 'ekemini.sunday2@example.com',
//       completion: 75,
//       initials: 'ES',
//       imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
//     ),
//     Employee(
//       name: 'Guy Hawkins',
//       jobTitle: 'Digital Strategist',
//       email: 'guy.hawkins@example.com',
//       completion: 75,
//       initials: 'GH',
//       imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
//     ),
//     Employee(
//       name: 'Annette Black',
//       jobTitle: 'Data Analyst',
//       email: 'annette.black@example.com',
//       completion: 75,
//       initials: 'AB',
//       imageUrl: 'assets/images/2.-electronic-evan (1).jpg',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // backgroundColor: const Color(0xff4d2880),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/hrislogo2.png',
//               height: 40.0,
//             ),
//             SizedBox(
//               width: 8.0,
//             ),
//           ],
//         ),
//         centerTitle: true,
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.dark,
//         ),
//         leading: Builder(
//           builder: (BuildContext context) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.menu_outlined,
//                   color: AppColors.background,
//                 ),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//               ),
//             );
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.person,
//               color: AppColors.background,
//             ),
//             onPressed: () {
//               Navigator.pushNamed(context, '/profile');
//             },
//           ),
//         ],
//       ),
//       drawer: CustomSidebar(token: '',),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage(
//                       'assets/images/2.-electronic-evan (1).jpg'), // Supervisor's image URL
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   top: 0,
//                   left: 0,
//                   child: CircularProgressIndicator(
//                     value: 1.0, // Assuming supervisor completion is 100%
//                     backgroundColor: Colors.grey[300],
//                       color: AppColors.background,
//                     strokeWidth: 6,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Text('David Matthew',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             Text('Supervisor', style: TextStyle(fontSize: 16)),
//             Text('gmailaddress@gmail.com', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 20),
//             Expanded(
//               child: GridView.builder(
//                 itemCount: employees.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 10,
//                   mainAxisSpacing: 10,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundImage:
//                                 AssetImage(employees[index].imageUrl),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             top: 0,
//                             left: 0,
//                             child: CircularProgressIndicator(
//                               value: employees[index].completion / 100,
//                               backgroundColor: Colors.grey[300],
//                               color: AppColors.background,
//                               strokeWidth: 4,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Text(employees[index].name,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontSize: 14, fontWeight: FontWeight.bold)),
//                       Text(employees[index].jobTitle,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 12)),
//                       // Text('${employees[index].completion}% completion',
//                       //     style: TextStyle(fontSize: 12)),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import 'package:untitled/Backend/models/team_member_model.dart';
import 'dart:typed_data';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';

class EmployeeScreen extends StatefulWidget {
  final String token;

  const EmployeeScreen({Key? key, required this.token}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  late Future<List<TeamMember>> _teamMembersFuture;
  TeamMember? _supervisor;
  Uint8List? _profilePicture;

  @override
  void initState() {
    super.initState();
    _teamMembersFuture = _fetchTeamMembers();
  }

  Future<List<TeamMember>> _fetchTeamMembers() async {
    List<TeamMember> teamMembers = await ApiService.fetchTeamMembers(widget.token);

    // Assuming the supervisor has a specific ID or flag in your data.
    _supervisor = teamMembers.firstWhere(
      (member) => member.supervisor == 0, // Assuming 0 indicates the supervisor
      orElse: () => teamMembers.first,
    );

    teamMembers.remove(_supervisor);

    // Fetch the profile picture for the supervisor
    _profilePicture = await _fetchProfilePicture();

    return teamMembers;
  }

  Future<Uint8List?> _fetchProfilePicture() async {
    try {
      return await ApiService.fetchProfilePicture(widget.token);
    } catch (e) {
      // If fetching fails, return null so that the default image will be used
      print('Failed to load profile picture: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<TeamMember>>(
          future: _teamMembersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No team members found'));
            } else {
              final teamMembers = snapshot.data!;
              return Column(
                children: [
                  // Supervisor in the first row
                  if (_supervisor != null)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildMemberCard(_supervisor!, _profilePicture, isSupervisor: true),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  // Employees Grid Section with 2 members per row
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: MediaQuery.of(context).size.width / 
                          (MediaQuery.of(context).size.height / 2),
                      ),
                      itemCount: teamMembers.length,
                      itemBuilder: (context, index) {
                        final member = teamMembers[index];
                        return _buildMemberCard(member, null);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMemberCard(TeamMember member, Uint8List? profilePicture, {bool isSupervisor = false}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: profilePicture != null
                  ? MemoryImage(profilePicture) as ImageProvider<Object> // Corrected cast to ImageProvider<Object>
                  : AssetImage('assets/images/profile.png'), // Default image
            ),
            Positioned(
              bottom: 0,
              right: 0,
              top: 0,
              left: 0,
              child: CircularProgressIndicator(
                value: isSupervisor ? 1.0 : 0.75, // Adjust value if available
                backgroundColor: Colors.grey[300],
                color: AppColors.background,
                strokeWidth: 4,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(member.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(member.designation,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14)),
      ],
    );
  }
}
