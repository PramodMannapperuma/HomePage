import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/app_colors.dart';

AppBar customAppBar(
    {required String title,
    required bool showActions,
    required bool showLeading,
    required BuildContext context}) {
  return AppBar(
    // backgroundColor: const Color(0xff4d2880),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/hrislogo2.png',
          height: 40.0,
        ),
        SizedBox(
          width: 8.0,
        ),
        // Text(title),
      ],
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(35.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(
            color: Colors.black,
            // height: 1.0,
            thickness: 0.2,
          ),
        ],
      ),
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
                      color: AppColors.background,
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
