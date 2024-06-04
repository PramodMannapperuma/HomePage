import 'package:flutter/material.dart';

class Msg extends StatefulWidget {
  const Msg({super.key});

  @override
  State<Msg> createState() => _MsgState();
}

class _MsgState extends State<Msg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Msg'),
      ),
      body: Center(
        child: Text('Welcome to Msg !'),
      ),
    );
  }
}
