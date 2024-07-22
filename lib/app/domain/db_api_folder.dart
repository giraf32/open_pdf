import 'package:open_pdf/app/domain/model/folder_model.dart';

abstract class DbApiFolder{

  Future<void> insertFolderDb({ required FolderModel folder});
  Future<void> updateFolderDb({ required FolderModel folder});
  Future<List<FolderModel?>> getListFolderDb();
  Future<void> deleteFolderDb({required int? id});

}