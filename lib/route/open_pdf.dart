import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_pdf/app/ui/viewer_pdf/pdf_screen.dart';

import '../app/ui/viewer_pdf/pdf_viewer_page.dart';

class OpenPdfViewer {
  void openPDFRoute(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)));
}

class OpenPdfScreen {
  void openPDFRoute(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PDFScreen(file: file)));
}
