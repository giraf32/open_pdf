import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/provider/provider_pdf.dart';
import 'change_name_file.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key, required this.pdfModel});

  final PdfModel pdfModel;
  static const pdfList = <Widget>[Text('folder0'),Text('folder1'),Text('folder2'),Text('folder3'),Text('folder4'),Text('folder5')];
  static const pdfList1 = <String>['folder0','folder1','folder2','folder3','folder4','folder5'];
  @override
  Widget build(BuildContext context) {
  // var listFolder = context.read<ProviderPDF>().getListFolderName();
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
                context.read<ProviderPDF>().savePdfFavourites(pdfModel,context);

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Файл добавлен в избранное'),
                  behavior: SnackBarBehavior.floating,
                ));
              },
              child: Row(
                children: [
                  Icon(Icons.favorite, color: pdfModel.favourites == 1 ? Colors.redAccent : Colors.black,),
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

            // PopupMenuItem(
            //   padding: const EdgeInsets.all(5.0),
            //   onTap: () {
            //    Container(
            //      height: 80,
            //      width: 60,
            //      child: ListView(
            //        children: pdfList
            //      ),
            //    );
            //   },
            //   child: DropdownButton(items: pdfList1, onChanged: onChanged)
            //   // const Row(
            //   //   children: [
            //   //     Icon(Icons.folder_open),
            //   //     SizedBox(width: 10),
            //   //     // TODO create folder
            //   //     Text('В папку'),
            //   //    ]
            //   // ),
            // ),
          ];
        });
  }
}
