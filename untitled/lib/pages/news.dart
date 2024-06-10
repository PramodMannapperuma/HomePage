import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final List<Map<String, String>> newsArticles = [
    {
      'title': 'Today is monday!',
      'description': 'Date is June 10.',
      'image': 'https://www.vecteezy.com/free-vector/hello-june'
    },
    {
      'title': 'Happy Birthday',
      'description': 'Today is your birthday.',
      'image':
          'https://kentstreetcellars.com.au/products/happy-birthday-gift-card'
    },
    {
      'title': 'Tomorrow is Tuesday!',
      'description': 'Date is June 11.',
      'image': 'https://www.vecteezy.com/free-vector/hello-june'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: ListView.builder(
        itemCount: newsArticles.length,
        itemBuilder: (context, index) {
          final article = newsArticles[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(article['image']!),
              title: Text(article['title']!),
              subtitle: Text(article['description']!),
              onTap: () {
                // Handle news article tap
              },
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: News(),
  ));
}
