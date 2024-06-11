import 'package:flutter/material.dart';
import 'article_detail.dart'; // Import the new file

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final List<Map<String, String>> newsArticles = [
    {
      'title': 'Today is Monday!',
      'description': 'Date is June 10.',
      'image': 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fmonday&psig=AOvVaw1XxEauYShwHE6QJgs3SXFg&ust=1718172308313000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKCHmOPw0oYDFQAAAAAdAAAAABAH'
    },
    {
      'title': 'Happy Birthday',
      'description': 'Today is your birthday.',
      'image': 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fstock.adobe.com%2Fsearch%3Fk%3Dhappy%2Bbirthday&psig=AOvVaw2E3U0iqEEsdlYg7klsC7py&ust=1718172366733000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCMDsgP_w0oYDFQAAAAAdAAAAABAE'
    },
    {
      'title': 'Tomorrow is Tuesday!',
      'description': 'Date is June 11.',
      'image': 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fstock.adobe.com%2Fsearch%2Fimages%3Fk%3D%2522happy%2Btuesday%2522&psig=AOvVaw2NjlnrQJor7NN7Zr-s_fBB&ust=1718172423444000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKjOkpnx0oYDFQAAAAAdAAAAABAE'
    },
  ];

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
                child: Image.network(
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
                    builder: (context) => ArticleDetail(article: article),
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




