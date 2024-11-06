import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:open_pdf/app/ui/widget/widget_pdf_file/show_alert_dialog_folder.dart';
import 'package:provider/provider.dart';
import '../../../domain/provider/provider_folder.dart';

class ListFolderAddPdf extends StatelessWidget {
  ListFolderAddPdf({super.key, required this.pdfModel}) {
    _listPdfModel.add(pdfModel);
  }

  final PdfModel pdfModel;
  final _listPdfModel = <PdfModel>[];

  @override
  Widget build(BuildContext context) {
    var listFolders = context.read<ProviderFolder>().listFolder;

    return Container(
      height: 500,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(18.0)),
      child: listFolders.isNotEmpty
          ? ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(
                    // IconData('assets/folder.png'),
                    Icons.folder,
                    color: Colors.amberAccent,
                  ),
                  title: Text(
                    listFolders[index]!.nameFolder,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  onTap: () async {
                 await showAlertDialogFolder(context, listFolders[index]!, _listPdfModel);

                  //  TODO colors
                    // context.read<ProviderFolderPdf>().saveFileFolder(
                    //     _listPdfModel, context, listFolders[index]!.nameFolder);
                     Navigator.pop(context);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: listFolders.length)
          : const Text(
              ' Папка не найден.\n Создайте пожалуйста папку.',
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
    );
  }
}
