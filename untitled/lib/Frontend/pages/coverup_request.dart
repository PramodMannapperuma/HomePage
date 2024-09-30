import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled/Backend/APIs/Apis.dart';
import '../app_bar.dart';
import '../styles/sidebar.dart';
import '../../Backend/models/cover_up_detail.dart';

class CoverupRequestScreen extends StatefulWidget {
  final String token;
  final bool isFromSidebar;
  final bool isFromAppbar;

  const CoverupRequestScreen(
      {Key? key,
        required this.token,
        required this.isFromSidebar,
        required this.isFromAppbar})
      : super(key: key);

  @override
  _CoverupRequestScreenState createState() => _CoverupRequestScreenState();
}

class _CoverupRequestScreenState extends State<CoverupRequestScreen> {
  List<CoverUpDetail> coverUps = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      isLoading = true; // Show loader while fetching data
    });
    try {
      final fetchedCoverUps = await ApiService.getCoverUpDetails(
          widget.token, 2); // Example employeeId
      setState(() {
        coverUps = fetchedCoverUps;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  // This method refreshes the page after accepting or rejecting a cover-up
  Future<void> _refreshPage() async {
    await _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'Cover-Up Requests',
        showActions: true,
        showLeading: true,
        context: context,
        showBackButton: widget.isFromSidebar,
        showBellIcon: widget.isFromSidebar,
        token: widget.token, // Passing token to AppBar
      ),
      drawer: widget.isFromSidebar ? CustomSidebar(token: widget.token) : null,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SectionHeader(title: 'Pending Cover-Up Approvals'),
            coverUps.isEmpty
                ? Center(child: Text('No cover-up approvals found'))
                : CoverUpList(
              coverUps: coverUps,
              token: widget.token,
              onActionCompleted: _refreshPage, // Trigger refresh
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff4d2880),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CoverUpList extends StatelessWidget {
  final List<CoverUpDetail> coverUps;
  final String token;
  final Future<void> Function() onActionCompleted; // Added refresh function

  const CoverUpList(
      {Key? key,
        required this.coverUps,
        required this.token,
        required this.onActionCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: coverUps.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2,
          child: ListTile(
            contentPadding: EdgeInsets.all(15.0),
            title: Text(
              'Date: ${coverUps[index].date}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Leave Type: ${coverUps[index].leaveType}',
                    style: TextStyle(fontSize: 15.0)),
                Text('Time: ${coverUps[index].time}',
                    style: TextStyle(fontSize: 15.0)),
                Text('Reason: ${coverUps[index].reason}',
                    style: TextStyle(fontSize: 15.0)),
                Text('Covered By: ${coverUps[index].extra}',
                    style: TextStyle(fontSize: 15.0)),
              ],
            ),
            trailing: CoverActionButton(
              token: token,
              id: coverUps[index].id,
              onActionCompleted: onActionCompleted, // Trigger refresh
            ),
          ),
        );
      },
    );
  }
}

class CoverActionButton extends StatelessWidget {
  final String token;
  final int id;
  final Future<void> Function() onActionCompleted; // Added refresh function

  const CoverActionButton(
      {Key? key, required this.token, required this.id, required this.onActionCompleted})
      : super(key: key);

  Future<void> _showSuccessDialog(
      BuildContext context, String message, String action) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                action == "approve" ? Icons.check_circle : Icons.error,
                color: action == "approve" ? Colors.green : Colors.red,
              ),
              SizedBox(width: 10),
              Text('Success'),
            ],
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCommentDialog(BuildContext context, String action) async {
    TextEditingController commentController = TextEditingController();
    bool isLoading = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Comment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: commentController,
                    decoration: InputDecoration(hintText: 'Enter your comment'),
                  ),
                  if (isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                        size: 50.0,
                      ),
                    ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss the dialog
                  },
                ),
                TextButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () async {
                    setState(() {
                      isLoading = true; // Show loading icon
                    });

                    try {
                      await ApiService().approveCoverUp(
                        token,
                        [id],
                        action,
                        commentController.text,
                      );
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(dialogContext)
                          .pop(); // Dismiss the dialog
                      await _showSuccessDialog(context,
                          'Cover-up $action successfully!', action);
                      onActionCompleted(); // Trigger page refresh
                    } catch (e) {
                      setState(() {
                        isLoading = false; // Stop loading if failed
                      });
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "approve"),
          child: Text(
            'Accept',
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(width: 4.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          ),
          onPressed: () => _showCommentDialog(context, "reject"),
          child: Text(
            'Decline',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
