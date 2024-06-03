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
        appBarTheme: AppBarTheme(

        ),

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
        
        backgroundColor: Color(0xFF000033),
        title: const Text("Homepage", style: TextStyle(color: Colors.white),),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Set to transparent or any color you like
          statusBarIconBrightness: Brightness.light, // Adjust icon brightness for contrast
        ),
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/3039972.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white,),
            onPressed: () {
              // Handle navigation drawer open
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
