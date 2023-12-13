import 'dart:io';
import 'package:open_pdf/app/domain/model/model_pdf.dart';

abstract class PdfApi {
  Future<File?> addFilePDF();
  Future<void> deleteFilePDF({required PDFModel pdfModel});
  Future<List<PDFModel>> getPDFListModel();
 // Future<List<PDFModel>?> getPDFList();
  Future<void> deleteDbPdfModel({required PDFModel pdfModel});
  Future<void> savePdfFavourites({required PDFModel pdfModel});
  Future<void> updatePdfModel({required PDFModel pdfModel});


}
