// import 'package:flutter/material.dart';
// import 'package:untitled/app_bar.dart';
// import 'package:untitled/styles/app_colors.dart';

// class ArticleDetail extends StatefulWidget {
//   final Map<String, String> article;
//   final List<String> comments;
//   final Function(String) onCommentAdded;

//   const ArticleDetail({
//     required this.article,
//     required this.comments,
//     required this.onCommentAdded,
//     Key? key,
//   }) : super(key: key);

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
//           title: Text(widget.article['title']!),
//           // showActions: true,
//           // showLeading: false,
//           // context: context
//           ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10.0),
//               child: Image.asset(
//                 widget.article['image']!,
//                 width: double.infinity,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               widget.article['title']!,
//               style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.background // Custom color for the title
//                   ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               widget.article['description']!,
//               style: const TextStyle(
//                 fontSize: 18,
//                 color:
//                     Colors.black87, // Slightly softer color for the description
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Comments',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors
//                     .background, // Custom color for the comments section
//               ),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: widget.comments.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     elevation: 2.0,
//                     margin: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(widget.comments[index]),
//                     ),
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
//                     decoration: InputDecoration(
//                       hintText: 'Add a comment',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       contentPadding:
//                           const EdgeInsets.symmetric(horizontal: 8.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   color: AppColors.background, // Set the color to purple
//                   onPressed: () {
//                     final comment = _commentController.text;
//                     if (comment.isNotEmpty) {
//                       widget.onCommentAdded(comment);
//                       setState(() {
//                         widget.comments.add(comment);
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
import 'package:untitled/styles/app_colors.dart';

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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                widget.article['image']!,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.article['title']!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.background, // Custom color for the title
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.article['description']!,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87, // Slightly softer color for the description
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Comments',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.background, // Custom color for the comments section
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: widget.comments.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2.0,
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.comments[index]),
                    ),
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
                    decoration: InputDecoration(
                      hintText: 'Add a comment',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: AppColors.background, // Set the color to purple
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
