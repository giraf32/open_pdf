import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_pdf/app/domain/db_api.dart';
import 'package:open_pdf/app/domain/pdf_api.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/model/model_pdf.dart';

class PdfRepository implements PdfApi {
  final DbApi dbServices;
 // late DateTime? dateTime;

  PdfRepository({required this.dbServices});

  @override
  Future<File?> addFilePDF() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result == null) return null;
    final size = result.files.single.size.toString();
    final name = result.files.single.name.toString();
    final id = name.hashCode;
    final path = result.files.single.path.toString();
    final dateTime = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    //final DateFormat formatter = DateFormat.d().add_M().add_y();
    final String formatDate = formatter.format(dateTime);
    final pdfModel = PDFModel(id: id, path: path, name: name,favourites: 0, dateTime: formatDate, size: size);
    await dbServices.insertPDF(pdfModel: pdfModel);
    return File(path);

  }

  @override
  Future<void> deleteFilePDF({required PDFModel pdfModel}) async {
    var file = File(pdfModel.path);
    if (await file.exists()) {
      await file.delete();
    }
    await dbServices.deletePDF(id: pdfModel.id);
  }

  @override
  Future<List<PDFModel>> getPDFListModel() async {
    List<PDFModel> listPDFModel = await dbServices.getPDFList();
    return listPDFModel;
  }

  // @override
  // Future<void> getDirectory() async {
  //   String? selectedDirectory =  await FilePicker.platform.getDirectoryPath();
  //   if(selectedDirectory != null) {
  //      final result = PDFModel(path: selectedDirectory, name: selectedDirectory);
  //      await dbServices.insertPDF(pdfModel: result);
  //   }
  //
  // }

  // @override
  // Future<List<PDFModel>?> getPDFList() async {
  //   final result = await FilePicker.platform
  //       .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  //   if (result != null) {
  //   // List<PDFModel>?
  //     final filesList = result.paths.map((path) => PDFModel(path: path!,name: path)).toList();
  //     return filesList;
  //   }
  //   return null;
  // }

  @override
  Future<void> savePdfFavourites({required PDFModel pdfModel}) async {
    final file = File(pdfModel.path);
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${pdfModel.name}');
    if (await file.exists()) {
      final favouritesFile = await file.copy(newFile.path);
      final name = pdfModel.name;
      final id = name.hashCode + 1;
      final path = favouritesFile.path.toString();
      final dateTime = DateTime.now().toString();
      final pdfModelFavourites = PDFModel(id: id,path: path, name: name,favourites: 1,dateTime: dateTime);
      await dbServices.insertPDF(pdfModel: pdfModelFavourites);
    }
  }

  @override
  Future<void> deleteDbPdfModel({required PDFModel pdfModel}) async {
    await dbServices.deletePDF(id: pdfModel.id);
  }

  @override
  Future<void> updatePdfModel({required PDFModel pdfModel}) async {
   await dbServices.updatePDF(pdfModel: pdfModel);
  }

// static Future<File?> loadAsset(String path) async {
//   final data = await rootBundle.load(path);
//   final bytes = data.buffer.asInt8List();
//   return _storeFile(path, bytes);
// }

// static Future<File?> _storeFile(String url, List<int> bytes) async {
//   final filename = basename(url);
//   final dir = await getApplicationDocumentsDirectory();
//   final file = File('${dir.path}/$filename');
//   await file.writeAsBytes(bytes, flush: true);
//   return file;
// }
}
