import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';

import 'package:open_pdf/app/ui/widget/menu_button.dart';
import 'package:open_pdf/app/ui/widget/menu_button_favourites.dart';
import 'package:provider/provider.dart';

import '../../../route/open_pdf.dart';
import '../../domain/model/model_pdf.dart';

class PdfItem extends StatelessWidget {
  PdfItem({super.key, required this.pdfModel});

  final PDFModel pdfModel;

  @override
  Widget build(BuildContext context) {
    File? file;

    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        subtitle: Text(pdfModel.dateTime.toString()),
        title: Text(pdfModel.name),
        onTap: () {
          file = File(pdfModel.path);
          if (!file!.existsSync()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Файл не найден')));
          }
          if (!context.mounted) return;
          context.read<ProviderPDF>().changeOpenPdf
              ? OpenPdfViewer().openPDFRoute(context, file!)
              : OpenPdfScreen().openPDFRoute(context, file!);
        },
        trailing: context.read<ProviderPDF>().changeMenuItemFavourites
            ? MenuButtonFavourites(pdfModel: pdfModel)
            : MenuButton(pdfModel: pdfModel),
        leading: Icon(
          Icons.file_present,
          color: Colors.red.shade300,
        ),
        onLongPress: () {},
      ),
    );
  }
}
