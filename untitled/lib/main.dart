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
        backgroundColor: const Color(0xFF00001a),
        title: const Text(
          "Homepage",
          style: TextStyle(color: Colors.white),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor:
              Colors.transparent,
          statusBarIconBrightness:
              Brightness.light,
        ),
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/3039972.png'),
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
          const SingleChildScrollView(
            child: Column(
              children: [
                UserSection(),
                ModuleGrid(),
              ],
            ),
          ),
    );
  }
}
