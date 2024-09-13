import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/delete_rename_folder.dart';
import 'package:open_pdf/app_router/app_router.dart';

class FolderViewer extends StatefulWidget {
  FolderViewer({super.key, required this.folderModel}) : _id = folderModel.id;

  final FolderModel folderModel;
  final _id;

  @override
  State<FolderViewer> createState() => _FolderViewerState();
}

class _FolderViewerState extends State<FolderViewer> {


  @override
  Widget build(BuildContext context) {
    // final folderName = widget.folderModel.nameFolder;
    // final providerPdf = context.read<ProviderPDF>();
    // final providerFolder = context.read<ProviderFolder>();

    return ListTile(

      subtitle: Text(widget.folderModel.nameFolder,
          textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
      title: Image.asset('assets/icon_folder.jpg'),

      onTap: () => context.router
          .push(FolderPdfRoute(nameFolder: widget.folderModel.nameFolder)),
      //OpenListPdfFolder().openPDFRoute(context, folderModel.nameFolder),
      onLongPress: () {

        showBottomSheet(
           // isScrollControlled: true,
            context: context,
            builder: (context) =>
                DeleteRenameFolder(id: widget._id, folderModel: widget.folderModel));
      },
    );


  }
}
