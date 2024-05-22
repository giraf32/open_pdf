import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';

import 'package:open_pdf/app/ui/widget/menu_button.dart';
import 'package:open_pdf/app/ui/widget/menu_button_favourites.dart';
import 'package:open_pdf/app/ui/widget/shows_first_page_card.dart';
import 'package:provider/provider.dart';

import '../../../route/open_pdf.dart';
import '../../domain/model/model_pdf.dart';

class PdfItem extends StatelessWidget {
  PdfItem({super.key, required this.pdfModel});

  final PDFModel pdfModel;

  @override
  Widget build(BuildContext context) {
    File? file;
   // final String dateCreateFile = pdfModel.dateTime.toString();
   // final String sizeFile = pdfModel.size.toString();

    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        //subtitle: Text(pdfModel.dateTime.toString()),
        title: Text(pdfModel.name),
       // subtitle: Text('$dateCreateFile | $sizeFile'),
        onTap: () {
          file = File(pdfModel.path);
          if (!file!.existsSync()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Файл не найден')));
          }
          if (!context.mounted) return;
         // context.read<ProviderPDF>().changeOpenPdf
               OpenPdfRx().openPDFRoute(context, file!);
          //OpenPdfViewer().openPDFRoute(context, file!);
        },
        trailing: context.read<ProviderPDF>().changeMenuItemFavourites
            ? MenuButtonFavourites(pdfModel: pdfModel)
            : MenuButton(pdfModel: pdfModel),
        leading: ShowsFirstPageCard(filePath: pdfModel.path,),

        onLongPress: () {},
      ),
    );
  }
}
