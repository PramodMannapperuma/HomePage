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
              child: Image.asset(
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
                Theme(
                  data: Theme.of(context).copyWith(
                    iconTheme: const IconThemeData(
                      color: Color(0xff4d2880), // Set the color to purple
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final comment = _commentController.text;
                      if (comment.isNotEmpty) {
                        widget.onCommentAdded(comment);
                        setState(() {
                          widget.comments.add(comment);
                          _commentController.clear();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
