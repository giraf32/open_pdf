import 'package:open_pdf/app/domain/model/folder_model.dart';

import 'model/pdf_model.dart';

abstract class FolderApi{
  Future<List<PdfModel>> getLisPdfModelByNameFolderFromDb({required String nameFolder});
  Future<List<PdfModel>> getLisFolderFromDb(String nameFolder);
  Future<void> saveFileFolderAppStorage({required PdfModel pdfModel,required FolderModel folder});
  Future<void> insertFolder({required FolderModel folder});
  Future<void> updateFolder({required FolderModel folder});
  Future<List<FolderModel?>> getListFolder();
  Future<void> deleteFolder({required int? id});

}