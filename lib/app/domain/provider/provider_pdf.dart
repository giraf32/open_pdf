import 'package:flutter/material.dart';
import 'package:open_pdf/app/data/db_app/db_services_pdf.dart';
import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/data/repository/pdf_repository.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';

import '../../../utility/pdf_function.dart';
import '../../ui/widget/widget_pdf_file/show_alert_dialog_pdf.dart';
import '../model/folder_model.dart';

enum NotifierState { initial, loading, loaded }
enum NotifierStateListPdfFolder { initial, loading, loaded }
enum NotifierDeletePdfFolder { initial, deleting, deleted }


class ProviderPDF extends ChangeNotifier {
  ProviderPDF();

  NotifierState notifierState = NotifierState.initial;
  NotifierStateListPdfFolder notifierStateListPdfFolder = NotifierStateListPdfFolder.initial;
  NotifierDeletePdfFolder notifierDeletePdfFolder = NotifierDeletePdfFolder.initial;

  final _pdfRepository = PdfRepository(dbServicesPdf: DbServicesPdf(InitDb.create()));
  var pdfModelListHistory = <PdfModel?>[];
  var pdfListFavourites = <PdfModel?>[];


  var listPdfFileByNameFolder = <PdfModel?>[];

  //----------folder------------
  Future<void> updateListFolderByName(String nameFolder) async {
    try {
      notifierStateListPdfFolder = NotifierStateListPdfFolder.loading;

      listPdfFileByNameFolder = await _pdfRepository.getLisPdfByNameFolderFromDb(nameFolder: nameFolder);
    } catch (e, s) {
      print('Error updateListFolderByName: $e');
      print('Error updateListFolderByName: $s');
    }
    notifierStateListPdfFolder = NotifierStateListPdfFolder.loaded;
    notifyListeners();
  }

  Future<void> saveFileFolder(
      PdfModel pdfModel, BuildContext context, FolderModel folderModel) async {
    try {
      print('nameFolder : $folderModel');
      print('pdfModel : $pdfModel');
      final listFolder =
      await _pdfRepository.getLisPdfByNameFolderFromDb(nameFolder: folderModel.nameFolder);

      if (listFolder.isNotEmpty) {
        final pdfListAddFolder = <PdfModel>[]..add(pdfModel);
        //TODO folder.name _compare
        final pdfModelClone = await comparePdfModel(
            listFirst: pdfListAddFolder, listSecond: listFolder);
        if (!context.mounted) return;
        if (pdfModelClone.isNotEmpty)
          await showAlertDialogPdf(context, pdfModelClone);
      }
      await _pdfRepository.saveFileFolderAppStorage(pdfModel: pdfModel, folder: folderModel);
      await updateListFolderByName(folderModel.nameFolder);
    } catch (e, s) {
      print('Error savePdfFavourites: $e');
      print('Error savePdfFavourites: $s');
    }
  }
  Future<void> deletePdfFromFolder(String folder) async {
    notifierDeletePdfFolder = NotifierDeletePdfFolder.deleting;
    // notifyListeners();
    try {
      await _pdfRepository.deletePdfModelByNameFolderFromDb(nameFolder: folder);
      // await Future.delayed(Duration(seconds: 5),(){_folderRepository.deletePdfModelByNameFolderFromDb(nameFolder: folder);});

    } catch (e, s) {
      print('Error deletePdfFolder: $e');
      print('Error deletePdfFolder: $s');
    }
    notifierDeletePdfFolder = NotifierDeletePdfFolder.initial;
    updatePdfListModelHistory();
    notifyListeners();
  }
//-------------------------------------

  bool changeMenuItemFavourites = false;

  Future<void> addListPdfFileFromDeviceStorage(BuildContext context) async {
    try {
      notifierState = NotifierState.loading;
      final listPdfModelsStorage =
          await _pdfRepository.getPdfListDeviceStorage();

      if (listPdfModelsStorage == null) {
        notifierState = NotifierState.loaded;
        notifyListeners();
        return;
      }
      final pdfListModelDb =
          await _pdfRepository.getPdfListModelFromDbHistory();

      final pdfModelClone = comparePdfModel(
          listFirst: listPdfModelsStorage, listSecond: pdfListModelDb);
      if (!context.mounted) return;
      if (pdfModelClone.isNotEmpty) await showAlertDialogPdf(context, pdfModelClone);
      await _pdfRepository.insertDbListPdfModel(
          listPdfModels: listPdfModelsStorage);

      await updatePdfListModelHistory();
    } catch (e, s) {
      print('Error addOpenPdf: $e');
      print('Error addOpenPdf: $s');
    }
  }

  Future<void> deleteFilePdf(PdfModel pdfModel) async {
    try {
      await _pdfRepository.deleteFilePdfAndModelDb(pdfModel: pdfModel);
      await updatePdfListModelHistory();
     // await updatePDFListModelFavourites();
    } catch (e, s) {
      print('Error delete: $e');
      print('Error delete: $s');
    }
  }

  Future<void> deleteFilePdfAfterCompare(List<PdfModel?> listPdf) async {
    try {
      //TODO await here maybe excess
      if (listPdf.isNotEmpty)
        await {
          listPdf.forEach((element) {
            _pdfRepository.deleteFilePdfAndModelDb(pdfModel: element!);
          })
        };
      // await updatePdfListModelHistory();
      // await updatePDFListModelFavourites();
    } catch (e, s) {
      print('Error delete after compare: $e');
      print('Error delete after compare: $s');
    }
  }

  Future<void> updatePdfListModelHistory() async {
    try {
      notifierState = NotifierState.loading;

      pdfModelListHistory = await _pdfRepository.getPdfListModelFromDbHistory();

      // print('listLocalPdf 0 $localListPdf');
    } catch (e, s) {
      print('Error updatePdfList: $e');
      print('Error updatePdfList: $s');
    }
    notifierState = NotifierState.loaded;
    notifyListeners();
  }
//-------------Favourites------------------
//   Future<void> updatePDFListModelFavourites() async {
//     try {
//       notifierState = NotifierState.loading;
//
//       pdfListFavourites = await _pdfRepository.getPdfListModelFromDbFavorite();
//       print('localFavourites = $pdfListFavourites');
//       notifierState = NotifierState.loaded;
//       notifyListeners();
//     } catch (e, s) {
//       print('Error updatePdfListModelFavourites: $e');
//       print('Error updatePdfListModelFavourites: $s');
//     }
//   }
//
//   Future<void> savePdfFavourites(
//       PdfModel pdfModel, BuildContext context) async {
//     try {
//       final pdfListFavorites =
//           await _pdfRepository.getPdfListModelFromDbFavorite();
//
//       if (pdfListFavorites.isNotEmpty) {
//         final pdfListAddFavorites = <PdfModel>[]..add(pdfModel);
//         final pdfModelClone = await comparePdfModel(
//             listFirst: pdfListAddFavorites, listSecond: pdfListFavorites);
//         if (!context.mounted) return;
//         if (pdfModelClone.isNotEmpty)
//           await showAlertDialogPdf(context, pdfModelClone);
//       }
//       await _pdfRepository.savePdfModelFavouritesAppStorage(pdfModel: pdfModel);
//       await updatePDFListModelFavourites();
//       await updatePdfListModelHistory();
//     } catch (e, s) {
//       print('Error savePdfFavourites: $e');
//       print('Error savePdfFavourites: $s');
//     }
//   }

  Future<void> updatePdfModelDb(PdfModel newPdfModel) async {
    try {
      await _pdfRepository.updatePdfModel(pdfModel: newPdfModel);
     // await updatePDFListModelFavourites();
      await updatePdfListModelHistory();
    } catch (e, s) {
      print('Error updatePdfNameFile: $e');
      print('Error updatePdfNameFile: $s');
    }
  }


}
