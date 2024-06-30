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
  Future<void> insertDbListPdfModel({required List<PdfModel> listPdfModels})
  async {
      listPdfModels.forEach((pdfModel) async {
      await  dbServices.insertPdfDb(pdfModel: pdfModel);
     });



    //print('insertDbListPdfModel :  $listPdfModels');
  //  print('nyListId :  $insertDbPdfModel');
  }

  @override
  Future<void> deleteFilePdfAndModelDb({required PdfModel pdfModel}) async {
    await dbServices.deletePdfDb(id: pdfModel.id);
    var file = File(pdfModel.path);
    if (await file.exists()) {
      file.delete();
    }

  }

  @override
  Future<List<PdfModel>> getPdfListModelFromDbHistory() async {
    var localListPdfHistory = <PdfModel>[];
    await dbServices.getPdfListDb().then((listModel) {
      listModel.forEach((pdfModel) {
        if (pdfModel.favourites == 0) {
          final id = pdfModel.id;
          print('id = $id');
          var file = File(pdfModel.path);
          if (!file.existsSync()) {
            deleteDbPdfModel(pdfModel: pdfModel);
          } else {
            localListPdfHistory.add(pdfModel);
          }
        }
      });
      if (localListPdfHistory.length > 1) localListPdfHistory = _sortListPdf(localListPdfHistory);
    });
    return localListPdfHistory;
  }

  @override
  Future<List<PdfModel>> getPdfListModelFromDbFavorite() async {
    var localListFavorite = <PdfModel>[];
    await dbServices.getPdfListDb().then((listModel) {
      listModel.forEach((pdfModel) {
        if (pdfModel.favourites == 1) {
          var file = File(pdfModel.path);
          final id = pdfModel.id;
          print('idFavorite = $id');
          if (!file.existsSync())  deleteDbPdfModel(pdfModel: pdfModel);
          localListFavorite.add(pdfModel);
        }
        if (localListFavorite.length > 1) localListFavorite = _sortListPdf(localListFavorite);
      });
    });

    return localListFavorite;
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
  Future<void> savePdfModelFavouritesAppStorage({required PdfModel pdfModel}) async {
    final file = File(pdfModel.path);
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${pdfModel.name}');
    if (await file.exists()) {
      final favouritesFile = await file.copy(newFile.path);
      final name = pdfModel.name;
      final size = pdfModel.size;
      // final id = name.hashCode + 1;
      final path = favouritesFile.path.toString();
      final String formatDate = _formatterDate();

      final pdfModelFavourites = PdfModel(
          // id: id,
          path: path,
          name: name,
          favourites: 1,
          size: size,
          dateTime: formatDate);
      await dbServices.insertPdfDb(pdfModel: pdfModelFavourites);
    }
  }

  @override
  Future<void> deleteDbPdfModel({required PdfModel pdfModel}) async {
    await dbServices.deletePdfDb(id: pdfModel.id);
  }

  @override
  Future<void> updatePdfModel({required PdfModel pdfModel}) async {
    await dbServices.updatePdfDb(pdfModel: pdfModel);
  }

  PdfModel _createPdfModel(PlatformFile platformFile) {
    print('hi');
    String name = platformFile.name.toString();
    // int id ;
    String path = platformFile.path.toString();
    String size = platformFile.size.toString();
    final formatDate = _formatterDate();
    final pdfModel = PdfModel(
       // id: id,
        path: path,
        name: name,
        favourites: 0,
        dateTime: formatDate,
        size: size);
    // await dbServices.insertPDF(pdfModel: pdfModel);
    return pdfModel;
  }

  void clearCachedFiles() {
    FilePicker.platform.clearTemporaryFiles();
  }

  String _formatterDate() {
    final dateTime = DateTime.now();
    final DateFormat formatter = DateFormat.yMd().add_Hms();
    final String formatDate = formatter.format(dateTime);
    print('dataTime : $formatDate');
    return formatDate;
  }

  List<PdfModel> _sortListPdf(List<PdfModel> list){
    final DateFormat formatter = DateFormat.yMd().add_Hms();

    bool Sorted = false;
    while (!Sorted) {
      Sorted = true;
      for (int i = 1; list.length > i; i++) {
        var dateTimeFirst = formatter.parse(list[i - 1].dateTime);
        var dateTimeSecond = formatter.parse(list[i].dateTime);
        if (dateTimeFirst.isBefore(dateTimeSecond)) {
          var tmp = list[i];
          list[i] = list[i - 1];
          list[i - 1] = tmp;
          Sorted = false;
        }
      }
    }

    return list;
  }


// Future<void> getDirectory() async {
//   String? selectedDirectory =  await FilePicker.platform.getDirectoryPath();
//   if(selectedDirectory != null) {
//     print('Выбранный путь:  $selectedDirectory');
//   }
//   }
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
