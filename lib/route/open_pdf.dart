import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_pdf/app/ui/page/favourites_page.dart';
import 'package:open_pdf/app/ui/page/folder_page.dart';
import 'package:open_pdf/app/ui/page/history_page_pdf.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/folder_pdf_list.dart';
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
      MaterialPageRoute(builder: (context) => HistoryPagePdf(title: 'Home')));
}
class OpenFolder {
  void openPDFRoute(BuildContext context) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => FolderPage()));
}
class OpenListPdfFolder {
  void openPDFRoute(BuildContext context, String nameFolder) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => FolderPdfList(nameFolder: nameFolder)));
}