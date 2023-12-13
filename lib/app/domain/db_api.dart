
import 'package:open_pdf/app/domain/model/model_pdf.dart';


abstract class DbApi{
  DbApi();
  Future <Object?> get database;
  initDB();
 // Future<Object?> initDB();
  Future<int?> insertPDF({ required PDFModel pdfModel});
  Future<void> updatePDF({ required PDFModel pdfModel});
  Future<List<PDFModel>> getPDFList();
  Future<void> deletePDF({required int? id});

}