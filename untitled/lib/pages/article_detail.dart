// import 'package:flutter/material.dart';

// class ArticleDetail extends StatelessWidget {
//   final Map<String, String> article;

//   const ArticleDetail({required this.article, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(article['title']!),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: double.infinity, // makes the image take full width
//               height: 200, // fixed height for the image
//               child: Image.network(
//                 article['image']!,
//                 fit: BoxFit.cover, // ensures the image covers the SizedBox area
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               article['title']!,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               article['description']!,
//               style: const TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';

// class ArticleDetail extends StatefulWidget {
//   final Map<String, String> article;
//   final List<String> comments;

//   const ArticleDetail({required this.article, required this.comments, Key? key}) : super(key: key);

//   @override
//   _ArticleDetailState createState() => _ArticleDetailState();
// }

// class _ArticleDetailState extends State<ArticleDetail> {
//   late TextEditingController _commentController;

//   @override
//   void initState() {
//     super.initState();
//     _commentController = TextEditingController();
//   }

//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.article['title']!),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: double.infinity, // makes the image take full width
//               height: 200, // fixed height for the image
//               child: Image.network(
//                 widget.article['image']!,
//                 fit: BoxFit.cover, // ensures the image covers the SizedBox area
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               widget.article['title']!,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               widget.article['description']!,
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Comments',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.comments.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(widget.comments[index]),
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _commentController,
//                     decoration: const InputDecoration(
//                       hintText: 'Add a comment',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     if (_commentController.text.isNotEmpty) {
//                       setState(() {
//                         widget.comments.add(_commentController.text);
//                         _commentController.clear();
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ArticleDetail extends StatefulWidget {
  final Map<String, String> article;
  final List<String> comments;
  final Function(String) onCommentAdded;

  const ArticleDetail({
    required this.article,
    required this.comments,
    required this.onCommentAdded,
    Key? key,
  }) : super(key: key);

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _commentController.text = widget.comments
        .join('\n'); // Initialize controller with existing comments
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article['title']!),
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
                widget.article['image']!,
                fit: BoxFit.cover, // ensures the image covers the SizedBox area
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.article['title']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              widget.article['description']!,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              'Comments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.comments[index]),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Add a comment',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final comment = _commentController.text;
                    if (comment.isNotEmpty) {
                      widget.onCommentAdded(comment);
                      _commentController.clear();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
