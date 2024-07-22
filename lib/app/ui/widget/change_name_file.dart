import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/provider_pdf.dart';

class ChangeNameFile extends StatefulWidget {
  const ChangeNameFile({super.key, required this.pdfModel});

  final PdfModel pdfModel;

  @override
  State<ChangeNameFile> createState() => _ChangeNameFileState();
}

class _ChangeNameFileState extends State<ChangeNameFile> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    myController.text = widget.pdfModel.name;

    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      height: 150,
      child: ListView(
        children: [
          TextField(
            autofocus: true,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
            decoration: const InputDecoration(
                labelText: 'Измените имя',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            controller: myController,
            onSubmitted: (v) {
              context.read<ProviderPDF>().updatePdfModelDb(PdfModel(
                  dateTime: widget.pdfModel.dateTime,
                  id: widget.pdfModel.id,
                  path: widget.pdfModel.path,
                  name: v,
                  size: widget.pdfModel.size,
                  favourites: widget.pdfModel.favourites,
                  folder: widget.pdfModel.folder
              ));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
