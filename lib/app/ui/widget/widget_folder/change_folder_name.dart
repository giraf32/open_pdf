import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';
import 'package:open_pdf/app/domain/provider/provider_folder.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:provider/provider.dart';

class ChangeFolderName extends StatefulWidget {
  const ChangeFolderName({super.key, required this.folderModel});

  final FolderModel folderModel;

  @override
  State<ChangeFolderName> createState() => _ChangeFolderNameState();
}

class _ChangeFolderNameState extends State<ChangeFolderName> {
  final myController = TextEditingController();
  late FolderModel folderModel;
  late FolderModel newFolderModel;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerPdf = context.read<ProviderPDF>();
    final providerFolder = context.read<ProviderFolder>();
    myController.text = widget.folderModel.nameFolder;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(18.0)),
      alignment: Alignment.center,
      height: 150,
      child: TextField(
        cursorColor: Colors.black,
        //cursorHeight: 20,
        autofocus: true,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
        decoration: const InputDecoration(
          labelStyle: TextStyle(color: Colors.black, fontSize: 20),
          labelText: 'Введите новое имя папки',
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.black,
          )),
        ),
        controller: myController,
        onSubmitted: (v) async {
          folderModel = widget.folderModel;
          newFolderModel = widget.folderModel.copyWith(nameFolder: v);
          await providerFolder.updateFolder(newFolderModel);
          await providerPdf.changeFolder(
              nameFolder: folderModel.nameFolder,
              newNameFolder: newFolderModel.nameFolder);

          Navigator.pop(context);
        },
      ),
    );
  }
}
