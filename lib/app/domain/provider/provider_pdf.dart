import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_pdf/app/data/db_app/db_services.dart';
import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/data/repository/pdf_repository.dart';
import 'package:open_pdf/app/domain/model/model_pdf.dart';

import '../../ui/widget/show_alert_dialog_pdf.dart';

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
      final listPdfModelsStorage = await _pdfRepository.getPdfListStorage();
      if (listPdfModelsStorage == null) return;
      final pdfModelClone = await comparePdfModel(listPdfModelsStorage);
      if (!context.mounted) return;
      if (pdfModelClone.isNotEmpty) showAlertDialogPdf(context, pdfModelClone);
      await _pdfRepository.insertDbListPdfModel(
          listPdfModels: listPdfModelsStorage);
      // if (listPdfModels.length < 2) {
      //   print('Выбран один файл');
      //
      //  final path = listPdfModels.first.path;
      //        final file = File(path);
      //   showAlertDialogOpenPdf(context, file);
      // } else {
      //   print('Выбран list файл');
      // }
      // listPdfModels.sort();
      //  print('ChangeOpenPDF = $changeOpenPdf');
      //  changeOpenPdf
      //  OpenPdfRx().openPDFRoute(context, file);

      // OpenPdfViewer().openPDFRoute(context, file);
      updatePDFListModel();
    } catch (e, s) {
      print('Error addOpenPdf: $e');
      print('Error addOpenPdf: $s');
    }
  }

  Future<void> deleteFilePdf(PDFModel pdfModel) async {
    try {
      await _pdfRepository.deleteFilePDF(pdfModel: pdfModel);
      await updatePDFListModel();
      await updatePDFListModelFavourites();
    } catch (e, s) {
      print('Error delete: $e');
      print('Error delete: $s');
    }
  }

  Future<void> updatePDFListModel() async {
    var localListPdf = <PDFModel>[];
    // var formatter = DateFormat();
    try {
      notifierState = NotifierState.loading;
      await _pdfRepository.getPdfListModelFromDb().then((value) {
        value.map((e) {
          if (e.favourites == 0) {
            final id = e.id;
            print('id = $id');
            var file = File(e.path);
            if (!file.existsSync()) {
              _pdfRepository.deleteDbPdfModel(pdfModel: e);
            } else {
              localListPdf.add(e);
            }
          }
        }).toList();
      });
      // if (localListPdf.length > 1) {
      //   await sortListPdf(localListPdf);
      //   pdfModelList = localListPdf;
      // } else {
      //   pdfModelList = localListPdf;
      // }
      pdfModelList = localListPdf;

      // print('listLocalPdf 0 $localListPdf');
    } catch (e, s) {
      print('Error updatePdfList: $e');
      print('Error updatePdfList: $s');
    }
    notifierState = NotifierState.loaded;
    notifyListeners();
  }

  Future<void> updatePDFListModelFavourites() async {
    var localFavourites = <PDFModel>[];
    try {
      notifierState = NotifierState.loading;
      await _pdfRepository.getPdfListModelFromDb().then((value) {
        value.map((e) {
          if (e.favourites == 1) {
            localFavourites.add(e);
          }
        }).toList();
      });
      // if (localFavourites.length > 1) {
      //   await sortListPdf(localFavourites);
      //   pdfListFavourites = localFavourites;
      // } else {
      //   pdfListFavourites = localFavourites;
      // }
      pdfListFavourites = localFavourites;
      print('localFavourites = $pdfListFavourites');
      notifierState = NotifierState.loaded;
      notifyListeners();
    } catch (e, s) {
      print('Error updatePdfListModelFavourites: $e');
      print('Error updatePdfListModelFavourites: $s');
    }
  }

  Future<void> savePdfFavourites(PDFModel pdfModel) async {
    try {
      await _pdfRepository.savePdfFavourites(pdfModel: pdfModel);
      await updatePDFListModelFavourites();
      await updatePDFListModel();
    } catch (e, s) {
      print('Error savePdfFavourites: $e');
      print('Error savePdfFavourites: $s');
    }
  }

  Future<void> updatePdfNameFile(PDFModel newPdfModel) async {
    try {
      await _pdfRepository.updatePdfModel(pdfModel: newPdfModel);
      await updatePDFListModelFavourites();
      await updatePDFListModel();
    } catch (e, s) {
      print('Error updatePdfNameFile: $e');
      print('Error updatePdfNameFile: $s');
    }
  }

  Future<List<PDFModel>> sortListPdf(List<PDFModel> list) async {
    final DateFormat formatter = DateFormat.yMd().add_Hms();

    bool Sorted = false;
    while (!Sorted) {
      Sorted = true;
      for (int i = 1; list.length > i; i++) {
        var dateTimeFirst = formatter.parse(list[i - 1].dateTime!);
        var dateTimeSecond = formatter.parse(list[i].dateTime!);
        if (dateTimeFirst.isBefore(dateTimeSecond)) {
          var tmp = list[i];
          list[i] = list[i - 1];
          list[i - 1] = tmp;
          Sorted = false;
        }

      }
    }

    return list;
  }

  Future<List<PDFModel?>> comparePdfModel(
      List<PDFModel> listPdfModelStorage) async {
    var list = <PDFModel?>[];
    final pdfListModelDb = await _pdfRepository.getPdfListModelFromDb();
    //print('Compare2 : $listPdfModelStorage');
    listPdfModelStorage.forEach((modelStorage) {
      pdfListModelDb.forEach((modelDb) {
        if (modelDb.name == modelStorage.name) {
          list.add(modelDb);
        }
      });
    });
    print('ListTest: $list');

    return list;
  }
}
