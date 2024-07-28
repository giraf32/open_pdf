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
    // myController.text = widget.pdfModel.name;

    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      height: 150,
      child: TextField(
        autofocus: true,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
        decoration: const InputDecoration(
            labelText: 'Введите имя папки',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
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
