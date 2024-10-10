import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import '../../Backend/APIs/Apis.dart';
import '../app_bar.dart';

class LeavePolicy extends StatefulWidget {
  final String token;
  const LeavePolicy({super.key, required this.token});

  @override
  State<LeavePolicy> createState() => _LeavePolicyState();
}

class _LeavePolicyState extends State<LeavePolicy> {
  late PdfControllerPinch pdfControllerPinch;
  int totalPageCount = 0;
  int currentPage = 1;
  bool _isLoading = true;
  String? pdfFilePath;

  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    print('token in leavepolicy: ${widget.token}');
    _fetchPolicies();
  }

  Future<void> _fetchPolicies() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final filePath = await apiService.fetchPolicy(widget.token);

      setState(() {
        pdfFilePath = filePath;
        pdfControllerPinch = PdfControllerPinch(
          document: PdfDocument.openFile(pdfFilePath!),
        );
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading policy data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<bool> _onWillPop() async {
    // Check if the user is on the last page
    if (currentPage < totalPageCount) {
      // Show a message if the user tries to go back from a non-last page
      _showMessage("Please go through the whole PDF.");
      return false; // Prevent back navigation
    } else {
      // Confirm exit when the user is on the last page
      bool? confirmation = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Exit"),
            content: Text("Have you read and understood the policy?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // User has not confirmed
                },
                child: Text("No"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // User confirms
                },
                child: Text("Yes"),
              ),
            ],
          );
        },
      );
      return confirmation ?? false; // Return user's confirmation
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop, // Override the back button behavior
      child: Scaffold(
        appBar: customAppBar(
          title: 'Leave Policy',
          showActions: true,
          showLeading: false,
          context: context,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Total Pages: $totalPageCount'),
            IconButton(
              onPressed: () {
                pdfControllerPinch.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text('Current Page: $currentPage'),
            IconButton(
              onPressed: () {
                pdfControllerPinch.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ],
        ),
        _pdfView(),
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        scrollDirection: Axis.vertical,
        controller: pdfControllerPinch,
        onDocumentLoaded: (doc) {
          setState(() {
            totalPageCount = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
      ),
    );
  }
}


//       body: _buildUI(),
//     );
//   }
//
//   Widget _buildUI() {
//     return Column(
//       children: [
//         Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text('Total Pages ${totalPageCount}'),
//             IconButton(
//               onPressed: () {
//                 pdfControllerPinch.previousPage(
//                     duration: Duration(milliseconds: 500),
//                     curve: Curves.linear);
//               },
//               icon: Icon(Icons.arrow_back),
//             ),
//             Text('Current Page: ${currentPage}'),
//             IconButton(
//               onPressed: () {
//                 pdfControllerPinch.nextPage(
//                     duration: Duration(milliseconds: 500),
//                     curve: Curves.linear);
//               },
//               icon: Icon(Icons.arrow_forward),
//             ),
//           ],
//         ),
//         _pdfView(),
//       ],
//     );
//   }
//
//   Widget _pdfView() {
//     return Expanded(
//       child: PdfViewPinch(
//         scrollDirection: Axis.vertical,
//         controller: pdfControllerPinch,
//         onDocumentLoaded: (doc) {
//           setState(() {
//             totalPageCount = doc.pagesCount;
//           });
//         },
//         onPageChanged: (page) {
//           setState(() {
//             currentPage = page;
//           });
//         },
//       ),
//     );
//   }
// }

