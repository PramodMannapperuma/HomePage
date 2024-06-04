import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'module_grid.dart';
import 'user_section.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4d2880),
        title: const Text(
          "Homepage",
          style: TextStyle(color: Colors.white),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 62.0 * MediaQuery.of(context).devicePixelRatio, // Adjusted width
            height: 62.0 * MediaQuery.of(context).devicePixelRatio, // Adjusted height
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/hrislogo3.png'),
                fit: BoxFit.contain,
              ),
              shape: BoxShape.rectangle,
              // borderRadius: BorderRadius.all(
              //   Radius.circular(4.0),
              // ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle navigation drawer open
            },
          ),
        ],
      ),
      body:
      // Foreground content
      const Column(
        children: [
          UserSection(),
          ModuleGrid(),
        ],
      ),
    );
  }
}
