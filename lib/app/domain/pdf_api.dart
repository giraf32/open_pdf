
import 'package:open_pdf/app/domain/model/pdf_model.dart';

import 'model/folder_model.dart';

abstract class PdfApi {

  Future<void> insertDbListPdfModel({required List<PdfModel> listPdfModels});
  Future<void> deleteFilePdfAndModelDb({required PdfModel pdfModel});
  Future<List<PdfModel>> getPdfListModelFromDbHistory();
  Future<void> updatePdfModel({required PdfModel pdfModel});
  Future<List<PdfModel>?> getPdfListDeviceStorage();
  Future<void> deleteDbPdfModel({required PdfModel pdfModel});
  Future<List<PdfModel>> getLisPdfByNameFolderFromDb({required String nameFolder});
  Future<void> saveFileFolderAppStorage({required PdfModel pdfModel, required FolderModel folder});
  Future<void> deletePdfModelByNameFolderFromDb({required String nameFolder});
 // Future<void> savePdfModelFavouritesAppStorage({required PdfModel pdfModel});
  // Future<List<PdfModel>> getPdfListModelFromDbFavorite();



}

