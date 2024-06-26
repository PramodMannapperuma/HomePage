import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'package:untitled/pages/article_detail.dart';
import 'package:untitled/styles/app_colors.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  final List<Map<String, String>> eventArticles = [
    {
      'title': 'Music Concert',
      'description': 'Join us for a night of live music on June 15.',
      'image': 'assets/images/concert.jpg',
    },
    {
      'title': 'Art Exhibition',
      'description': 'Explore the new art exhibition starting on June 20.',
      'image': 'assets/images/exhibition.jpg',
    },
    {
      'title': 'Tech Conference',
      'description': 'Attend the tech conference on June 25.',
      'image': 'assets/images/conference.jpeg',
    },
  ];

  List<List<String>> commentsList =
      List.generate(3, (_) => []); // Initialize empty comment lists

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Events',
          showActions: true,
          showLeading: true,
          context: context,
          showBackButton: true),
      drawer: Container(
        width: 300.0, // Adjust the width as needed
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
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
                leading: const Icon(
                  Icons.home_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.event_available,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: const Text('Attendance'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/attendance');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.airplanemode_on_sharp,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: const Text('Leaves'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/leave');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.list_alt,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: const Text('Requests'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/requests');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_pin_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.receipt_long_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: const Text('News'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/news_screen');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.receipt_long_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: const Text('PaySlips'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/payslips');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.assignment_turned_in_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: const Text('Approval Tasks'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/taskScreen');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.group_add_outlined,
                  color: Color.fromRGBO(77, 40, 128, 0.5),
                  size: 35,
                ),
                title: const Text('My Team'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/employee');
                },
              ),
              const Divider(
                thickness: 0.5,
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
                contentPadding: EdgeInsets.zero, // Remove default padding
                title: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 30),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.red),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
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
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: eventArticles.length,
        itemBuilder: (context, index) {
          final article = eventArticles[index];
          return Card(
            elevation: 4.0, // Adds a shadow to each card
            margin: const EdgeInsets.all(8.0), // Adds spacing around each card
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors
                    .background, // Custom color for the icon background
                backgroundImage:
                    AssetImage(article['image']!), // Use the article image
              ),
              title: Text(
                article['title']!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold), // Bold text for the title
              ),
              subtitle: Text(article['description']!),
              trailing: IconButton(
                icon: const Icon(Icons.message),
                color:
                    AppColors.background, // Custom color for the message icon
                onPressed: () {
                  // Implement messaging functionality if needed
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetail(
                      article: article,
                      comments: commentsList[
                          index], // Pass comments list for the selected article
                      onCommentAdded: (comment) {
                        setState(() {
                          commentsList[index]
                              .add(comment); // Add comment to the comments list
                        });
                      },
                      initialComments: [],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

//---------------------Code with the end point to get the events----------------------

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:untitled/app_bar.dart';
// import 'package:untitled/pages/article_detail.dart';
// import 'package:untitled/styles/app_colors.dart';

// class Event extends StatefulWidget {
//   const Event({Key? key}) : super(key: key);

//   @override
//   State<Event> createState() => _EventState();
// }

// class _EventState extends State<Event> {
//   List<Map<String, dynamic>> eventArticles = [];
//   List<List<String>> commentsList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchEvents();
//   }

//   Future<void> fetchEvents() async {
//     final response = await http.get(Uri.parse('http://localhost:8080/events'));
//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       setState(() {
//         eventArticles = List<Map<String, dynamic>>.from(data.map((item) => {
//           'title': item['title'],
//           'description': item['description'],
//           'image': item['image'],
//         }));
//         commentsList = List.generate(eventArticles.length, (_) => []);
//       });
//     } else {
//       throw Exception('Failed to load events');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(
//           title: 'Events',
//           showActions: true,
//           showLeading: true,
//           context: context,
//           showBackButton: true),
//       drawer: Container(
//         width: 300.0,
//         child: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromRGBO(77, 40, 128, 0.5),
//                       Color.fromRGBO(77, 40, 128, 0.5),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     Positioned.fill(
//                       child: Image.asset(
//                         'assets/images/test-bg.png',
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.home_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: const Text(
//                   'Home',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/home');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.event_available,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: const Text('Attendance'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/attendance');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.airplanemode_on_sharp,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: const Text('Leaves'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/leave');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.list_alt,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: const Text('Requests'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/requests');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.person_pin_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: const Text('Profile'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/profile');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.receipt_long_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: const Text('News'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/news_screen');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.receipt_long_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: const Text('PaySlips'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/payslips');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.assignment_turned_in_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: const Text('Approval Tasks'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/taskScreen');
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.group_add_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: const Text('My Team'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/employee');
//                 },
//               ),
//               const Divider(
//                 thickness: 0.5,
//               ),
//               ListTile(
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/login');
//                 },
//                 contentPadding: EdgeInsets.zero,
//                 title: Center(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 12, horizontal: 30),
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.red),
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.logout, color: Colors.red),
//                         SizedBox(width: 8),
//                         Text(
//                           'Log Out',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: eventArticles.length,
//         itemBuilder: (context, index) {
//           final article = eventArticles[index];
//           return Card(
//             elevation: 4.0,
//             margin: const EdgeInsets.all(8.0),
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: AppColors.background,
//                 backgroundImage: AssetImage(article['image']!),
//               ),
//               title: Text(
//                 article['title']!,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(article['description']!),
//               trailing: IconButton(
//                 icon: const Icon(Icons.message),
//                 color: AppColors.background,
//                 onPressed: () {
//                   // Implement messaging functionality if needed
//                 },
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ArticleDetail(
//                       article: article,
//                       comments: commentsList[index],
//                       onCommentAdded: (comment) {
//                         setState(() {
//                           commentsList[index].add(comment);
//                         });
//                       }, initialComments: [],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
