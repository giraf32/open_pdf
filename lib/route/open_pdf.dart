import 'dart:io';

import 'package:flutter/material.dart';

import 'package:open_pdf/app/ui/viewer_pdf/pdf_render.dart';

import '../app/ui/viewer_pdf/pdf_rx.dart';
import '../app/ui/viewer_pdf/pdf_viewer_page.dart';

class OpenPdfViewer {
  void openPDFRoute(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)));
}

class OpenPdfRender {
  void openPDFRoute(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PdfRender(file: file)));
}

class OpenPdfRx {
  void openPDFRoute(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PdfRx(file: file)));
}
