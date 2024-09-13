import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/change_check_box.dart';
import 'package:open_pdf/app_router/app_router.dart';
import 'package:provider/provider.dart';
import '../../../domain/provider/provider_pdf.dart';

class AddPdfFolder extends StatefulWidget {
  const AddPdfFolder({super.key, required this.folderName});

  final String folderName;

  @override
  State<AddPdfFolder> createState() => _AddPdfFolderState();
}

class _AddPdfFolderState extends State<AddPdfFolder> {
  bool isChecked = false;
 // var pdfListFavourites = <PdfModel?>[];

  // ButtonStyle buttonStyle = ButtonStyle(backgroundColor: ,);
  @override
  Widget build(BuildContext context) {
    var listPdfFolders = context.read<ProviderPDF>().pdfModelListHistory;
    return Container(
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
         listPdfFolders.isNotEmpty ? Expanded(
              flex: 6,
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    PdfModel itemPdfName = listPdfFolders[index]!;
                    return ChangeCheckBox(pdfModel: itemPdfName);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: listPdfFolders.length),
            ) : Text('Файл не найден'),
            SizedBox(
              height: 10,
            ),
            Expanded(
                flex: 1,
                child: TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    var pdfListFavourites =
                          await context.read<ProviderPDF>().listPdfAdd;

                      await context.read<ProviderPDF>().saveFileFolder(
                          pdfListFavourites, context, widget.folderName);
                       context.read<ProviderPDF>().clearListPdfAdd();
                      context.router.replace(FolderPdfRoute(nameFolder: widget.folderName));
                    //  context.router.
                    },

                    child: Text('Добавить в папку')))
          ],
        ));
  }
}
