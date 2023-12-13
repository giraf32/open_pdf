import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/db_services.dart';
import 'package:open_pdf/app/data/repository/pdf_repository.dart';
import 'package:open_pdf/app/domain/model/model_pdf.dart';
import 'package:open_pdf/route/open_pdf.dart';

enum NotifierState { initial, loading, loaded }

class ProviderPDF extends ChangeNotifier {
  ProviderPDF();

  NotifierState notifierState = NotifierState.initial;

  final _pdfRepository = PdfRepository(dbServices: DbServices.db);
  var pdfModelList = <PDFModel?>[];

  var pdfListFavourites = <PDFModel?>[];
  bool changeOpenPdf = true;
  bool changeMenuItemFavourites = false;


  Future<void> addAndOpenPdf(BuildContext context) async {
    try {
      notifierState = NotifierState.loading;
      final file = await _pdfRepository.addFilePDF();
      if (file == null) return;
      if (!context.mounted) return;
      print('ChangeOpenPDF = $changeOpenPdf');
     changeOpenPdf ? OpenPdfViewer().openPDFRoute(context, file): OpenPdfScreen().openPDFRoute(context, file);
      updatePDFListModel();
    } catch (e) {
      Error();
    }
  }

  Future<void> deleteFilePdf(PDFModel pdfModel) async {
    try {
      await _pdfRepository.deleteFilePDF(pdfModel: pdfModel);
      await updatePDFListModel();
      await updatePDFListModelFavourites();
    } catch (e) {
      Error();
    }
  }

  Future<void> deleteDbModelPdf(PDFModel pdfModel) async {
    try {
      final pdfList = await _pdfRepository.getPDFListModel();
      if (pdfList.isNotEmpty) {}

      await _pdfRepository.deleteDbPdfModel(pdfModel: pdfModel);
      await updatePDFListModel();
      // await updatePDFListModelFavourites();
    } catch (e) {
      Error();
    }
  }

  Future<void> updatePDFListModel() async {
    var localListPdf = <PDFModel?>[];
    try {
      notifierState = NotifierState.loading;
      await _pdfRepository.getPDFListModel().then((value) {
        value.map((e) {
          if (e.favourites == 0) {
            var file = File(e.path);
            if (!file.existsSync()) {
              _pdfRepository.deleteDbPdfModel(pdfModel: e);
            } else {
              localListPdf.add(e);
            }
          }
        }).toList();
      });
      pdfModelList = localListPdf;
      print('listLocalPdf 0 $localListPdf');
    } catch (e) {
      Error();
    }
    //_pdfModelList = localListPdf;
    print('listLocalPdf 3 $localListPdf');
    print('pdfModelList 4 $pdfModelList');
    notifierState = NotifierState.loaded;
    notifyListeners();
  }

  Future<void> updatePDFListModelFavourites() async {
    var localFavourites = <PDFModel?>[];
    try {
      notifierState = NotifierState.loading;
      await _pdfRepository.getPDFListModel().then((value) {
        value.map((e) {
          //  final file = File(e.path);
          if (e.favourites == 1) {
            // if (await file.exists()) {
            localFavourites.add(e);
            // } else {
            //   _pdfRepository.deleteDbPdfModel(pdfModel: e);
            // }
          }
        }).toList();
        pdfListFavourites = localFavourites;
        print('localFavourites = $pdfListFavourites');
        notifierState = NotifierState.loaded;
        notifyListeners();
      });
    } catch (e) {
      Error();
    }
  }

  Future<void> savePdfFavourites(PDFModel pdfModel) async {
    try {
      await _pdfRepository.savePdfFavourites(pdfModel: pdfModel);
      await updatePDFListModelFavourites();
      await updatePDFListModel();
    } catch (e) {
      Error();
    }
  }

  Future<void> updatePdfNameFile(PDFModel newPdfModel) async {
    try {
      await _pdfRepository.updatePdfModel(pdfModel: newPdfModel);
      await updatePDFListModelFavourites();
      await updatePDFListModel();
    } catch (e) {
      Error().stackTrace;
    }
  }
// Future<void> getDirectory() async {
//   try{
//      await _pdfRepository.getDirectory();
//      updatePDFListFile();
//   } catch (e){
//     Error();
//   }
// }
}
