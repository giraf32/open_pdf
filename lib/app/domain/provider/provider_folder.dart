import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/db_services_folder.dart';
import 'package:open_pdf/app/data/repository/folder_repository.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';

import '../../data/db_app/init_db.dart';

enum NotifierStateFolder { initial, loading, loaded }

class ProviderFolder extends ChangeNotifier {
  ProviderFolder();

  final _folderRepository =
      FolderRepository(dbServicesFolder: DbServicesFolder(InitDb.create()));

  NotifierStateFolder notifierStateFolder = NotifierStateFolder.initial;

  var listFolder = <FolderModel?>[];
  var _listFolderName = <String?>[];

  List<String?> getListFolderName() => _listFolderName;

  void setListFolderName(String value) {
    _listFolderName.add(value);
    notifyListeners();
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
}
