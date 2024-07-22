import 'dart:io';
import 'package:open_pdf/app/domain/db_api_folder.dart';
import 'package:open_pdf/app/domain/db_api_pdf.dart';
import 'package:open_pdf/app/domain/folder_api.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utility/pdf_function.dart';

class FolderRepository implements FolderApi{
  final DbApiPdf dbServicesPdf;
  final DbApiFolder dbServicesFolder;

  FolderRepository({required this.dbServicesFolder, required this.dbServicesPdf});
  @override
  Future<List<PdfModel>> getLisFolderFromDb() async {
    var localListFolder = <PdfModel>[];
    await dbServicesPdf.getPdfListDb().then((listModel) {
      listModel.forEach((pdfModel) {
        if (pdfModel.folder == 'history') {
          localListFolder.add(pdfModel);
        }
      });
    });

    return localListFolder;

  }

  @override
  Future<List<PdfModel>> getLisPdfModelByNameFolderFromDb({required String nameFolder}) async{
    //TODO null folder
    var localListFolder = <PdfModel>[];
    await dbServicesPdf.getPdfListDb().then((listModel) {
      listModel.forEach((pdfModel) {
        if (pdfModel.folder == nameFolder) {
          var file = File(pdfModel.path);
          final id = pdfModel.id;
          print('idFolder = $id');
          if (!file.existsSync())  dbServicesPdf.deletePdfDb(id: pdfModel.id);
          localListFolder.add(pdfModel);
        }
        if (localListFolder.length > 1) localListFolder = sortListPdf(localListFolder);
      });
    });

    return localListFolder;
  }
  @override
  Future<void> saveFileFolderAppStorage({required PdfModel pdfModel}) async{
    final file = File(pdfModel.path);
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${pdfModel.name}/${pdfModel.folder}');
    if (await file.exists()) {
      final folderFile = await file.copy(newFile.path);
      final name = pdfModel.name;
      final folder = pdfModel.folder;
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
          folder: folder
      );
      await dbServicesPdf.insertPdfDb(pdfModel: pdfModelFolder);
    }
  }

  @override
  Future<void> deleteFolder({required int? id}) async {
  await dbServicesFolder.deleteFolderDb(id: id);
  }

  @override
  Future<List<FolderModel?>> getListFolder() async {
   return await dbServicesFolder.getListFolderDb();
  }

  @override
  Future<void> insertFolder({required FolderModel folder}) async {
   await dbServicesFolder.insertFolderDb(folder: folder);
  }

  @override
  Future<void> updateFolder({required FolderModel folder}) async {
    await dbServicesFolder.updateFolderDb(folder: folder);
  }


}