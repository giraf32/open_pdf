import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';

import 'package:open_pdf/app/ui/widget/widget_pdf_file/menu_button.dart';
import 'package:open_pdf/app/ui/widget/widget_favourites/menu_button_favourites.dart';
import 'package:open_pdf/app/ui/widget/widget_pdf_file/shows_first_page_card.dart';
import 'package:provider/provider.dart';

import '../../../../route/open_pdf.dart';
import '../../../domain/model/pdf_model.dart';

class PdfListItem extends StatelessWidget {
  PdfListItem({super.key, required this.pdfModel});

  final PdfModel pdfModel;

  @override
  Widget build(BuildContext context) {
    File? file;

    return Card(
      elevation: 3,
      color: Theme.of(context).cardColor,
      child: ListTile(
        subtitle: Text(pdfModel.dateTime.toString(),style: TextStyle(fontSize: 12),),
        title: Text(
          pdfModel.name,
          style: TextStyle(fontSize: 14),
        ),
        // subtitle: Text('$dateCreateFile | $sizeFile'),
        onTap: () {
          file = File(pdfModel.path);
          if (file == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Файл не найден')));
          } else {
           // context.read<ProviderPDF>().appBarHide = false;
            if (!context.mounted) return;
            OpenPdfRx().openPDFRoute(context, file!, pdfModel.name);
          }

        },
        trailing: context.read<ProviderPDF>().changeMenuItemFavourites
            ? MenuButtonFavourites(pdfModel: pdfModel)
            : MenuButton(pdfModel: pdfModel),
        leading: ShowsFirstPageCard(
          filePath: pdfModel.path,
        ),

        onLongPress: () {
          //TODO animation show date time , size.
        },
      ),
    );
  }
}
