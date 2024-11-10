import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:open_pdf/app/app_const.dart';
import 'package:open_pdf/app/domain/db_api_pdf.dart';
import 'package:open_pdf/app/domain/pdf_api.dart';
import '../../../utility/pdf_function.dart';
import '../../domain/model/pdf_model.dart';

class PdfRepository implements PdfApi {
  final DbApiPdf dbServicesPdf;

  // late DateTime? dateTime;
  bool isRecord = false;

  PdfRepository({required this.dbServicesPdf});

  @override
  Future<void> insertDbListPdfModel(
      {required List<PdfModel> listPdfModels}) async {
    listPdfModels.forEach((pdfModel) async {
      await dbServicesPdf.insertPdfDb(pdfModel: pdfModel);
    });
  }

  @override
  Future<void> deleteFilePdfAndModelDb({required PdfModel pdfModel}) async {
    await dbServicesPdf.deletePdfDb(id: pdfModel.id);
    var file = File(pdfModel.path);
    if (await file.exists()) {
      file.delete();
    }
  }

  @override
  Future<List<PdfModel?>> getPdfListModelFromDbHistory() async {
    var localListPdfHistory = <PdfModel?>[];
    await dbServicesPdf.getPdfListDb().then((listModel) {
      listModel.forEach((pdfModel) {
        if (pdfModel.folder == NAME_FOLDER_HISTORY) {
          final id = pdfModel.id;
          print('idHistory = $id');
          var file = File(pdfModel.path);
          if (!file.existsSync()) {
            deleteDbPdfModel(pdfModel: pdfModel);
          } else {
            localListPdfHistory.add(pdfModel);
          }
        }
      });
      if (localListPdfHistory.length > 1)
        localListPdfHistory = sortListPdf(localListPdfHistory);
    });
    return localListPdfHistory;
  }



  @override
  Future<List<PdfModel>?> getPdfListDeviceStorage() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], allowMultiple: true);

    if (result != null) {
      var listPdfModels =
          result.files.map((e) => (_createPdfModel(e))).toList();
      return listPdfModels;
    }
    return null;
  }

  @override
  Future<void> deleteDbPdfModel({required PdfModel pdfModel}) async {
    await dbServicesPdf.deletePdfDb(id: pdfModel.id);
  }

  @override
  Future<void> updatePdfModel({required PdfModel pdfModel}) async {
    await dbServicesPdf.updatePdfDb(pdfModel: pdfModel);
  }

  PdfModel _createPdfModel(PlatformFile platformFile) {
    print('hi');
    String name = platformFile.name.toString();
    // int id ;
    String path = platformFile.path.toString();
    String size = platformFile.size.toString();
    String folder = NAME_FOLDER_HISTORY;
    final formatDate = formatterDate();
    final pdfModel = PdfModel(
        // id: id,
        path: path,
        name: name,
        pageNumber: 1,
        dateTime: formatDate,
        size: size,
        folder: folder);

    return pdfModel;
  }

  void clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles();
  }

  @override
  Future<int?> getNumberPages({required PdfModel pdfModel}) async {
    int? _id = pdfModel.id;
    int? _pageNumber;
    await dbServicesPdf.getPdfListDb().then((listModel) {
      listModel.forEach((pdfModel) {
        if (pdfModel.id == _id ) {
        _pageNumber = pdfModel.pageNumber;
        }
      });

    });
    return _pageNumber;
  }

  @override
  Future<void> updateNumberPages({required PdfModel pdfModel}) {
    // TODO: implement updateNumberPages
    throw UnimplementedError();
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
//-----------------Favourites----------


}
