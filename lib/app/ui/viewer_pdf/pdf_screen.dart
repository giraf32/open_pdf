 //import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
//import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PDFScreen extends StatefulWidget {
  final File? file;

  const PDFScreen({Key? key, this.file}) : super(key: key);


  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  // final Completer<PDFViewController> _controller =
  //     Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body:  PdfViewer.openFile(widget.file!.path),
      //body:  PdfViewer.openFile(widget.file!.path,params: PdfViewerParams(pageDecoration: BoxDecoration(color: Colors.cyanAccent))),

    );
  }
}
