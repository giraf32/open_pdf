import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/db_services_folder.dart';
import 'package:open_pdf/app/data/repository/folder_repository.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';

import '../../../utility/pdf_function.dart';
import '../../data/db_app/db_services_pdf.dart';
import '../../data/db_app/init_db.dart';

import '../../ui/widget/show_alert_dialog_pdf.dart';
import '../model/pdf_model.dart';

enum NotifierState { initial, loading, loaded }

class ProviderFolder extends ChangeNotifier {
  ProviderFolder();

  final _folderRepository = FolderRepository(dbServicesPdf: DbServicesPdf(InitDb.create()),
      dbServicesFolder: DbServicesFolder(InitDb.create()));

  NotifierState notifierState = NotifierState.initial;

  var listFolder = <FolderModel?>[];

  var listFolderByName = <PdfModel?>[];
  var _listFolderName = <String?>[];
  List<String?> getListFolderName() => _listFolderName;
  void setListFolderName(String value) {
    _listFolderName.add(value);
    notifyListeners();
  }

  Future<void> updateListFolder() async {
    try {
      notifierState = NotifierState.loading;

      listFolder = await _folderRepository.getListFolder();
    } catch (e, s) {
      print('Error updateListFolder: $e');
      print('Error updateListFolder: $s');
    }
    notifierState = NotifierState.loaded;
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

  Future<void> updateListFolderByName(String nameFolder) async {
    try {
      notifierState = NotifierState.loading;

      listFolderByName = await _folderRepository.getLisPdfModelByNameFolderFromDb(nameFolder: nameFolder);
    } catch (e, s) {
      print('Error updateListFolderByName: $e');
      print('Error updateListFolderByName: $s');
    }
    notifierState = NotifierState.loaded;
    notifyListeners();
  }

  Future<void> saveFileFolder(
      PdfModel pdfModel, BuildContext context) async {
    try {
      final listFolder =
      await _folderRepository.getLisFolderFromDb();

      if (listFolder.isNotEmpty) {
        final pdfListAddFolder = <PdfModel>[]..add(pdfModel);
        //TODO folder.name _compare
        final pdfModelClone = await comparePdfModel(
            listFirst: pdfListAddFolder, listSecond: listFolder);
        if (!context.mounted) return;
        if (pdfModelClone.isNotEmpty)
          await showAlertDialogPdf(context, pdfModelClone);
      }
      await _folderRepository.saveFileFolderAppStorage(pdfModel: pdfModel);
      await updateListFolder();
    } catch (e, s) {
      print('Error savePdfFavourites: $e');
      print('Error savePdfFavourites: $s');
    }
  }
}