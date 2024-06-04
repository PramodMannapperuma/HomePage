import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar customAppBar({required String title, required bool showActions}) {
  return AppBar(
    backgroundColor: const Color(0xff4d2880),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 62.0, // Adjusted width
        height: 62.0, // Adjusted height
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hrislogo3.png'),
            fit: BoxFit.contain,
          ),
          shape: BoxShape.rectangle,
        ),
      ),
    ),
    actions: showActions
        ? [
      IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          // Handle navigation drawer open
        },
      ),
    ]
        : null,
  );
}