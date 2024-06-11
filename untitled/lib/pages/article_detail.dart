import 'package:flutter/material.dart';

class ArticleDetail extends StatelessWidget {
  final Map<String, String> article;

  const ArticleDetail({required this.article, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity, // makes the image take full width
              height: 200, // fixed height for the image
              child: Image.network(
                article['image']!,
                fit: BoxFit.cover, // ensures the image covers the SizedBox area
              ),
            ),
            const SizedBox(height: 16),
            Text(
              article['title']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              article['description']!,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

