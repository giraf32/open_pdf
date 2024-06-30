import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/widget/animated_text.dart';
import 'package:open_pdf/app/ui/widget/pdf_list_item.dart';
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
        if(notifier.pdfModelListHistory.isNotEmpty){
          return  ListView(
            children: notifier.pdfModelListHistory.map((e) {
             // if(e == null)return AnimatedText();
              //TODO null
              return PdfListItem(pdfModel: e!);
            }).toList(),
          );
        } else {
          return AnimatedText();
        }

      }
    });
  }
}
