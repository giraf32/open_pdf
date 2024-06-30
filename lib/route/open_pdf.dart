import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_pdf/app/ui/page/favourites_page.dart';
import 'package:open_pdf/app/ui/page/home_page_pdf.dart';
import '../app/ui/viewer_pdf/pdf_rx.dart';

class OpenPdfRx {
  void openPDFRoute(BuildContext context, File file , String name) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => PdfRx(file: file, name: name,)));
}

class OpenPdfScreenFavourites {
  void openPDFRoute(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FavouritesPage(title: 'Favourites')));
}

class OpenPdfScreenHome {
  void openPDFRoute(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => HomePagePdf(title: 'Home')));
}
