import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Frontend/pages/coverup_request.dart';
import 'package:untitled/Frontend/styles/app_colors.dart';

AppBar customAppBar({
  required String title,
  required bool showActions,
  required bool showLeading,
  required BuildContext context,
  bool showBackButton = false,
  bool showBellIcon = false, // New parameter to control bell icon visibility
  String? token, // Added token parameter
}) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/hrislogo2.png',
          height: 40.0,
        ),
        SizedBox(width: 8.0),
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
    leading: showLeading
        ? showBackButton
        ? IconButton(
      icon: Icon(Icons.arrow_back, color: AppColors.background),
      onPressed: () => Navigator.of(context).pop(),
    )
        : Builder(
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(
              Icons.menu_outlined,
              color: AppColors.background,
            ),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        );
      },
    )
        : null,
    actions: <Widget>[
      if (showBellIcon)
        IconButton(
          icon: const Icon(
            Icons.notifications_active_outlined,
            color: AppColors.background,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CoverupRequestScreen(
                  token: token ?? '', // Provide a default value if token is null
                  isFromSidebar: true,
                  isFromAppbar: true,
                ),
              ),
            );
          },
        ),
      if (showActions)
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
    ],
  );
}
