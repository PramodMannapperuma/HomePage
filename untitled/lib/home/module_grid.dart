import 'package:flutter/material.dart';
import '';
class ModuleGrid extends StatelessWidget {
  const ModuleGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width * 1.1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/sidebar.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width *
                1, // Adjust the width as needed
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(77, 40, 128, 0.5), // rgba(77, 40, 128, 0.5)
                  Color.fromRGBO(77, 40, 128, 0.5), // rgba(77, 40, 128, 0.5)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
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
                  color: Colors.blue,
                  route: '/attendance',
                ),
                ModuleCard(
                  title: 'Leave',
                  icon: Icons.beach_access,
                  color: Colors.green,
                  route: '/leave',
                ),
                ModuleCard(
                  title: 'News',
                  icon: Icons.article,
                  color: Colors.red,
                  route: '/news',
                ),
                ModuleCard(
                  title: 'Policies',
                  icon: Icons.policy,
                  color: Colors.orange,
                  route: '/policies',
                ),
                ModuleCard(
                  title: 'Request',
                  icon: Icons.request_page,
                  color: Colors.purple,
                  route: '/requests',
                ),
                ModuleCard(
                  title: 'Celebrations',
                  icon: Icons.celebration,
                  color: Colors.yellow,
                  route: '/celebrations',
                ),
                ModuleCard(
                  title: 'Profile View',
                  icon: Icons.person,
                  color: Colors.teal,
                  route: '/profile',
                ),
                ModuleCard(
                  title: 'PaySlips',
                  icon: Icons.payment,
                  color: Colors.pink,
                  route: '/payslips',
                ),
                ModuleCard(
                  title: 'Approval Task',
                  icon: Icons.approval,
                  color: Colors.brown,
                  route: '/approvalTask',
                ),
                ModuleCard(
                  title: 'Msg',
                  icon: Icons.message,
                  color: Colors.indigo,
                  route: '/msg',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ModuleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const ModuleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25, // Adjust the radius as needed
              backgroundColor: Colors.white,
              child: Icon(icon, size: 25, color: color),
            ),
            const SizedBox(height: 8),
            const Divider(
              thickness: 1,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
