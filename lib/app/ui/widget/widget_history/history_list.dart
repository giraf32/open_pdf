import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/widget/widget_history/animated_text.dart';
import 'package:open_pdf/app/ui/widget/widget_pdf_file/pdf_list_item.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {

   // context.read<ProviderPDF>().changeMenuItemFavourites = false;
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
