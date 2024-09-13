import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:provider/provider.dart';


import '../../../domain/model/pdf_model.dart';


class ChangeCheckBox extends StatefulWidget {
  const ChangeCheckBox({super.key, required this.pdfModel});
  final PdfModel pdfModel ;
  @override
  State<ChangeCheckBox> createState() => _ChangeCheckBoxState();
}

class _ChangeCheckBoxState extends State<ChangeCheckBox> {
  bool isChecked = false;
  var pdfListFavourites = <PdfModel?>[];

  @override
  Widget build(BuildContext context) {


    return CheckboxListTile(
      value: isChecked,
      onChanged: (bool? value) {
       // pdfListFavourites.add(listPdfFolders[index]);
       // context.read<ProviderPDF>().listPdfAdd.add(widget.pdfModel);
      if(value == true){
        context.read<ProviderPDF>().setPdfAdd(widget.pdfModel);}
        setState(() {
          isChecked = value!;
         // context.read<ProviderPDF>().listPdfAdd.add(widget.pdfModel);
          // ScaffoldMessenger.of(context).showSnackBar(
          // SnackBar(
          //     content: Text('добавить '),
          //     action: SnackBarAction(
          //       label: 'OK',
          //       onPressed: () {
          //
          //       },
          //     ));
          // );
        });

      },
      title: Text(widget.pdfModel.name),
    );
  }
}
