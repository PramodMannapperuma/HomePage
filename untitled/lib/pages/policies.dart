import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';

class Policies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PolicyScreen();
  }
}

class PolicyScreen extends StatefulWidget {
  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Policies',
          showActions: true,
          showLeading: false,
          context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Leave Policy',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/leavePolicy');
                  },
                  icon: Icon(Icons.navigate_next),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Attendance Policy',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/leavePolicy');
                  },
                  icon: Icon(Icons.navigate_next),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Request Policy',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/leavePolicy');
                  },
                  icon: Icon(Icons.navigate_next),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Leave Policy',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/leavePolicy');
                  },
                  icon: Icon(Icons.navigate_next),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Leave Policy',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/leavePolicy');
                  },
                  icon: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
