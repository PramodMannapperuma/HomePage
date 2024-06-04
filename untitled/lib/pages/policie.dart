import 'package:flutter/material.dart';

class Policies extends StatefulWidget {
  const Policies({super.key});

  @override
  State<Policies> createState() => _PoliciesState();
}

class _PoliciesState extends State<Policies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policies'),
      ),
      body: Center(
        child: Text('Welcome to Policies!'),
      ),
    );
  }
}
