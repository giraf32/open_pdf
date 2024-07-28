import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_folder.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/widget/widget_pdf_file/pdf_list_item.dart';
import 'package:provider/provider.dart';

class FolderPdfList extends StatelessWidget {
  const FolderPdfList({super.key, required this.nameFolder});
  final String nameFolder;
  @override
  Widget build(BuildContext context) {
    context.read<ProviderFolder>().updateListFolderByName(nameFolder);

    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProviderFolder>(builder: (_, notifier, __) {
          if (notifier.notifierStateFolder == NotifierState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if(notifier.listPdfFileByNameFolder.isNotEmpty){
              return  ListView(
                children: notifier.listPdfFileByNameFolder.map((e) {
                  // if(e == null)return AnimatedText();
                  //TODO null
                  return PdfListItem(pdfModel: e!);
                }).toList(),
              );
            } else {
               return Center(child: Text('В этой папке пока пусто'),);
             }

          }
        }),
      ),
    );
  }
}
