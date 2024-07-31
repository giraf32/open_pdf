import 'package:open_pdf/app/domain/db_api_folder.dart';
import 'package:open_pdf/app/domain/folder_api.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';

class FolderRepository implements FolderApi {
  final DbApiFolder dbServicesFolder;

  FolderRepository({required this.dbServicesFolder});

  @override
  Future<void> deleteFolder({required int? id}) async {
    await dbServicesFolder.deleteFolderDb(id: id);
  }

  @override
  Future<List<FolderModel?>> getListFolder() async {
    return await dbServicesFolder.getListFolderDb();
  }

  @override
  Future<void> insertFolder({required FolderModel folder}) async {
    await dbServicesFolder.insertFolderDb(folder: folder);
  }

  @override
  Future<void> updateFolder({required FolderModel folder}) async {
    await dbServicesFolder.updateFolderDb(folder: folder);
  }
}
