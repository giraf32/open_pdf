import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/model_pdf.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/provider/provider_pdf.dart';
import 'change_name_file.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key, required this.pdfModel});

  final PDFModel pdfModel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              padding: const EdgeInsets.all(5.0),
              onTap: () {
                context.read<ProviderPDF>().deleteFilePdf(pdfModel);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Файл удалён'),
                  behavior: SnackBarBehavior.floating,
                ));
              },
              child: const Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 10),
                  Text('Удалить'),
                ],
              ),
            ),
            PopupMenuItem(
              padding: const EdgeInsets.all(5.0),
              onTap: () {
                context.read<ProviderPDF>().savePdfFavourites(pdfModel);

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Файл добавлен в избранное'),
                  behavior: SnackBarBehavior.floating,
                ));
              },
              child: const Row(
                children: [
                  Icon(Icons.favorite),
                  SizedBox(width: 10),
                  Text('В избранное')
                ],
              ),
            ),
            PopupMenuItem(
              padding: const EdgeInsets.all(5.0),
              onTap: () {
                Share.shareXFiles([XFile(pdfModel.path)]);
              },
              child: const Row(
                children: [
                  Icon(Icons.share),
                  SizedBox(width: 10),
                  Text('Отправить')
                ],
              ),
            ),
            PopupMenuItem(
              padding: const EdgeInsets.all(5.0),
              onTap: () {
                showBottomSheet(
                    backgroundColor: Theme.of(context).cardColor,
                    context: context,
                    builder: (context) {
                      return ChangeNameFile(pdfModel: pdfModel);
                    });
              },
              child: const Row(
                children: [
                  Icon(Icons.drive_file_rename_outline),
                  SizedBox(width: 10),
                  Text('Переименовать')
                ],
              ),
            ),
            PopupMenuItem(
              padding: const EdgeInsets.all(5.0),
              onTap: () {
                context.read<ProviderPDF>().changeOpenPdf = false;
              },
              child: const Row(
                children: [
                  Icon(Icons.folder_open),
                  SizedBox(width: 10),
                  Text('Открыть PDF')
                ],
              ),
            ),
          ];
        });
  }
}
