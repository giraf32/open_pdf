import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_folder_pdf.dart';
import 'package:provider/provider.dart';
import '../../../domain/model/pdf_model.dart';

class ChangeCheckBox extends StatefulWidget {
  const ChangeCheckBox({super.key, required this.pdfModel});

  final PdfModel pdfModel;

  @override
  State<ChangeCheckBox> createState() => _ChangeCheckBoxState();
}

class _ChangeCheckBoxState extends State<ChangeCheckBox> {
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isChecked,
      onChanged: (bool? value) {
        if (value == true) {
          context
              .read<ProviderFolderPdf>()
              .setAddPdfListFolder(widget.pdfModel);
          context.read<ProviderFolderPdf>().setTextButton(value!);
        }
        if (value != true) {
          context
              .read<ProviderFolderPdf>()
              .deletePdfListFolder(widget.pdfModel);
          context.read<ProviderFolderPdf>().setTextButton(value!);
        }

        setState(() {
          isChecked = value!;
        });
      },
      title: Text(widget.pdfModel.name),
    );
  }
}
