import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TestHomeApp extends StatefulWidget {
  const TestHomeApp({Key? key}) : super(key: key);

  @override
  State<TestHomeApp> createState() => _TestHomeAppState();
}

class _TestHomeAppState extends State<TestHomeApp> {
  final List<TileInfo> tilesInfo = [
    TileInfo('Attendance',Icons.event_available,'/attendance',Colors.blue,'assets/images/attendance.jpeg'),
    TileInfo('Leave', Icons.beach_access,'/leave',Colors.pinkAccent, 'assets/images/leave.jpeg'),
    TileInfo('News', Icons.article,'/news',Colors.cyan, 'assets/images/news.jpeg'),
    TileInfo('Policies', Icons.policy,'/policies',Colors.red, 'assets/images/policies.jpeg'),
    TileInfo('Request', Icons.request_page,'/requests',Colors.green, 'assets/images/request.jpeg'),
    TileInfo('Celebrations', Icons.celebration, '/celebrations', Colors.teal,'assets/images/celebrations.jpeg'),
    TileInfo('Profile View', Icons.person,'/profile',Colors.brown,'assets/images/profile.jpeg'),
    TileInfo('Approval Task', Icons.approval,'/taskList',Colors.black45,'assets/images/approval.jpeg'),
    TileInfo('Msg', Icons.message,'/msg',Colors.indigo,'assets/images/msg.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.custom(
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            pattern: const [
              WovenGridTile(1),
              WovenGridTile(
                7 / 9,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.center,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) => Tile(tileInfo: tilesInfo[index],
            ),
            childCount: tilesInfo.length
          ),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final TileInfo tileInfo;

  const Tile({
    Key? key,
    required this.tileInfo
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final child = Container(

      color:
      Colors.deepPurple,
          // .withOpacity(0.60),
      // Color.fromRGBO(77, 40, 120, 0.8),
      height: 120,
      foregroundDecoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(tileInfo.imagePath), // Replace with your image path
          fit: BoxFit.cover,
        ),
          border: Border.all(color: Colors.purple, width: 2.0), // Add border
      ),
      // extent,
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, tileInfo.route);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                minRadius: 20,
                maxRadius: 20,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Icon(tileInfo.icon, size: 30, color: tileInfo.color),
              ),
              const SizedBox(height: 8),
              const Divider(
                thickness: 1,
              ),
              Text(
                tileInfo.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

    // if (bottomSpace == null) {
    //   return child;
    // }
    //
    // return Column(
    //   children: [
    //     Expanded(child: child),
    //     Container(
    //       height: bottomSpace,
    //       color: Colors.green,
    //     )
    //   ],
    // );
    return child;
  }
}

class TileInfo {
  final String title;
  final IconData icon;
  final String route;
  final Color color;
  final String imagePath;


  TileInfo(this.title, this.icon, this.route, this.color, this.imagePath);
}
