import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';
import 'package:open_pdf/app/domain/provider/provider_folder.dart';
import 'package:provider/provider.dart';

class CreateFolderName extends StatefulWidget {
  const CreateFolderName({super.key});

  @override
  State<CreateFolderName> createState() => _CreateFolderNameState();
}

class _CreateFolderNameState extends State<CreateFolderName> {
  final myController = TextEditingController();
  late FolderModel folderModel;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            labelText: 'Введите имя папки',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black,
            )),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
        controller: myController,
        onSubmitted: (v) {
          folderModel = FolderModel(nameFolder: v);
          context.read<ProviderFolder>().saveFolder(folderModel);
          Navigator.pop(context);
        },
      ),
    );
  }
}
