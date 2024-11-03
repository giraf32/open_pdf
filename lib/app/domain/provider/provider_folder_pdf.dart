import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/data/repository/folder_pdf_repository.dart';

import '../../../utility/pdf_function.dart';
import '../../data/db_app/db_services_pdf.dart';
import '../../ui/widget/widget_pdf_file/show_alert_dialog_pdf.dart';
import '../model/pdf_model.dart';

enum NotifierStateListPdfFolder { initial, loading, loaded, getListAdd }

enum NotifierDeletePdfFolder { initial, deleting, deleted }

enum NotifierUpdatePdfFolder { initial, loading, loaded }

class ProviderFolderPdf extends ChangeNotifier {
  ProviderFolderPdf();

  final _pdfRepository =
      FolderPdfRepository(dbServicesPdf: DbServicesPdf(InitDb.create()));

  var listPdfFileByNameFolder = <PdfModel?>[];
  var listPdfAdd = <PdfModel?>[];
  var listPdfAddFolder = <PdfModel?>[];
  bool _isTextButton = false;

  bool get isTextButton => _isTextButton;

  void setTextButton(bool value) {
    _isTextButton = value;
    notifyListeners();
  }

  void setAddPdfListFolder(PdfModel pdfModel) {
    listPdfAddFolder.add(pdfModel);
    // notifyListeners();
  }
  void deletePdfListFolder(PdfModel pdfModel){
    int? id = pdfModel.id;
    listPdfAddFolder.removeWhere((pdfModel) => pdfModel?.id == id);
  }

  void clearListPdfAddFolder() {
    listPdfAddFolder.clear();
  }

  NotifierStateListPdfFolder _notifierStateListPdfFolder =
      NotifierStateListPdfFolder.initial;

  NotifierStateListPdfFolder get notifierStateListPdfFolder =>
      _notifierStateListPdfFolder;

  void setNotifierState(NotifierStateListPdfFolder state) {
    _notifierStateListPdfFolder = state;
    notifyListeners();
  }

  NotifierUpdatePdfFolder _notifierUpdatePdfFolder =
      NotifierUpdatePdfFolder.initial;

  NotifierUpdatePdfFolder get notifierUpdatePdfFolder =>
      _notifierUpdatePdfFolder;

  void _setNotifierUpdate(NotifierUpdatePdfFolder state) {
    _notifierUpdatePdfFolder = state;
    notifyListeners();
  }

  NotifierDeletePdfFolder notifierDeletePdfFolder =
      NotifierDeletePdfFolder.initial;

  Future<void> updateListFolderByName(String nameFolder) async {
    try {
      _setNotifierUpdate(NotifierUpdatePdfFolder.loading);
      //  await Future.delayed(Duration(seconds: 2));
      listPdfFileByNameFolder = await _pdfRepository
          .getLisPdfByNameFolderFromDb(nameFolder: nameFolder);
      print('print from updateListFolderByName : $listPdfFileByNameFolder');
    } catch (e, s) {
      print('Error updateListFolderByName: $e');
      print('Error updateListFolderByName: $s');
    }
    _setNotifierUpdate(NotifierUpdatePdfFolder.loaded);
    //notifyListeners();
  }

  Future<void> saveFileFolder(List<PdfModel?> listPdfModel,
      BuildContext context, String nameFolder) async {
    try {
     // setNotifierState(NotifierStateListPdfFolder.loading);
      //TODO notifierStateListPdfFolder
      print('nameFolderSaveFileFolder : $nameFolder');
      print('pdfModelSaveFileFolder : $listPdfModel');
      final listFolder = await _pdfRepository.getLisPdfByNameFolderFromDb(
          nameFolder: nameFolder);

      if (listFolder.isNotEmpty) {
        // final pdfListAddFolder = <PdfModel>[]..add(pdfModel);
        final pdfModelClone = await comparePdfModel(
            listFirst: listPdfModel, listSecond: listFolder);
        if (!context.mounted) return null;
        if (pdfModelClone.isNotEmpty)
          await showAlertDialogPdf(context, pdfModelClone);
      }

      await _pdfRepository.saveFileFolderAppStorage(
          listPdfModels: listPdfModel, nameFolder: nameFolder);
      await updateListFolderByName(nameFolder);
      //   .then((onValue){
      // if(onValue){
      //   print('isRecords2 = :::::::::::::::: $onValue');
      //   updateListFolderByName(nameFolder);
      // //  notifierStateListPdfFolder = NotifierStateListPdfFolder.loaded;
      // notifyListeners();
      // Duration(seconds: 3);

      // await Future.delayed(Duration(seconds: 2), () => updateListFolderByName(nameFolder));
     //  setNotifierState(NotifierStateListPdfFolder.loaded);
      //  context.router.replace(
      //      FolderPdfRoute(nameFolder: nameFolder));
      //  }
      // });

      //updateListFolderByName(nameFolder);
      // return isRecords;
      //  await updateListFolderByName(nameFolder);
    } catch (e, s) {
      print('Error savePdfFavourites: $e');
      print('Error savePdfFavourites: $s');
    }
    //  notifyListeners();
    // return isRecords;
  }

  Future<void> deletePdfFromFolder(String folder) async {
  //  notifierDeletePdfFolder = NotifierDeletePdfFolder.deleting;
    // notifyListeners();
    try {
      await _pdfRepository.deletePdfModelByNameFolderFromDb(nameFolder: folder);
    } catch (e, s) {
      print('Error deletePdfFolder: $e');
      print('Error deletePdfFolder: $s');
    }
  //  notifierDeletePdfFolder = NotifierDeletePdfFolder.initial;
    await updateListFolderByName(folder);
    // updatePdfListModelHistory();
  //  notifyListeners();
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

  Future<void> deleteFilePdf(PdfModel pdfModel) async {
    try {
      await _pdfRepository.deleteFilePdfAndModelDb(pdfModel: pdfModel);
      await updateListFolderByName(pdfModel.folder);
    } catch (e, s) {
      print('Error delete: $e');
      print('Error delete: $s');
    }
  }
  Future<void> updatePdfFolderModelDb(PdfModel newPdfModel) async {
    try {
      await _pdfRepository.updatePdfModelFolder(pdfModel: newPdfModel);
      await updateListFolderByName(newPdfModel.folder);
    } catch (e, s) {
      print('Error updatePdfNameFile: $e');
      print('Error updatePdfNameFile: $s');
    }
  }
}
