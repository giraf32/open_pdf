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
      final listPdfModelsStorage = await _pdfRepository.getPdfListDeviceStorage();

      if (listPdfModelsStorage == null) {
        notifierState = NotifierState.loaded;
        notifyListeners();
        return;
      }
      final pdfListModelDb =
          await _pdfRepository.getPdfListModelFromDbHistory();

      final pdfModelClone =  _comparePdfModel(
          listFirst: listPdfModelsStorage, listSecond: pdfListModelDb);
      if (!context.mounted) return;
      if (pdfModelClone.isNotEmpty) await showAlertDialogPdf(context, pdfModelClone);
      await _pdfRepository.insertDbListPdfModel(
          listPdfModels: listPdfModelsStorage);

      await updatePdfListModelHistory();
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

  Future<void> deleteFilePdfAfterCompare(List<PdfModel?> listPdf) async {
    try {
      //TODO await here maybe excess
      if (listPdf.isNotEmpty)
        await {
          listPdf.forEach((element) {
            _pdfRepository.deleteFilePdfAndModelDb(pdfModel: element!);
          })
        };
     // await updatePdfListModelHistory();
     // await updatePDFListModelFavourites();
    } catch (e, s) {
      print('Error delete after compare: $e');
      print('Error delete after compare: $s');
    }
  }

  Future<void> updatePdfListModelHistory() async {
    try {
      notifierState = NotifierState.loading;

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
    try {
      notifierState = NotifierState.loading;

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

  List<PdfModel?> _comparePdfModel(
      {required List<PdfModel> listFirst,
      required List<PdfModel> listSecond})  {
    var list = <PdfModel?>[];

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
