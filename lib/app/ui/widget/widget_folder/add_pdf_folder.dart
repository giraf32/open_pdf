import 'package:flutter/material.dart';

import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:open_pdf/app/domain/provider/provider_folder_pdf.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/change_check_box.dart';

import 'package:provider/provider.dart';
import '../../../domain/provider/provider_pdf.dart';

class AddPdfFolder extends StatefulWidget {
  const AddPdfFolder({super.key, required this.folderName});

  final String folderName;

  @override
  State<AddPdfFolder> createState() => _AddPdfFolderState();
}

class _AddPdfFolderState extends State<AddPdfFolder> {
  var listPdfHistory = <PdfModel?>[];

  //GlobalKey<ScaffoldState> _globalKey =  GlobalKey<ScaffoldState>();

  @override
  void initState() {
    listPdfHistory = context.read<ProviderPDF>().pdfModelListHistory;
    super.initState();
  }

  // var pdfListFavourites = <PdfModel?>[];

  // ButtonStyle buttonStyle = ButtonStyle(backgroundColor: ,);
  @override
  Widget build(BuildContext context) {
    bool textButton = context.watch<ProviderFolderPdf>().isTextButton;
    //var listPdfFolders = context.read<ProviderPDF>().pdfModelListHistory;
    return Container(
        //  key: _globalKey,
        height: 500,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(18.0)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            listPdfHistory.isNotEmpty
                ? Expanded(
                    flex: 6,
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          PdfModel itemPdfName = listPdfHistory[index]!;
                          return ChangeCheckBox(pdfModel: itemPdfName);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: listPdfHistory.length),
                  )
                : const Expanded(
                    flex: 4,
                    child: Text(
                      ' Файл не найден.\n Добавьте файл в приложение.',
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    )),
            SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 1,
                child: textButton
                    ? TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade300),
                        onPressed: () async {
                          var pdfListFavourites = context
                              .read<ProviderFolderPdf>()
                              .listPdfAddFolder;
                          debugPrint(
                              'listAddCheckBox _______________ $pdfListFavourites');
                          if (pdfListFavourites.isNotEmpty) {
                            await context
                                .read<ProviderFolderPdf>()
                                .saveFileFolder(pdfListFavourites, context,
                                    widget.folderName);
                            context
                                .read<ProviderFolderPdf>()
                                .clearListPdfAddFolder();
                            Navigator.pop(context);
                            context
                                .read<ProviderFolderPdf>()
                                .setTextButton(false);
                            // context.router.replace(FolderPdfRoute(nameFolder: widget.folderNam;
                          } else {
                            debugPrint(
                                'listNotCheckBox _______________ $pdfListFavourites');
                          }
                        },
                        child: const Text(
                          'Добавить в папку',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ))
                    : const Center(
                        child: Text(
                        'Выберите файл',
                        style: TextStyle(fontSize: 22, color: Colors.red),
                      )))
          ],
        ));
  }
}
