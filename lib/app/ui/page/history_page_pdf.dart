import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/page/folder_page.dart';
import 'package:open_pdf/app/ui/widget/widget_history/pdf_list_history.dart';
import 'package:open_pdf/app/ui/widget/widget_favourites/pdf_list_favourites.dart';
import 'package:open_pdf/route/open_pdf.dart';

import 'package:provider/provider.dart';


class HistoryPagePdf extends StatefulWidget {
  const HistoryPagePdf({super.key, required this.title});

  final String title;


  @override
  State<HistoryPagePdf> createState() => _HistoryPagePdfState();
}

class _HistoryPagePdfState extends State<HistoryPagePdf> {
  int indexActive = 1;


  @override
  Widget build(BuildContext context) {

   // context.read<ProviderPDF>().updatePdfListModelHistory();

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: ConvexAppBar(
         // controller: controller ,
          style: TabStyle.reactCircle,
          backgroundColor: Theme.of(context).primaryColor,
          initialActiveIndex: indexActive,
          // curveSize: 80,
          // height: 80,
          top: -16,
          items: const [
          //    TabItem(title: 'Дом', icon: Icons.home),
          //   TabItem(title: 'Просмотренные', icon: Icons.access_time_outlined),
          //   TabItem(title: 'Найти файл', icon: Icons.add),
          //   TabItem(title: 'Избранные', icon: Icons.favorite),
            TabItem(icon: Icons.folder),
            TabItem(icon: Icons.access_time_outlined),
            TabItem(icon: Icons.add),
            TabItem(icon: Icons.favorite),

          ],
          onTap: (index) {
            switch (index) {
              case 0:
                OpenFolder().openPDFRoute(context);
                setState(() {
                 // indexActive = 0;
                });
                break;
              case 1:
                setState(() {
                  indexActive = 1;
                  debugPrint('index1 $indexActive');
                });
                break;
              case 2:
                context.read<ProviderPDF>().addListPdfFileFromDeviceStorage(context);
                setState(() {
                  indexActive = 1;
                  debugPrint('index2 $indexActive');
                });
                break;
              case 3:
               // OpenPdfScreenFavourites().openPDFRoute(context);
                setState(() {
                  indexActive = 2;
                  debugPrint('index3 $indexActive');
                });
                break;
            }
          },
        ),
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          // child: PDFViewerList(),
          // child: position ? PDFList() : PDFListFavourites()),
          child: getWidget(indexActive)
          //PDFListHistory(),
        ));
  }

  Widget getWidget(int index){
    var listPdfPage = <Widget> [FolderPage(),PDFListHistory(),PDFListFavourites()];
    return listPdfPage[index];
  }
}


