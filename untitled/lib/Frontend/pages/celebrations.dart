import 'package:flutter/material.dart';
import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';
import 'article_detail.dart';

class Celebrations extends StatefulWidget {
  const Celebrations({Key? key}) : super(key: key);

  @override
  State<Celebrations> createState() => _CelebrationsState();
}

class _CelebrationsState extends State<Celebrations> {
  final List<Map<String, String>> celebrationArticles = [
    {
      'title': 'Annual Office Party',
      'description': 'Join us for the annual office party on July 15.',
      'image': 'assets/images/officeparty.png',
    },
    {
      'title': 'Employee of the Month',
      'description': 'Congratulations to Jane Doe for being the Employee of the Month!',
      'image': 'assets/images/employmonth.jpg',
    },
    {
      'title': 'Team Building Workshop',
      'description': 'Participate in our team building workshop on August 10.',
      'image': 'assets/images/TEAMWORK.jpg',
    },
  ];

  List<List<String>> commentsList =
      List.generate(3, (_) => []); // Initialize empty comment lists

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Office Celebrations',
          showActions: true,
          showLeading: true,
          context: context,
          showBackButton: true),
      drawer: CustomSidebar(),
      body: ListView.builder(
        itemCount: celebrationArticles.length,
        itemBuilder: (context, index) {
          final article = celebrationArticles[index];
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


// import 'package:flutter/material.dart';
// import '../app_bar.dart';
// import '../styles/app_colors.dart';
// import '../styles/sidebar.dart';
// import 'article_detail.dart';

// class Celebrations extends StatefulWidget {
//   const Celebrations({Key? key}) : super(key: key);

//   @override
//   State<Celebrations> createState() => _CelebrationsState();
// }

// class _CelebrationsState extends State<Celebrations> {
//   final List<Map<String, String>> celebrationArticles = [
//     {
//       'title': 'Today is Monday!',
//       'description': 'Date is June 10.',
//       'image': 'assets/images/Monday.jpg',
//     },
//     {
//       'title': 'Happy Birthday',
//       'description': 'Today is your birthday.',
//       'image': 'assets/images/Birthday.jpeg',
//     },
//     {
//       'title': 'Tomorrow is Tuesday!',
//       'description': 'Date is June 11.',
//       'image': 'assets/images/Tuesday.jpg',
//     },
//   ];

//   List<List<String>> commentsList =
//       List.generate(3, (_) => []); // Initialize empty comment lists

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(
//           title: 'Celebrations',
//           showActions: true,
//           showLeading: true,
//           context: context,
//           showBackButton: true),
//       drawer: CustomSidebar(),
//       body: ListView.builder(
//         itemCount: celebrationArticles.length,
//         itemBuilder: (context, index) {
//           final article = celebrationArticles[index];
//           return Card(
//             elevation: 4.0, // Adds a shadow to each card
//             margin: const EdgeInsets.all(8.0), // Adds spacing around each card
//             child: ListTile(
//               leading: CircleAvatar(
//                 backgroundColor: AppColors
//                     .background, // Custom color for the icon background
//                 backgroundImage:
//                     AssetImage(article['image']!), // Use the article image
//               ),
//               title: Text(
//                 article['title']!,
//                 style: const TextStyle(
//                     fontWeight: FontWeight.bold), // Bold text for the title
//               ),
//               subtitle: Text(article['description']!),
//               trailing: IconButton(
//                 icon: const Icon(Icons.message),
//                 color:
//                     AppColors.background, // Custom color for the message icon
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
//                       comments: commentsList[
//                           index], // Pass comments list for the selected article
//                       onCommentAdded: (comment) {
//                         setState(() {
//                           commentsList[index]
//                               .add(comment); // Add comment to the comments list
//                         });
//                       },
//                       initialComments: [],
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




//---------------------Code with the end point to get the celebrations----------------------

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:untitled/app_bar.dart';
// import 'package:untitled/styles/app_colors.dart';
//
// class Celebrations extends StatefulWidget {
//   const Celebrations({Key? key}) : super(key: key);
//
//   @override
//   _CelebrationsState createState() => _CelebrationsState();
// }
//
// class _CelebrationsState extends State<Celebrations> {
//   List<dynamic> celebrations = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchCelebrations();
//   }
//
//   Future<void> fetchCelebrations() async {
//     final response = await http.get(Uri.parse('http://your-backend-url/api/celebrations'));
//
//     if (response.statusCode == 200) {
//       setState(() {
//         celebrations = json.decode(response.body);
//       });
//     } else {
//       // Handle error
//       print('Failed to load celebrations');
//     }
//   }
//
//   IconData getIcon(String iconName) {
//     switch (iconName) {
//       case 'cake':
//         return Icons.cake;
//       case 'favorite':
//         return Icons.favorite;
//       case 'airline_seat_individual_suite':
//         return Icons.airline_seat_individual_suite;
//       default:
//         return Icons.event; // Default icon
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(
//         title: 'Celebrations',
//         showActions: true,
//         showLeading: true,
//         context: context,
//         showBackButton: true, // Show back button instead of hamburger icon
//       ),
//       drawer: Container(
//         width: 300.0, // Adjust the width as needed
//         child: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               DrawerHeader(
//                 decoration: BoxDecoration(
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
//                   // fit: StackFit.expand,
//                   children: [
//                     Positioned.fill(
//                       child: Image.asset(
//                         'assets/images/test-bg.png',
//                         // width: 250.0,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.home_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: Text(
//                   'Home',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/home');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.event_available,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: Text('Attendance'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/attendance');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.airplanemode_on_sharp,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: Text('Leaves'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/leave');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.list_alt,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: Text('Requests'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/requests');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.person_pin_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: Text('Profile'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/profile');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.receipt_long_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: Text('News'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/news_screen');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.receipt_long_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: Text('PaySlips'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/payslips');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.assignment_turned_in_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: Text('Approval Tasks'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/taskScreen');
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.group_add_outlined,
//                   color: Color.fromRGBO(77, 40, 128, 0.5),
//                   size: 35,
//                 ),
//                 title: Text('My Team'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.pushNamed(context, '/employee');
//                 },
//               ),
//               Divider(
//                 thickness: 0.5,
//               ),
//               ListTile(
//                 onTap: () {
//                   Navigator.pop(
//                     context,
//                   );
//                   Navigator.pushNamed(context, '/login');
//                 },
//                 contentPadding: EdgeInsets.zero, // Remove default padding
//                 title: Center(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
//                     decoration: BoxDecoration(
//                       border: Border.all(width: 2, color: Colors.red),
//                       color: Colors.white,
//                       borderRadius:
//                       BorderRadius.circular(10), // Rounded corners
//                     ),
//                     child: Row(
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
//                 // dense: true,
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: celebrations.isEmpty
//             ? Center(child: CircularProgressIndicator())
//             : ListView.builder(
//           itemCount: celebrations.length,
//           itemBuilder: (context, index) {
//             return Card(
//               elevation: 4.0, // Adds a shadow to each card
//               margin: const EdgeInsets.all(8.0), // Adds spacing around each card
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundColor: AppColors.background, // Custom color for the icon background
//                   child: Icon(
//                     getIcon(celebrations[index]['icon']),
//                     color: Colors.white, // Icon color
//                   ),
//                 ),
//                 title: Text(
//                   '${celebrations[index]['type']} for ${celebrations[index]['name']}',
//                   style: const TextStyle(fontWeight: FontWeight.bold), // Bold text for the title
//                 ),
//                 subtitle: Text('${celebrations[index]['date']}'),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.message),
//                   color: AppColors.background, // Custom color for the message icon
//                   onPressed: () {
//                     // Implement messaging functionality
//                   },
//                 ),
//                 onTap: () {
//                   // You can add navigation or other interactions here
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
