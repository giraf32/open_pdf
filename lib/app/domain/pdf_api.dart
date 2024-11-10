
import 'package:open_pdf/app/domain/model/pdf_model.dart';



abstract class PdfApi {

  Future<void> insertDbListPdfModel({required List<PdfModel> listPdfModels});
  Future<void> deleteFilePdfAndModelDb({required PdfModel pdfModel});
  Future<List<PdfModel?>> getPdfListModelFromDbHistory();
  Future<void> updatePdfModel({required PdfModel pdfModel});
  Future<List<PdfModel>?> getPdfListDeviceStorage();
  Future<void> deleteDbPdfModel({required PdfModel pdfModel});
  Future<void> updateNumberPages({required PdfModel pdfModel});
  Future<int?> getNumberPages({required PdfModel pdfModel});
 // Future<void> savePdfModelFavouritesAppStorage({required PdfModel pdfModel});
  // Future<List<PdfModel>> getPdfListModelFromDbFavorite();



}

