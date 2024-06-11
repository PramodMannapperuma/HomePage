
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
            Image.network(article['image']!),
            const SizedBox(height: 16),
            Text(
              article['title']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              article['description']!,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

