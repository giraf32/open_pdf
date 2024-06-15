import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/widget/pdf_list_item.dart';
import 'package:provider/provider.dart';

class PDFListFavourites extends StatelessWidget {
  const PDFListFavourites({super.key});

  @override
  Widget build(BuildContext context) {
     context.read<ProviderPDF>().changeMenuItemFavourites = true;
    // context.read<ProviderPDF>().updatePDFListFile();
    return Consumer<ProviderPDF>(builder: (_, notifier, __) {
      if (notifier.notifierState == NotifierState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView(
          children: notifier.pdfListFavourites.map((e) {
            return PdfListItem(pdfModel: e!);
          }).toList(),
        );
      }
    });
  }
}
