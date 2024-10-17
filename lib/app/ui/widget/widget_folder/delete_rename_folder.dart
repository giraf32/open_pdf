import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_folder_pdf.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/change_folder_name.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/folder_model.dart';
import '../../../domain/provider/provider_folder.dart';

class DeleteRenameFolder extends StatelessWidget {
  const DeleteRenameFolder(
      {super.key, required this.id, required this.folderModel});

  final int id;
  final FolderModel folderModel;

  @override
  Widget build(BuildContext context) {
    final folderName = folderModel.nameFolder;
    final providerPdf = context.read<ProviderFolderPdf>();
    final providerFolder = context.read<ProviderFolder>();
    return Container(
        height: 200,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border.all(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          children: [
            Text(
              'Папка: $folderName',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 20),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await providerPdf.deletePdfFromFolder(folderName);
                      await providerFolder.deleteFolder(id);
                      Navigator.pop(context);
                      //TODO delete pdf file from Folder
                    },
                    child: Text('Удалить',
                        style: TextStyle(fontSize: 18, color: Colors.red))),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showBottomSheet(
                          backgroundColor: Colors.grey.shade300,
                          context: context,
                          builder: (context) =>
                              ChangeFolderName(folderModel: folderModel));
                    },
                    child: Text('Переименовать',
                        style: TextStyle(fontSize: 18, color: Colors.black))),
              ],
            ),
          ],
        ));
  }
}
