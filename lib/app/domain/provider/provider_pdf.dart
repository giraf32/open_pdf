import 'dart:async';

import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/db_services_pdf.dart';
import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/data/repository/pdf_repository.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';

import '../../../utility/pdf_function.dart';
import '../../ui/widget/widget_pdf_file/show_alert_dialog_pdf.dart';


enum NotifierState { initial, loading, loaded }

enum NotifierStateListPdfFolder { initial, loading, loaded }

enum NotifierDeletePdfFolder { initial, deleting, deleted }

class ProviderPDF extends ChangeNotifier {
  ProviderPDF();

  NotifierState notifierState = NotifierState.initial;
  NotifierStateListPdfFolder notifierStateListPdfFolder =
      NotifierStateListPdfFolder.initial;
  NotifierDeletePdfFolder notifierDeletePdfFolder =
      NotifierDeletePdfFolder.initial;

  final _pdfRepository =
      PdfRepository(dbServicesPdf: DbServicesPdf(InitDb.create()));
  var pdfModelListHistory = <PdfModel?>[];
 // var pdfListFavourites = <PdfModel?>[];
  var listPdfFileByNameFolder = <PdfModel?>[];
  var listPdfAdd = <PdfModel?>[];

  void setPdfAdd(PdfModel pdfModel){
    listPdfAdd.add(pdfModel);
   // notifyListeners();
  }
  void clearListPdfAdd(){
    listPdfAdd.clear();
  }
  //----------folder------------
  Future<void> updateListFolderByName(String nameFolder) async {
    try {
      notifierStateListPdfFolder = NotifierStateListPdfFolder.loading;

      listPdfFileByNameFolder = await _pdfRepository
          .getLisPdfByNameFolderFromDb(nameFolder: nameFolder);
    } catch (e, s) {
      print('Error updateListFolderByName: $e');
      print('Error updateListFolderByName: $s');
    }
    notifierStateListPdfFolder = NotifierStateListPdfFolder.loaded;
    notifyListeners();
  }

  Future<void> saveFileFolder(
    List<PdfModel?> listPdfModel, BuildContext context, String nameFolder) async {
    try {
      print('nameFolderSaveFileFolder : $nameFolder');
      print('pdfModelSaveFileFolder : $listPdfModel');
      final listFolder = await _pdfRepository.getLisPdfByNameFolderFromDb(
          nameFolder: nameFolder);

      if (listFolder.isNotEmpty) {
       // final pdfListAddFolder = <PdfModel>[]..add(pdfModel);
        final pdfModelClone = await comparePdfModel(
            listFirst:listPdfModel, listSecond: listFolder);
        if (!context.mounted) return;
        if (pdfModelClone.isNotEmpty)
          await showAlertDialogPdf(context, pdfModelClone);
      }
      await _pdfRepository.saveFileFolderAppStorage(
          listPdfModels: listPdfModel, nameFolder: nameFolder);
      await updateListFolderByName(nameFolder);
    } catch (e, s) {
      print('Error savePdfFavourites: $e');
      print('Error savePdfFavourites: $s');
    }
  }

  Future<void> deletePdfFromFolder(String folder) async {
    notifierDeletePdfFolder = NotifierDeletePdfFolder.deleting;
    // notifyListeners();
    try {
      await _pdfRepository.deletePdfModelByNameFolderFromDb(nameFolder: folder);

    } catch (e, s) {
      print('Error deletePdfFolder: $e');
      print('Error deletePdfFolder: $s');
    }
    notifierDeletePdfFolder = NotifierDeletePdfFolder.initial;
    await updateListFolderByName(folder);
    // updatePdfListModelHistory();
    notifyListeners();
  }

  Future<void> changeFolder(
      {required String nameFolder, required String newNameFolder}) async {
    try {
      await _pdfRepository.changeNameFolder(
          nameFolder: nameFolder, newNameFolder: newNameFolder);
    } catch (e, s) {
      print('Error changePdfFolder: $e');
      print('Error changePdfFolder: $s');
    }
  //  await updateListFolderByName(newNameFolder);
  //  notifyListeners();
  }

//-------------------------------------

  bool changeMenuItemFavourites = false;

  Future<void> addListPdfFileFromDeviceStorage(BuildContext context) async {
    try {
      notifierState = NotifierState.loading;
      final listPdfModelsStorage =
          await _pdfRepository.getPdfListDeviceStorage();

      if (listPdfModelsStorage == null) {
        notifierState = NotifierState.loaded;
        notifyListeners();
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
      await updateListFolderByName(pdfModel.folder);
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

  Future<void> updatePdfModelDb(PdfModel newPdfModel) async {
    try {
      await _pdfRepository.updatePdfModel(pdfModel: newPdfModel);
      // await updatePDFListModelFavourites();
      await updatePdfListModelHistory();
    } catch (e, s) {
      print('Error updatePdfNameFile: $e');
      print('Error updatePdfNameFile: $s');
    }
  }
}
