import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/model_pdf.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/provider_pdf.dart';

Future<void> showAlertDialogPdf(
    BuildContext context, List<PdfModel?> listPdf) async {
  final provider = context.read<ProviderPDF>();
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text(
          'Файл c таким именем уже был добавлен',
          style: TextStyle(fontSize: 18),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                // context.read<ProviderPDF>().addAndOpenPdf(context);
              },
              child: const Text('добавить', style: TextStyle(fontSize: 16))),
          TextButton(
              onPressed: () async {
                if (listPdf.isNotEmpty) await {
                  listPdf.forEach((element) {
                    provider.deleteFilePdf(element!);
                  })
                };
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
