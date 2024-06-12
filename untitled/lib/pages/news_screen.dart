
import 'package:flutter/material.dart';
import 'package:untitled/app_bar.dart';
import 'celebrations.dart';
import 'news.dart';
// import 'staff_page.dart';
import 'event.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'News', showActions: true, showLeading: false, context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 5,
              shrinkWrap: true,
              children: [
                _buildModuleCard(
                  context,
                  title: 'Celebrations',
                  icon: Icons.celebration,
                  page: const News(),
                ),
                _buildModuleCard(
                  context,
                  title: 'Anniversaries',
                  icon: Icons.cake,
                  page: const News(),
                ),
                _buildModuleCard(
                  context,
                  title: 'Event',
                  icon: Icons.event,
                  page: const News(),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Divider(thickness: 2,),
            SizedBox(height: 10),
            Text(
              'General News',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildNewsCard('New Policy Update', 'Details about the new policy.', Icons.policy),
                  ],
                ),
                Row(
                  children: [
                    _buildNewsCard('Upcoming Holiday', 'Information about the upcoming holiday.', Icons.holiday_village),
                  ],
                ),
                Row(
                  children: [
                    _buildNewsCard('Team Outing', 'Details about the team outing.', Icons.people),
                  ],
                ),
              ],
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
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
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
                offset: const Offset(0, 3), // changes position of shadow
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
                    child: Icon(icon, size: 40, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
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
Widget _buildNewsCard(String title, String description, IconData icon) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      width: 344,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 40, color: Colors.purple),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                description,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
