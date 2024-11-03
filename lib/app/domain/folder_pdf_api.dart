import 'model/pdf_model.dart';

abstract class FolderPdfApi {
  Future<List<PdfModel?>> getLisPdfByNameFolderFromDb(
      {required String nameFolder});

  Future<bool> saveFileFolderAppStorage(
      {required List<PdfModel?> listPdfModels, required String nameFolder});

  Future<void> deletePdfModelByNameFolderFromDb({required String nameFolder});

  Future<void> changeNameFolder(
      {required String nameFolder, required String newNameFolder});

  Future<void> deleteFilePdfAndModelDb({required PdfModel pdfModel});

  Future<void> updatePdfModelFolder({required PdfModel pdfModel});
}
