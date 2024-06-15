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
  var pdfModelListHistory = <PdfModel?>[];
  var pdfListFavourites = <PdfModel?>[];

//  bool changeOpenPdf = true;
  bool changeMenuItemFavourites = false;

  int? pages = 0;

  setPages(int? value) {
    pages = value;
    notifyListeners();
  }

  int currentPage = 0;

  Future<void> addListFilePdfFromStorage(BuildContext context) async {
    try {
      notifierState = NotifierState.loading;
      final listPdfModelsStorage = await _pdfRepository.getPdfListStorage();

      if (listPdfModelsStorage == null) {
        notifierState = NotifierState.loaded;
        notifyListeners();
        return;
      }
      final pdfListModelDb =
          await _pdfRepository.getPdfListModelFromDbHistory();

      final pdfModelClone = await _comparePdfModel(
          listFirst: listPdfModelsStorage, listSecond: pdfListModelDb);
      if (!context.mounted) return;
      if (pdfModelClone.isNotEmpty) showAlertDialogPdf(context, pdfModelClone);
      await _pdfRepository.insertDbListPdfModel(
          listPdfModels: listPdfModelsStorage);
      //----------------------------------------------------------------------------------
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
      updatePdfListModelHistory();
    } catch (e, s) {
      print('Error addOpenPdf: $e');
      print('Error addOpenPdf: $s');
    }
  }

  Future<void> deleteFilePdf(PdfModel pdfModel) async {
    try {
      await _pdfRepository.deleteFilePdfAndModelDb(pdfModel: pdfModel);
      await updatePdfListModelHistory();
      await updatePDFListModelFavourites();
    } catch (e, s) {
      print('Error delete: $e');
      print('Error delete: $s');
    }
  }

  Future<void> updatePdfListModelHistory() async {
    try {
      notifierState = NotifierState.loading;
      // if (localListPdf.length > 1) {
      //   await sortListPdf(localListPdf);
      //   pdfModelList = localListPdf;
      // } else {
      //   pdfModelList = localListPdf;
      // }
      // pdfModelList = localListPdf;
      pdfModelListHistory = await _pdfRepository.getPdfListModelFromDbHistory();

      // print('listLocalPdf 0 $localListPdf');
    } catch (e, s) {
      print('Error updatePdfList: $e');
      print('Error updatePdfList: $s');
    }
    notifierState = NotifierState.loaded;
    notifyListeners();
  }

  Future<void> updatePDFListModelFavourites() async {
    // var localFavourites = <PDFModel>[];
    try {
      notifierState = NotifierState.loading;
      // if (localFavourites.length > 1) {
      //   await _sortListPdf(localFavourites);
      //   pdfListFavourites = localFavourites;
      // } else {
      //   pdfListFavourites = localFavourites;
      // }
      //pdfListFavourites = localFavourites;
      pdfListFavourites = await _pdfRepository.getPdfListModelFromDbFavorite();
      print('localFavourites = $pdfListFavourites');
      notifierState = NotifierState.loaded;
      notifyListeners();
    } catch (e, s) {
      print('Error updatePdfListModelFavourites: $e');
      print('Error updatePdfListModelFavourites: $s');
    }
  }

  Future<void> savePdfFavourites(
      PdfModel pdfModel, BuildContext context) async {
    try {
      final pdfListFavorites =
          await _pdfRepository.getPdfListModelFromDbFavorite();

      if (pdfListFavorites.isNotEmpty) {
        final pdfListAddFavorites = <PdfModel>[]..add(pdfModel);
        final pdfModelClone = await _comparePdfModel(
            listFirst: pdfListAddFavorites, listSecond: pdfListFavorites);
        if (!context.mounted) return;
        if (pdfModelClone.isNotEmpty)
        await showAlertDialogPdf(context, pdfModelClone);
      }
      await _pdfRepository.savePdfModelFavouritesAppStorage(pdfModel: pdfModel);
      await updatePDFListModelFavourites();
      await updatePdfListModelHistory();
    } catch (e, s) {
      print('Error savePdfFavourites: $e');
      print('Error savePdfFavourites: $s');
    }
  }

  Future<void> updatePdfNameFile(PdfModel newPdfModel) async {
    try {
      await _pdfRepository.updatePdfModel(pdfModel: newPdfModel);
      await updatePDFListModelFavourites();
      await updatePdfListModelHistory();
    } catch (e, s) {
      print('Error updatePdfNameFile: $e');
      print('Error updatePdfNameFile: $s');
    }
  }

  Future<List<PdfModel>> _sortListPdf(List<PdfModel> list) async {
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

  Future<List<PdfModel?>> _comparePdfModel(
      {required List<PdfModel> listFirst,
      required List<PdfModel> listSecond}) async {
    var list = <PdfModel?>[];

    //print('Compare2 : $listPdfModelStorage');
    listFirst.forEach((modelFirst) {
      listSecond.forEach((modelSecond) {
        if (modelSecond.name == modelFirst.name) {
          list.add(modelSecond);
        }
      });
    });
    print('ListTest: $list');

    return list;
  }
}
