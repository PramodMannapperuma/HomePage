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
  bool showInfoIcon = false,
  String? token, // Added token parameter
}) {
  bool _showTooltip = true; // Assume this is managed by a stateful widget.

  // Function to hide the tooltip
  void _hideTooltipMessage() {
    // Logic to hide the tooltip
    _showTooltip = false; // Simulating setState in a stateless context
  }

  // Helper method for creating legend items
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 10),
        Text(label),
      ],
    );
  }


  // Future dialog to show attendance amendment info
  Future<void> _showAttendanceAmendmentInfo(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("How to amend Attendance?"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Select any day or range of days to make amendments."),
                SizedBox(height: 10),
                Text("The colors below represent the status of each attendance:"),
                SizedBox(height: 10),
                _buildLegendItem("Incomplete", Colors.grey),
                _buildLegendItem("Amendment", Colors.blue),
                _buildLegendItem("Pending",Colors.amber),
                _buildLegendItem("Rejected", Colors.red),
                _buildLegendItem("Attendance", Colors.green),
                _buildLegendItem("Holiday", Colors.black),
                _buildLegendItem("Leave",  Colors.purple),
                SizedBox(height: 20),
                Text("***Make sure to save after any changes!"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


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
      if (showInfoIcon)
        IconButton(
          icon: Icon(Icons.info_outline),
          color: Color(0xff4d2880),
          onPressed: () {
            _hideTooltipMessage(); // Hide tooltip when info is clicked
            _showAttendanceAmendmentInfo(context); // Show the info dialog
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
