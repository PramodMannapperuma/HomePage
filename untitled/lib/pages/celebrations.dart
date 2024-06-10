import 'package:flutter/material.dart';

class Celebrations extends StatefulWidget {
  const Celebrations({super.key});

  @override
  State<Celebrations> createState() => _CelebrationsState();
}

class _CelebrationsState extends State<Celebrations> {
  final List<String> birthdays = ['John Doe', 'Jane Smith'];
  final List<String> anniversaries = ['Anna & John', 'Lisa & Mark'];
  final List<String> retirements = ['Michael Brown'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Celebrations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            _buildSectionTitle('Birthdays'),
            ..._buildCelebrationCards(birthdays, 'Happy Birthday!'),

            _buildSectionTitle('Anniversaries'),
            ..._buildCelebrationCards(anniversaries, 'Happy Anniversary!'),

            _buildSectionTitle('Retirements'),
            ..._buildCelebrationCards(retirements, 'Happy Retirement!'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  List<Widget> _buildCelebrationCards(List<String> names, String message) {
    return names.map((name) {
      return Card(
        child: ListTile(
          title: Text(name),
          trailing: IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              _sendMessage(name, message);
            },
          ),
        ),
      );
    }).toList();
  }

  void _sendMessage(String name, String message) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _controller = TextEditingController();
        return AlertDialog(
          title: Text('Send Message to $name'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Enter your message'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // You can add functionality to send the message here
                print('Message to $name: ${_controller.text}');
                Navigator.of(context).pop();
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Celebrations(),
  ));
}
