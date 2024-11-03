import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:open_pdf/app/domain/provider/provider_folder_pdf.dart';
import 'package:open_pdf/utility/pdf_function.dart';
import 'package:provider/provider.dart';



class ChangeNameFileFolder extends StatefulWidget {
  const ChangeNameFileFolder({super.key, required this.pdfModel});

  final PdfModel pdfModel;

  @override
  State<ChangeNameFileFolder> createState() => _ChangeNameFileFolderState();
}

class _ChangeNameFileFolderState extends State<ChangeNameFileFolder> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final namePdf = formatterNamePdf(widget.pdfModel.name, true);
    myController.text = namePdf;

    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(18.0)),
      height: 150,
      child: TextField(
        autofocus: true,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
        decoration: const InputDecoration(
            labelText: 'Измените имя файла',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                )),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        controller: myController,
        onSubmitted: (v) {
          var name = formatterNamePdf(v, false);
          context.read<ProviderFolderPdf>().updatePdfFolderModelDb(PdfModel(
              dateTime: widget.pdfModel.dateTime,
              id: widget.pdfModel.id,
              path: widget.pdfModel.path,
              name: name,
              size: widget.pdfModel.size,
              favourites: widget.pdfModel.favourites,
              folder: widget.pdfModel.folder
          ));
          Navigator.pop(context);
        },
      ),
    );
  }
}
