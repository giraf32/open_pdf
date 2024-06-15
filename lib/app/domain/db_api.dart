
import 'package:open_pdf/app/domain/model/model_pdf.dart';


abstract class DbApi{

  Future<void> insertPdfDb({ required PdfModel pdfModel});
  Future<void> updatePdfDb({ required PdfModel pdfModel});
  Future<List<PdfModel>> getPdfListDb();
  Future<void> deletePdfDb({required int? id});

}