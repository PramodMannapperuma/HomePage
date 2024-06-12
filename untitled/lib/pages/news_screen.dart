import 'package:flutter/material.dart';
import 'celebrations.dart';
import 'news.dart';
// import 'staff_page.dart';
import 'event.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildModuleCard(
              context,
              title: 'Celebrations',
              icon: Icons.celebration,
              page: const Celebrations(),
            ),
            _buildModuleCard(
              context,
              title: 'Anniversaries',
              icon: Icons.cake,
              page: const News(),
            ),
            // _buildModuleCard(
            //   context,
            //   title: 'Staff',
            //   icon: Icons.person,
            //   page: const StaffPage(),
            // ),
            _buildModuleCard(
              context,
              title: 'Event',
              icon: Icons.event,
              page: const event(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context,
      {required String title, required IconData icon, required Widget page}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.purple),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
