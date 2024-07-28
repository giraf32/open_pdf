import 'package:flutter/material.dart';
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
    return Container(
       // color: Colors.white,
        height: 200,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(18.0)),
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
                    onPressed: () {
                      context.read<ProviderFolder>().deleteFolder(id);
                      Navigator.pop(context);
                      //TODO delete pdf file from Folder
                    },
                    child: Text('Удалить',
                        style: TextStyle(fontSize: 18, color: Colors.red))),
                ElevatedButton(
                    onPressed: () {},
                    child: Text('Переименовать',
                        style: TextStyle(fontSize: 18, color: Colors.black))),
              ],
            ),
          ],
        ));
  }
}
