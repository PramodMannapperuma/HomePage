import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'module_grid.dart';

class TestHomeApp extends StatefulWidget {
  const TestHomeApp({Key? key}) : super(key: key);

  @override
  State<TestHomeApp> createState() => _TestHomeAppState();
}

class _TestHomeAppState extends State<TestHomeApp> {
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
            (context, index) => Tile(index: index),
            childCount: 9
          ),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
    // required this.title,
    // required this.icon,
    // required this.color,
    // required this.route,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;
  // final String title;
  // final IconData icon;
  // final Color color;
  // final String route;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(10.0),
      //   border: Border.all(color: Colors.black, width: 2.0), // Add border
      // ),
      color:
      // Colors.purple.withOpacity(0.70),
      Color.fromRGBO(77, 40, 120, 0.8),
      height: extent,
      child: Center(
        child: InkWell(
          onTap: () {
            // Navigator.pushNamed(context, route);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                minRadius: 20,
                maxRadius: 20,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Icon(Icons.man, size: 30, color: Colors.purple),
              ),
              const SizedBox(height: 8),
              const Divider(
                thickness: 1,
              ),
              Text(
                'title',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}
