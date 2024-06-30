
import 'package:open_pdf/app/domain/model/model_pdf.dart';

abstract class PdfApi {
  Future<void> insertDbListPdfModel({required List<PdfModel> listPdfModels});
  Future<void> deleteFilePdfAndModelDb({required PdfModel pdfModel});
  Future<List<PdfModel>> getPdfListModelFromDbHistory();
  Future<List<PdfModel>> getPdfListModelFromDbFavorite();
  Future<List<PdfModel>?> getPdfListDeviceStorage();
  Future<void> deleteDbPdfModel({required PdfModel pdfModel});
  Future<void> savePdfModelFavouritesAppStorage({required PdfModel pdfModel});
  Future<void> updatePdfModel({required PdfModel pdfModel});


}
