import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:learnify/components/custom_text.dart';
import 'package:logger/logger.dart';

class PDFViewerScreen extends StatefulWidget {
  final String filePath;
  final String title;

  const PDFViewerScreen(
      {super.key, required this.filePath, required this.title});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages;
  int? currentPage;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RalewayText(
          text: widget.title,
          color: Colors.white,
          fWaight: FontWeight.bold,
          fontSize: 26,
        ),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.filePath,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: false,
            onRender: (pages) {
              setState(() {
                this.pages = pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              Logger().e(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              Logger().e('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text('Error: $errorMessage'),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.download,
          color: Colors.white,
        ),
      ),
    );
  }
}
