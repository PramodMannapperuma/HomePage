import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'article_detail.dart'; // Import the new file

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final List<Map<String, String>> newsArticles = [
    {
      'title': 'Today is Monday!',
      'description': 'Date is June 10.',
      'image': 'assets/images/Monday.jpg',
    },
    {
      'title': 'Happy Birthday',
      'description': 'Today is your birthday.',
      'image': 'assets/images/Birthday.jpeg',
    },
    {
      'title': 'Tomorrow is Tuesday!',
      'description': 'Date is June 11.',
      'image': 'assets/images/Tuesday.jpg',
    },
  ];

  List<List<String>> commentsList = List.generate(3, (_) => []); // Initialize empty comment lists

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'News', showActions: true, showLeading: false, context: context),
      body: ListView.builder(
        itemCount: newsArticles.length,
        itemBuilder: (context, index) {
          final article = newsArticles[index];
          return Card(
            elevation: 4.0, // Adds a shadow to each card
            margin: const EdgeInsets.all(8.0), // Adds spacing around each card
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xff4d2880), // Custom color for the icon background
                backgroundImage: AssetImage(article['image']!), // Use the article image
              ),
              title: Text(
                article['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold), // Bold text for the title
              ),
              subtitle: Text(article['description']!),
              trailing: IconButton(
                icon: const Icon(Icons.message),
                color: const Color(0xff4d2880), // Custom color for the message icon
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
                      comments: commentsList[index], // Pass comments list for the selected article
                      onCommentAdded: (comment) {
                        setState(() {
                          commentsList[index].add(comment); // Add comment to the comments list
                        });
                      },
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
