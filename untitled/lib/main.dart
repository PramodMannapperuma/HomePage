import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

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
          padding: EdgeInsets.all(8.0),
          child: Container(
            width: 62.0 * MediaQuery.of(context).devicePixelRatio, // Adjusted width
            height: 62.0 * MediaQuery.of(context).devicePixelRatio, // Adjusted height
            decoration: BoxDecoration(
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
          // CircleAvatar(
          //   backgroundImage: AssetImage(
          //     'assets/images/webLogo.png',
          //   ),
          //   radius: 10.0,
          // ),
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
          Column(
            children: [
              UserSection(),
              ModuleGrid(),
            ],
          ),
    );
  }
}
