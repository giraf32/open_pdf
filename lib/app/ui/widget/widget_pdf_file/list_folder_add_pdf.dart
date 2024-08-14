import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:provider/provider.dart';
import '../../../domain/provider/provider_folder.dart';
import '../../../domain/provider/provider_pdf.dart';

class ListFolderAddPdf extends StatelessWidget {
  const ListFolderAddPdf({super.key, required this.pdfModel});

  final PdfModel pdfModel;

  @override
  Widget build(BuildContext context) {
    //TODO проверка списка на пустоту
    var listFolders = context.read<ProviderFolder>().listFolder;
    return Container(
        height: 500,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(18.0)),
        child: ListView.separated(
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
                onTap: () {
                  //TODO colors
                  context
                      .read<ProviderPDF>()
                      .saveFileFolder(pdfModel, context, listFolders[index]!);
                  Navigator.pop(context);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: listFolders.length)

        // ListView(
        //  // prototypeItem: ,
        //     children: listFolders
        //         .map((e) =>
        //         FolderItemAddPdf(folderModel: e!, pdfModel: pdfModel))
        //         .toList()),
        );
  }
}
