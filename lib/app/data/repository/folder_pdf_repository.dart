import 'dart:io';

import 'package:open_pdf/app/domain/folder_pdf_api.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utility/pdf_function.dart';
import '../../domain/db_api_pdf.dart';
import '../../domain/model/pdf_model.dart';

class FolderPdfRepository implements FolderPdfApi {
  FolderPdfRepository({required this.dbServicesPdf});

  final DbApiPdf dbServicesPdf;
  bool isRecord = false;

  Future<void> _saveFileAndInsertDb(
      PdfModel pdfModel, String nameFolder) async {
    final file = File(pdfModel.path);
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${pdfModel.name}');
    if (await file.exists()) {
      final folderFile = await file.copy(newFile.path);
      final name = pdfModel.name;
      final folderName = nameFolder;
      final size = pdfModel.size;
      // final id = name.hashCode + 1;
      final path = folderFile.path.toString();
      final String formatDate = formatterDate();

      final pdfModelFolder = PdfModel(
          // id: id,
          path: path,
          name: name,
          favourites: 0,
          size: size,
          dateTime: formatDate,
          folder: folderName);
      await dbServicesPdf.insertPdfDb(pdfModel: pdfModelFolder);
    }
  }

  @override
  Future<List<PdfModel?>> getLisPdfByNameFolderFromDb(
      {required String nameFolder}) async {
    //TODO null folder
    var localListFolder = <PdfModel?>[];
    await dbServicesPdf.getPdfListDb().then((listModel) {
      listModel.forEach((pdfModel) {
        if (pdfModel.folder == nameFolder) {
          var file = File(pdfModel.path);
          if (file.existsSync()) {
            localListFolder.add(pdfModel);
          } else {
            dbServicesPdf.deletePdfDb(id: pdfModel.id);
          }
        }
        if (localListFolder.length > 1)
          localListFolder = sortListPdf(localListFolder);
      });
    });

    return localListFolder;
  }

  @override
  Future<bool> saveFileFolderAppStorage(
      {required List<PdfModel?> listPdfModels,
      required String nameFolder}) async {
    if (listPdfModels.isNotEmpty) {
      await Future.wait(
        [
          for (var pdfModel in listPdfModels)
            _saveFileAndInsertDb(pdfModel!, nameFolder)
        ],
      );
      print('isRecord before forEach ::::::::: $isRecord');
      return isRecord = true;
    }
    print('isRecord after forEach ::::::::: $isRecord');
    return isRecord;
  }

  @override
  Future<void> deletePdfModelByNameFolderFromDb(
      {required String nameFolder}) async {
    await dbServicesPdf.getPdfListDb().then((listModel) {
      listModel.forEach((pdfModel) {
        if (pdfModel.folder == nameFolder) {
          dbServicesPdf.deletePdfDb(id: pdfModel.id);
          var file = File(pdfModel.path);
          final id = pdfModel.id;
          print('idFolderDelete = $id');
          if (file.existsSync()) {
            file.delete();
          }
        }
      });
    });
  }

  @override
  Future<void> changeNameFolder(
      {required String nameFolder, required String newNameFolder}) async {
    await dbServicesPdf.getPdfListDb().then((listModel) {
      listModel.forEach((pdfModel) {
        if (pdfModel.folder == nameFolder) {
          final newPdfModel = pdfModel.copyWith(folder: newNameFolder);
          dbServicesPdf.updatePdfDb(pdfModel: newPdfModel);
          final id = pdfModel.id;
          final nawId = newPdfModel.id;
          print('idFolderChange = $id ; newId = $nawId');
        }
      });
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
  Future<void> updatePdfModelFolder({required PdfModel pdfModel}) async {
    await dbServicesPdf.updatePdfDb(pdfModel: pdfModel);
  }
}
