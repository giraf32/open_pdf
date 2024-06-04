
import 'package:open_pdf/app/domain/model/model_pdf.dart';

abstract class PdfApi {
  Future<void> insertDbListPdfModel({required List<PDFModel> listPdfModels});
  Future<void> deleteFilePDF({required PDFModel pdfModel});
  Future<List<PDFModel>> getPdfListModelFromDb();
  Future<List<PDFModel>?> getPdfListStorage();
  Future<void> deleteDbPdfModel({required PDFModel pdfModel});
  Future<void> savePdfFavourites({required PDFModel pdfModel});
  Future<void> updatePdfModel({required PDFModel pdfModel});


}
