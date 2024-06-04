import 'dart:async';
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
  Future<void> insertDbListPdfModel(
      {required List<PDFModel> listPdfModels}) async {
    var insertDbPdfModel = await listPdfModels
        .map((pdfModel) async =>
            (await dbServices.insertPDF(pdfModel: pdfModel)))
        .toList();
    //print('insertDbListPdfModel :  $listPdfModels');
    print('nyListId :  $insertDbPdfModel');
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
  Future<List<PDFModel>> getPdfListModelFromDb() async {
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

  @override
  Future<List<PDFModel>?> getPdfListStorage() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], allowMultiple: true);


    if (result != null) {
      var listPdfModels = result.files.map((e) => (createPdfModel(e))).toList();
      return listPdfModels;
    }
    return null;
  }

  @override
  Future<void> savePdfFavourites({required PDFModel pdfModel}) async {
    final file = File(pdfModel.path);
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${pdfModel.name}');
    if (await file.exists()) {
      final favouritesFile = await file.copy(newFile.path);
      final name = pdfModel.name;
     // final id = name.hashCode + 1;
      final path = favouritesFile.path.toString();
      final String formatDate = _formatterDate();

      final pdfModelFavourites = PDFModel(
         // id: id,
          path: path, name: name, favourites: 1, dateTime: formatDate);
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
  PDFModel createPdfModel(PlatformFile platformFile) {
    print('hi');
    String name = platformFile.name.toString();
   // int id = name.hashCode;
    String path = platformFile.path.toString();
    String size = platformFile.size.toString();
    final formatDate = _formatterDate();
    final pdfModel = PDFModel(
      //  id: id,
        path: path,
        name: name,
        favourites: 0,
        dateTime: formatDate,
        size: size);
    // await dbServices.insertPDF(pdfModel: pdfModel);
    return pdfModel;
  }
  void clearCachedFiles(){
    FilePicker.platform.clearTemporaryFiles();
  }

  String _formatterDate (){
    final dateTime = DateTime.now();
    final DateFormat formatter = DateFormat.yMd().add_Hms();
    final String formatDate = formatter.format(dateTime);
    print('dataTime : $formatDate');
    return formatDate;

  }
}
