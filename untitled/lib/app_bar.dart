import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar customAppBar({required String title, required bool showActions, required bool showLeading, required BuildContext context}) {
  return AppBar(
    // backgroundColor: const Color(0xff4d2880),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/hrislogo2.png', height: 40.0,),
        SizedBox( width: 8.0,),
        Text(title)
      ],
    ),
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    // leading: Builder(
    //   builder: (BuildContext context) {
    //     return Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: IconButton(
    //         icon: const Icon(
    //           Icons.menu_outlined,
    //           color: Color(0xff4d2880),
    //         ),
    //         onPressed: () {
    //           Scaffold.of(context).openDrawer();
    //         },
    //       ),
    //     );
    //   },
    // ),
    actions: showActions
        ? [
      Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.menu_outlined,
                color: Color(0xff4d2880),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          );
        },
      ),
    ]
        : null,
  );
}