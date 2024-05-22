import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/db_services.dart';
import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/data/repository/pdf_repository.dart';
import 'package:open_pdf/app/domain/model/model_pdf.dart';

import 'package:open_pdf/route/open_pdf.dart';

enum NotifierState { initial, loading, loaded }

class ProviderPDF extends ChangeNotifier {
  ProviderPDF();

  NotifierState notifierState = NotifierState.initial;
  final _pdfRepository = PdfRepository(dbServices: DbServices(InitDb.create()));
  var pdfModelList = <PDFModel?>[];
  var pdfListFavourites = <PDFModel?>[];
//  bool changeOpenPdf = true;
  bool changeMenuItemFavourites = false;

  int? pages = 0;

  setPages(int? value) {
    pages = value;
    notifyListeners();
  }

  int currentPage = 0;


  Future<void> addAndOpenPdf(BuildContext context) async {
    try {
      notifierState = NotifierState.loading;
       await _pdfRepository.addFilePDF().then((file) {
        if (file == null) return;
        if (!context.mounted) return;
        //  print('ChangeOpenPDF = $changeOpenPdf');
        //  changeOpenPdf
        OpenPdfRx().openPDFRoute(context, file);
      });

     // OpenPdfViewer().openPDFRoute(context, file);
      updatePDFListModel();
    } catch (e,s) {
      print('Error addOpenPdf: $e');
      print('Error addOpenPdf: $s');
    }
  }

  Future<void> deleteFilePdf(PDFModel pdfModel) async {
    try {
      await _pdfRepository.deleteFilePDF(pdfModel: pdfModel);
      await updatePDFListModel();
      await updatePDFListModelFavourites();
    } catch (e,s) {
      print('Error delete: $e');
      print('Error delete: $s');
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
      // print('listLocalPdf 0 $localListPdf');
    } catch (e,s) {
      print('Error updatePdfList: $e');
      print('Error updatePdfList: $s');
    }
    notifierState = NotifierState.loaded;
    notifyListeners();
  }

  Future<void> updatePDFListModelFavourites() async {
    var localFavourites = <PDFModel?>[];
    try {
      notifierState = NotifierState.loading;
      await _pdfRepository.getPDFListModel().then((value) {
        value.map((e) {
          if (e.favourites == 1) {
            localFavourites.add(e);
          }
        }).toList();
        pdfListFavourites = localFavourites;
        print('localFavourites = $pdfListFavourites');
        notifierState = NotifierState.loaded;
        notifyListeners();
      });
    } catch (e,s) {
      print('Error updatePdfListModelFavourites: $e');
      print('Error updatePdfListModelFavourites: $s');
    }
  }

  Future<void> savePdfFavourites(PDFModel pdfModel) async {
    try {
      await _pdfRepository.savePdfFavourites(pdfModel: pdfModel);
      await updatePDFListModelFavourites();
      await updatePDFListModel();
    } catch (e,s) {
      print('Error savePdfFavourites: $e');
      print('Error savePdfFavourites: $s');
    }
  }

  Future<void> updatePdfNameFile(PDFModel newPdfModel) async {
    try {
      await _pdfRepository.updatePdfModel(pdfModel: newPdfModel);
      await updatePDFListModelFavourites();
      await updatePDFListModel();
    } catch (e,s) {
      print('Error updatePdfNameFile: $e');
      print('Error updatePdfNameFile: $s');
    }
  }
}
