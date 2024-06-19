import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NewHomes extends StatefulWidget {
  const NewHomes({super.key});

  @override
  State<NewHomes> createState() => _NewHomesState();
}

class _NewHomesState extends State<NewHomes> {
  final List<String> imagePaths = [
    'assets/images/Approval.png',
    'assets/images/Profile.jpeg',
    'assets/images/Celebration.png',
    'assets/images/Request.png',
    'assets/images/Policies.png',
    'assets/images/News.png',
    'assets/images/leave.png',
    'assets/images/attendance.jpg',
    'assets/images/msg.jpeg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            imagePaths[index],
          ),
        ),
      ),
    );
  }
}
