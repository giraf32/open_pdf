import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_folder_pdf.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/add_pdf_folder.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/item_card_pdf_folder.dart';
import 'package:open_pdf/app/ui/widget/widget_pdf_file/pdf_list_item.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FolderPdfList extends StatefulWidget {
  const FolderPdfList({super.key, required this.nameFolder});

  final String nameFolder;

  @override
  State<FolderPdfList> createState() => _FolderPdfListState();
}

class _FolderPdfListState extends State<FolderPdfList> {
  @override
  void initState() {
    Future.microtask(() => context
        .read<ProviderFolderPdf>()
        .updateListFolderByName(widget.nameFolder));
    //  context.read<ProviderFolderPdf>().updateListFolderByName(widget.nameFolder);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  context.read<ProviderFolderPdf>().updateListFolderByName(widget.nameFolder);
    // context.watch<ProviderPDF>().updateListFolderByName(widget.nameFolder);

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.nameFolder,
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
              builder: (context) => AddPdfFolder(
                    folderName: widget.nameFolder,
                  ));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProviderFolderPdf>(builder: (context, notifier, __) {
          if (notifier.notifierUpdatePdfFolder ==
              NotifierUpdatePdfFolder.initial) {
            return const Center(
              child: Text('Ожидайте'),
            );
          }

          if (notifier.notifierUpdatePdfFolder ==
                  NotifierUpdatePdfFolder.loading
              // ||
              // notifier.notifierStateListPdfFolder == NotifierStateListPdfFolder.loading
              ) {
            //   notifier.notifierStateListAddPdfFolder == NotifierState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // if (notifier.notifierStateListPdfFolder == NotifierState.loaded &&
            //     notifier.listPdfFileByNameFolder.isNotEmpty)
            if (notifier.listPdfFileByNameFolder.isNotEmpty) {
              return ListView(
                children: notifier.listPdfFileByNameFolder.map((e) {
                  return ItemCardPdfFolder(pdfModel: e!);
                }).toList(),
              );
            } else {
              return Center(
                child: Text('В этой папке пока пусто'),
              );
              // }
            }
          }

          // if (notifier.notifierUpdatePdfFolder ==
          //         NotifierUpdatePdfFolder.loading ||
          //     notifier.notifierStateListPdfFolder ==
          //         NotifierStateListPdfFolder.loading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // // if (notifier.notifierUpdatePdfFolder == NotifierUpdatePdfFolder.loaded)
          // if (notifier.notifierStateListPdfFolder ==
          //     NotifierStateListPdfFolder.getListAdd) {
          //   var pdfListFavourites =
          //       context.read<ProviderFolderPdf>().listPdfAddFolder;
          //   debugPrint('listCheckBox _______________ $pdfListFavourites');
          //
          //   context
          //       .read<ProviderFolderPdf>()
          //       .saveFileFolder(pdfListFavourites, context, widget.nameFolder);
          //   context.read<ProviderFolderPdf>().clearListPdfAddFolder();
          // }
          // if (notifier.listPdfFileByNameFolder.isNotEmpty) {
          //   return ListView(
          //     children: notifier.listPdfFileByNameFolder.map((e) {
          //       return PdfListItem(pdfModel: e!);
          //     }).toList(),
          //   );
          // }
          // return Center(
          //   child: Text('В этой папке пока пусто'),
          // );
        }),
      ),
    );
  }
}
