import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/delete_rename_folder.dart';
import 'package:open_pdf/route/open_pdf.dart';





class FolderViewer extends StatelessWidget {
   FolderViewer({super.key, required this.folderModel}) : _id = folderModel.id ;

  final FolderModel folderModel;
  final _id ;
  @override
  Widget build(BuildContext context) {
    // var state = context.watch<ProviderFolder>().notifierStateTab;
    //final deletePdf = context.watch<ProviderFolder>().notifierDeletePdfFolder;
    return ListTile(
     // leading:
      subtitle: Text(folderModel.nameFolder,
          textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
      title:Icon(
      Icons.folder,
      color: Colors.amberAccent,
    size: 100,
    ),
      onTap:() => OpenListPdfFolder().openPDFRoute(context, folderModel.nameFolder),
      onLongPress: (){
        showModalBottomSheet(
          backgroundColor: Colors.grey.shade300,
            context: context,
            builder: (context) => DeleteRenameFolder(id: _id, folderModel: folderModel));
      } ,
    );



  }

}
