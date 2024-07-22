import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';

class FolderViewer extends StatelessWidget {
  const FolderViewer({super.key, required this.nameFolder});
  final FolderModel nameFolder;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          // splashRadius: 5,
          onPressed: () {
            // FolderPdfList(nameFolder: 'name folder');
          },
          icon: Icon(
            Icons.folder,
            color: Colors.amberAccent,
          ),
          iconSize: 120,
        ),
        // SizedBox(height: 5,),
        Text(
          nameFolder.nameFolder,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ],

    );
  }
}
