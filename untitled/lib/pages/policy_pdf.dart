import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:untitled/app_bar.dart';

class LeavePolicy extends StatefulWidget {
  const LeavePolicy({super.key});

  @override
  State<LeavePolicy> createState() => _LeavePolicyState();
}

class _LeavePolicyState extends State<LeavePolicy> {
  late PdfControllerPinch pdfControllerPinch;
  int totalPageCount = 0;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(
      document: PdfDocument.openAsset('assets/Files/D-sample.pdf'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: 'Leave Policy',
          showActions: true,
          showLeading: false,
          context: context),
      body: _buildUI(),
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
            Text('Total Pages ${totalPageCount}'),
            IconButton(
              onPressed: () {
                pdfControllerPinch.previousPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
              icon: Icon(Icons.arrow_back),
            ),
            Text('Current Page: ${currentPage}'),
            IconButton(
              onPressed: () {
                pdfControllerPinch.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
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
