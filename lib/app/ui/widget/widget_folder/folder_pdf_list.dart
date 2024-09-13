import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/add_pdf_folder.dart';
import 'package:open_pdf/app/ui/widget/widget_pdf_file/pdf_list_item.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FolderPdfList extends StatelessWidget {
  const FolderPdfList({super.key, required this.nameFolder});

  final String nameFolder;

  @override
  Widget build(BuildContext context) {
    context.read<ProviderPDF>().updateListFolderByName(nameFolder);
   // context.watch<ProviderPDF>().updateListFolderByName(widget.nameFolder);

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          nameFolder,
          style: const TextStyle(color: Colors.white),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade400,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => AddPdfFolder(folderName: nameFolder,));

        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProviderPDF>(builder: (_, notifier, __) {
          if (notifier.notifierStateListPdfFolder == NotifierState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (notifier.listPdfFileByNameFolder.isNotEmpty) {
              return ListView(
                children: notifier.listPdfFileByNameFolder.map((e) {
                  return PdfListItem(pdfModel: e!);
                }).toList(),
              );
            } else {
              return Center(
                child: Text('В этой папке пока пусто'),
              );
            }
          }
        }),
      ),
    );
  }
}
