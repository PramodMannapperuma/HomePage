import 'package:flutter/material.dart';

class Celebrations extends StatefulWidget {
  const Celebrations({Key? key}) : super(key: key);

  @override
  _CelebrationsState createState() => _CelebrationsState();
}

class _CelebrationsState extends State<Celebrations> {
  // Dummy data for celebrations
  final List<Map<String, dynamic>> celebrations = [
    {'type': 'Birthday', 'name': 'Alice', 'date': 'Today', 'icon': Icons.cake},
    {'type': 'Anniversary', 'name': 'Bob and Carol', 'date': 'Tomorrow', 'icon': Icons.favorite},
    {'type': 'Retirement', 'name': 'Dave', 'date': 'Next Monday', 'icon': Icons.airline_seat_individual_suite},
    // Add more celebration details here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Celebrations'),
        backgroundColor: Colors.purple, // Custom color for the AppBar
      ),
      body: ListView.builder(
        itemCount: celebrations.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0, // Adds a shadow to each card
            margin: EdgeInsets.all(8.0), // Adds spacing around each card
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple, // Custom color for the icon background
                child: Icon(
                  celebrations[index]['icon'],
                  color: Colors.white, // Icon color
                ),
              ),
              title: Text(
                '${celebrations[index]['type']} for ${celebrations[index]['name']}',
                style: TextStyle(fontWeight: FontWeight.bold), // Bold text for the title
              ),
              subtitle: Text('${celebrations[index]['date']}'),
              trailing: IconButton(
                icon: Icon(Icons.message),
                color: Colors.purple, // Custom color for the message icon
                onPressed: () {
                  // Implement messaging functionality
                },
              ),
              onTap: () {
                // You can add navigation or other interactions here
              },
            ),
          );
        },
      ),
    );
  }
}
