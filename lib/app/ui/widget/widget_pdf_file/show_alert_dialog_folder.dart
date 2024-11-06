import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:provider/provider.dart';


import '../../../domain/provider/provider_folder_pdf.dart';


Future<void> showAlertDialogFolder(
    BuildContext context, FolderModel folder, List<PdfModel> listPdf) async {
  final provideFolder = context.read<ProviderFolderPdf>();
  final providerPdf = context.read<ProviderPDF>();
  String nameFolder = folder.nameFolder;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return  AlertDialog(
        title: Text(
          'Выбрана папка : $nameFolder ',
          style: TextStyle(fontSize: 18),
        ),
       // content: Text(folder.nameFolder, style: TextStyle(fontSize: 22,color: Colors.red)),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                  onPressed: () async{
                   await provideFolder.saveFileFolder(
                        listPdf, context, folder.nameFolder);

                    Navigator.pop(context);
                    // context.read<ProviderPDF>().addAndOpenPdf(context);
                  },
                  child: const Text('копировать', style: TextStyle(fontSize: 16))),
              TextButton(
                  onPressed: () async {
                    await  provideFolder.saveFileFolder(
                        listPdf, context,folder.nameFolder);
                    await providerPdf.deleteFilePdf(listPdf.first);

                    Navigator.pop(context);
                   // context.router.replace(HomeRoute());
                  },
                  child: Text(
                    'переместить',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),

        ],
      );
    },
  );
}