import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/widget/list_folder.dart';
import 'package:open_pdf/app/ui/widget/pdf_list_history.dart';
import 'package:open_pdf/app/ui/widget/pdf_list_favourites.dart';

import 'package:provider/provider.dart';

class HomePagePdf extends StatefulWidget {
  const HomePagePdf({super.key, required this.title});

  final String title;


  @override
  State<HomePagePdf> createState() => _HomePagePdfState();
}

class _HomePagePdfState extends State<HomePagePdf> {
 // bool position = true;
 // final listPdfPage = <Widget> [ListFolder(),PDFListHistory(),PDFListFavourites()];
  int indexActive = 1;
  @override
  Widget build(BuildContext context) {
   // debugPrint('position $position');
    //TabStyle tabStyle = TabStyle.reactCircle;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: ConvexAppBar(
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
                // context.read<ProviderPDF>().changeMenuItemFavourites = false;
                setState(() {
                  indexActive = 0;
                  debugPrint('index0 $indexActive');
                });
                break;
              case 1:
                setState(() {
                  indexActive = 1;
                  debugPrint('index1 $indexActive');
                });
                break;
              case 2:
                context.read<ProviderPDF>().addListFilePdfFromStorage(context);
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
    var listPdfPage = <Widget> [ListFolder(),PDFListHistory(),PDFListFavourites()];
    return listPdfPage[index];
  }
}


