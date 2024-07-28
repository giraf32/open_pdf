import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/db_services_folder.dart';
import 'package:open_pdf/app/data/repository/folder_repository.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';

import '../../../utility/pdf_function.dart';
import '../../data/db_app/db_services_pdf.dart';
import '../../data/db_app/init_db.dart';

import '../../ui/widget/widget_pdf_file/show_alert_dialog_pdf.dart';
import '../model/pdf_model.dart';

enum NotifierStateFolder { initial, loading, loaded }
enum NotifierStateListPdfFolder { initial, loading, loaded }
enum NotifierStateTab { show, add, menu }

class ProviderFolder extends ChangeNotifier {
  ProviderFolder();

  final _folderRepository = FolderRepository(dbServicesPdf: DbServicesPdf(InitDb.create()),
      dbServicesFolder: DbServicesFolder(InitDb.create()));



  NotifierStateFolder notifierStateFolder = NotifierStateFolder.initial;
  NotifierStateListPdfFolder notifierStateListPdfFolder = NotifierStateListPdfFolder.initial;
  NotifierStateTab notifierStateTab = NotifierStateTab.show;

  var listFolder = <FolderModel?>[];
  var listPdfFileByNameFolder = <PdfModel?>[];


  var _listFolderName = <String?>[];
  List<String?> getListFolderName() => _listFolderName;
  void setListFolderName(String value) {
    _listFolderName.add(value);
    notifyListeners();
  }

  void setNotifierStateTab (String state){
    switch(state){
      case 'show': notifierStateTab = NotifierStateTab.show;
      case 'add': notifierStateTab = NotifierStateTab.add;
      case 'menu': notifierStateTab = NotifierStateTab.menu;
    }
  }

  Future<void> updateListFolder() async {
    try {
      notifierStateFolder = NotifierStateFolder.loading;

      listFolder = await _folderRepository.getListFolder();
    } catch (e, s) {
      print('Error updateListFolder: $e');
      print('Error updateListFolder: $s');
    }
    notifierStateFolder = NotifierStateFolder.loaded;
    notifyListeners();
  }

  Future<void> saveFolder(FolderModel folder) async {
    try {
      await _folderRepository.insertFolder(folder: folder);
    } catch (e, s) {
      print('Error saveFolder: $e');
      print('Error saveFolder: $s');
    }
    updateListFolder();
  }
  Future<void> deleteFolder(int id) async {
    try {
      await _folderRepository.deleteFolder(id: id);
      // TODO delete and in pdfRepository
    } catch (e, s) {
      print('Error deleteFolder: $e');
      print('Error deleteFolder: $s');
    }
    updateListFolder();
  }
  Future<void> updateFolder(FolderModel folder) async {
    try {
      await _folderRepository.updateFolder(folder: folder);
    } catch (e, s) {
      print('Error updateFolder: $e');
      print('Error updateFolder: $s');
    }
    updateListFolder();
  }
//----------------------- on File Folder -------------
  Future<void> updateListFolderByName(String nameFolder) async {
    try {
      notifierStateListPdfFolder = NotifierStateListPdfFolder.loading;

      listPdfFileByNameFolder = await _folderRepository.getLisPdfModelByNameFolderFromDb(nameFolder: nameFolder);
    } catch (e, s) {
      print('Error updateListFolderByName: $e');
      print('Error updateListFolderByName: $s');
    }
    notifierStateListPdfFolder = NotifierStateListPdfFolder.loaded;
    notifyListeners();
  }

  Future<void> saveFileFolder(
      PdfModel pdfModel, BuildContext context, FolderModel folderModel) async {
    try {
      print('nameFolder : $folderModel');
      print('pdfModel : $pdfModel');
      final listFolder =
      await _folderRepository.getLisPdfModelByNameFolderFromDb(nameFolder: folderModel.nameFolder);

      if (listFolder.isNotEmpty) {
        final pdfListAddFolder = <PdfModel>[]..add(pdfModel);
        //TODO folder.name _compare
        final pdfModelClone = await comparePdfModel(
            listFirst: pdfListAddFolder, listSecond: listFolder);
        if (!context.mounted) return;
        if (pdfModelClone.isNotEmpty)
          await showAlertDialogPdf(context, pdfModelClone);
      }
      await _folderRepository.saveFileFolderAppStorage(pdfModel: pdfModel, folder: folderModel);
      await updateListFolderByName(folderModel.nameFolder);
    } catch (e, s) {
      print('Error savePdfFavourites: $e');
      print('Error savePdfFavourites: $s');
    }
  }
}