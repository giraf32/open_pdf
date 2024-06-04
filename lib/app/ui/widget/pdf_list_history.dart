import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/widget/pdf_item.dart';
import 'package:provider/provider.dart';

class PDFListHistory extends StatelessWidget {
  const PDFListHistory({super.key});

  @override
  Widget build(BuildContext context) {

    context.read<ProviderPDF>().changeMenuItemFavourites = false;
   // context.read<ProviderPDF>().updatePDFListFile();
    return Consumer<ProviderPDF>(builder: (_, notifier, __) {
      if (notifier.notifierState == NotifierState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView(
          children: notifier.pdfModelList.map((e) {
            return PdfItem(pdfModel: e!);
          }).toList(),
        );
      }
    });
  }
}
