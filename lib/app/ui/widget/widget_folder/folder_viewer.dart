import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/delete_rename_folder.dart';
import 'package:open_pdf/app_router/app_router.dart';

class FolderViewer extends StatelessWidget {
  FolderViewer({super.key, required this.folderModel}) : _id = folderModel.id;

  final FolderModel folderModel;
  final _id;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading:
      subtitle: Text(folderModel.nameFolder,
          textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
      title: Image.asset('assets/icon_folder.jpg'),
      // title: Image.asset('assets/icon_3.jpg'),
      // title: Icon(
      //   Icons.folder,
      //   color: Colors.amberAccent,
      // size: 100,
      // ),
      onTap: () => context.router
          .push(FolderPdfRoute(nameFolder: folderModel.nameFolder)),
      //OpenListPdfFolder().openPDFRoute(context, folderModel.nameFolder),
      onLongPress: () {
        showModalBottomSheet(
            // backgroundColor: Colors.grey.shade300,
            context: context,
            builder: (context) =>
                DeleteRenameFolder(id: _id, folderModel: folderModel));
      },
    );

// Image.asset('assets/folder.png'),
  }
}
