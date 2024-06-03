import 'package:flutter/material.dart';

class UserSection extends StatelessWidget {
  const UserSection({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color:Colors.grey,width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(

              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user.jpg'), // replace with your image asset
                  radius: 40,
                ),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hello User ,', style: TextStyle(fontSize: 24),),
                    Text('Last login: 2024/06/03', style: TextStyle(fontSize: 20), ),
                  ],
                ),

              ],
            ),
            SizedBox(width: 8),
            Icon(Icons.settings, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class ModuleGrid extends StatelessWidget {
  const ModuleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *
          0.8, // Adjust the height as needed
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 3 / 2,
        padding: const EdgeInsets.all(8.0),
        children: const [
          ModuleCard(
              title: 'Attendance',
              icon: Icons.event_available,
              color: Colors.blue),
          ModuleCard(
              title: 'Leave', icon: Icons.beach_access, color: Colors.green),
          ModuleCard(title: 'News', icon: Icons.article, color: Colors.red),
          ModuleCard(
              title: 'Policies', icon: Icons.policy, color: Colors.orange),
          ModuleCard(
              title: 'Request', icon: Icons.request_page, color: Colors.purple),
          ModuleCard(
              title: 'Celebrations',
              icon: Icons.celebration,
              color: Colors.yellow),
          ModuleCard(
              title: 'Profile View', icon: Icons.person, color: Colors.teal),
          ModuleCard(
              title: 'PaySlips', icon: Icons.payment, color: Colors.pink),
          ModuleCard(
              title: 'Approval Task',
              icon: Icons.approval,
              color: Colors.brown),
          ModuleCard(title: 'Msg', icon: Icons.message, color: Colors.indigo),
        ],
      ),
    );
  }
}

class ModuleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const ModuleCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Add navigation or functionality here
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30, // Adjust the radius as needed
              backgroundColor: Colors.white,
              child: Icon(icon, size: 30, color: color),
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

