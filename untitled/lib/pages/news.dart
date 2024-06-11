import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: ListView.builder(
        itemCount: newsArticles.length,
        itemBuilder: (context, index) {
          final article = newsArticles[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: SizedBox(
                width: 60, // fixed width for the image
                height: 60, // fixed height for the image
                child: Image.asset(
                  article['image']!,
                  fit: BoxFit.cover, // ensures the image covers the SizedBox area
                ),
              ),
              title: Text(article['title']!),
              subtitle: Text(article['description']!),
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
