import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/provider_pdf.dart';

Future<void> showAlertDialogPdf(
    BuildContext context, List<PdfModel?> listPdf) async {
  final provider = context.read<ProviderPDF>();
  final nameFile = listPdf.first?.name;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Файл c таким именем уже был добавлен',
          style: TextStyle(fontSize: 18),
        ),
        content: Text(nameFile ?? 'name file'),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                // context.read<ProviderPDF>().addAndOpenPdf(context);
              },
              child: const Text('добавить', style: TextStyle(fontSize: 16))),
          TextButton(
              onPressed: () async {
             await  provider.deleteFilePdfAfterCompare(listPdf);
                Navigator.pop(context);
              },
              child: Text(
                'заменить',
                style: TextStyle(fontSize: 16),
              )),
        ],
      );
    },
  );
}
