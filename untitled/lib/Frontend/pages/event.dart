import 'package:flutter/material.dart';

import '../app_bar.dart';
import '../styles/app_colors.dart';
import '../styles/sidebar.dart';
import 'article_detail.dart';

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
      drawer: CustomSidebar(token: '',),
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

