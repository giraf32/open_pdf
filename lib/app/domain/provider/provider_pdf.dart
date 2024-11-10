import 'dart:async';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/db_services_pdf.dart';
import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/data/repository/pdf_repository.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import '../../../utility/pdf_function.dart';
import '../../ui/widget/widget_pdf_file/show_alert_dialog_pdf.dart';

enum NotifierState { initial, loading, loaded }



//enum NotifierStateListAddPdfFolder { initial, loading, loaded }



class ProviderPDF extends ChangeNotifier {
  ProviderPDF();

  NotifierState _notifierState = NotifierState.initial;

  NotifierState get notifierState => _notifierState;

  void _setNotifierState(NotifierState state) {
    _notifierState = state;
    notifyListeners();
  }

  final _pdfRepository =
      PdfRepository(dbServicesPdf: DbServicesPdf(InitDb.create()));
  var pdfModelListHistory = <PdfModel?>[];

  bool changeMenuItemFavourites = false;

  Future<void> addListPdfFileFromDeviceStorage(BuildContext context) async {
    try {
    // _setNotifierState(NotifierState.loading);
      final listPdfModelsStorage =
          await _pdfRepository.getPdfListDeviceStorage();

      if (listPdfModelsStorage == null) {
        _setNotifierState(NotifierState.loaded);
        return;
      }
      final pdfListModelDb =
          await _pdfRepository.getPdfListModelFromDbHistory();

      final pdfModelClone = comparePdfModel(
          listFirst: listPdfModelsStorage, listSecond: pdfListModelDb);
      if (!context.mounted) return;
      if (pdfModelClone.isNotEmpty)
        await showAlertDialogPdf(context, pdfModelClone);
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
    //  _setNotifierState(NotifierState.loading);

      pdfModelListHistory = await _pdfRepository.getPdfListModelFromDbHistory();

      // print('listLocalPdf 0 $localListPdf');
    } catch (e, s) {
      print('Error updatePdfList: $e');
      print('Error updatePdfList: $s');
    }
   // _setNotifierState(NotifierState.loaded);
    notifyListeners();
  }

  Future<void> updatePdfModelDb(PdfModel newPdfModel) async {
    try {
      await _pdfRepository.updatePdfModel(pdfModel: newPdfModel);
      await updatePdfListModelHistory();
    } catch (e, s) {
      print('Error updatePdfNameFile: $e');
      print('Error updatePdfNameFile: $s');
    }
  }
  Future<int?> getPageNumber (PdfModel pdfModel) async {
    int? _pageNumber;
    try {
     _pageNumber = await _pdfRepository.getNumberPages(pdfModel: pdfModel);

    } catch (e, s) {
      print('Error getPageNumber: $e');
      print('Error getPageNumber: $s');
    }
    return _pageNumber;
  }
  Future<void> updatePageNumber (int pageNumber,PdfModel pdfModel) async {
    try {
      final newPdfModel = pdfModel.copyWith(pageNumber: pageNumber);
      await _pdfRepository.updatePdfModel(pdfModel: newPdfModel);

    } catch (e, s) {
      print('Error updatePageNumber: $e');
      print('Error updatePageNumber: $s');
    }

  }
}
