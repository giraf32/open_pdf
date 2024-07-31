import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/folder_model.dart';


class FolderItemAddPdf extends StatelessWidget {
  const FolderItemAddPdf({super.key, required this.folderModel, required this.pdfModel});
  final FolderModel folderModel;
  final PdfModel pdfModel;
  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: Icon(
        Icons.folder,
        color: Colors.amberAccent,
      ),
      title: Text(folderModel.nameFolder),
      onTap: (){
        //TODO colors
        context.read<ProviderPDF>().saveFileFolder(pdfModel, context, folderModel);
        Navigator.pop(context);
      },
    );
  }

}