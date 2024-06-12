
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
        backgroundColor: const Color(0xff4d2880), // Custom color for the AppBar
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
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [Color(0xff4d2880), Color(0xff8a2be2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  color: Colors.white.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(icon, size: 50, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
