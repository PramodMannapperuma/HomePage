import 'package:flutter/material.dart';

class Celebrations extends StatefulWidget {
  const Celebrations({super.key});

  @override
  State<Celebrations> createState() => _CelebrationsState();
}

class _CelebrationsState extends State<Celebrations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Celebrations'),
      ),
      body: Center(
        child: Text('Welcome to Celebrations!'),
      ),
    );
  }
}
