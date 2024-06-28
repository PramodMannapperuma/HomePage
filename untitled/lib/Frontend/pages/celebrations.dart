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
// import '../styles/sidebar.dart';
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
//       drawer: CustomSidebar(),
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
