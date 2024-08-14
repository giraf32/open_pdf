

import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/folder_list.dart';
import 'package:open_pdf/app/ui/widget/widget_history/history_list.dart';
import 'package:provider/provider.dart';


class HistoryPagePdf extends StatefulWidget {
  const HistoryPagePdf({super.key, required this.title});

  final String title;

  @override
  State<HistoryPagePdf> createState() => _HistoryPagePdfState();
}

class _HistoryPagePdfState extends State<HistoryPagePdf> {
  var indexActive = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // context.read<ProviderPDF>().updatePdfListModelHistory();

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey.shade400,
          onTap: (index) {
            switch (index) {
              case 0:
// OpenFolder().openPDFRoute(context);
                setState(() {
                  indexActive = index;
                  debugPrint('index0 $indexActive');
                });
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear);
                break;
              case 1:
                setState(() {
                  indexActive = index;
                  debugPrint('index1 $indexActive');
                });
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear);
                break;
              case 2:
                context
                    .read<ProviderPDF>()
                    .addListPdfFileFromDeviceStorage(context);
// setState(() {
//   indexActive = 1;
//   debugPrint('index2 $indexActive');
// });
                break;
            }
          },
          currentIndex: indexActive,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.history),label: 'История'),
            BottomNavigationBarItem(icon: Icon(Icons.folder,),label: 'Папки'),
            BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Найти файл'),
          ],
        ),
        body: PageView (
          onPageChanged: (v) {
            setState(() {
              indexActive = v;
            });
          },
          controller: _pageController,
          children: [
            HistoryList(),
            FolderList()
          ],
        )

        // Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     // child: PDFViewerList(),
        //     // child: position ? PDFList() : PDFListFavourites()),
        //     child: _getWidget(indexActive)
        //     //PDFListHistory(),
        //  )
        );
  }
}
//---------------------------------------

// ConvexAppBar(
// // controller: TabController(length: length, vsync: vsync) ,
// style: TabStyle.reactCircle,
// backgroundColor: Theme.of(context).primaryColor,
// initialActiveIndex: indexActive,
// // curveSize: 80,
// // height: 80,
// top: -16,
// items: const [
// TabItem(icon: Icons.folder),
// TabItem(icon: Icons.access_time_outlined),
// TabItem(icon: Icons.add),
// // TabItem(icon: Icons.favorite),
// ],
// onTap: (index) {
// switch (index) {
// case 0:
// // OpenFolder().openPDFRoute(context);
// setState(() {
// indexActive = index;
// debugPrint('index0 $indexActive');
// });
// _pageController.animateToPage(index, duration: const Duration(milliseconds: 300),
// curve: Curves.linear);
// break;
// case 1:
// setState(() {
// indexActive = index;
// debugPrint('index1 $indexActive');
// });
// _pageController.animateToPage(index, duration: const Duration(milliseconds: 300),
// curve: Curves.linear);
// break;
// case 2:
// context
//     .read<ProviderPDF>()
//     .addListPdfFileFromDeviceStorage(context);
// // setState(() {
// //   indexActive = 1;
// //   debugPrint('index2 $indexActive');
// // });
// break;
//
// }
// },
// ),

// Widget _getWidget(int index) {
//   var listPdfPage = <Widget>[FolderList(), PDFListHistory()];
//   return listPdfPage[index];
// }
