 import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:open_pdf/app/ui/widget/widget_pdf_file/folder_item_add_pdf.dart';
import 'package:provider/provider.dart';

import '../../../domain/provider/provider_folder.dart';

class ListFolderAddPdf extends StatelessWidget {
   const ListFolderAddPdf({super.key, required this.pdfModel});
   final PdfModel pdfModel;
   @override
   Widget build(BuildContext context) {
     var listFolders = context.read<ProviderFolder>().listFolder;
     return Container(
         height: 500,
         padding: const EdgeInsets.all(8.0),
         decoration: BoxDecoration(
             border: Border.all(color: Colors.red, width: 2.0),
             borderRadius: BorderRadius.circular(18.0)),
         child: ListView(
             children: listFolders
                 .map((e) =>
                 FolderItemAddPdf(folderModel: e!, pdfModel: pdfModel))
                 .toList()),
       );

     }
   }

