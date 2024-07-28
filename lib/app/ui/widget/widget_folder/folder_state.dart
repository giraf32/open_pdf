import 'package:flutter/material.dart';
import 'package:open_pdf/route/open_pdf.dart';
import 'package:provider/provider.dart';

import '../../../domain/provider/provider_folder.dart';

class FolderState extends StatelessWidget {
  const FolderState({super.key, required this.nameFolder});
  final String nameFolder;
  @override
  Widget build(BuildContext context) {


    return Consumer<ProviderFolder>(builder: (_, notifier, __) {
          if (notifier.notifierStateTab == NotifierStateTab.show) {
            return OpenListPdfFolder().openPDFRoute(context, nameFolder) as Widget;
          } else {
            if (notifier.notifierStateTab == NotifierStateTab.add) {
              return Text('');
            } else {
              return Text('');
            }
          }
        });


  }
}
