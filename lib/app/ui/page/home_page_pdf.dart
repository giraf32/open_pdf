import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:open_pdf/app/ui/widget/pdf_list.dart';
import 'package:open_pdf/app/ui/widget/pdf_list_favourites.dart';
import 'package:provider/provider.dart';

class HomePagePdf extends StatefulWidget {
  const HomePagePdf({super.key, required this.title});

  final String title;

  @override
  State<HomePagePdf> createState() => _HomePagePdfState();
}

class _HomePagePdfState extends State<HomePagePdf> {
  bool position = true;

  @override
  Widget build(BuildContext context) {
    debugPrint('position $position');
    context.read<ProviderPDF>().updatePDFListModel();
    context.read<ProviderPDF>().updatePDFListModelFavourites();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        // initialActiveIndex: position,
        items: const [
          // TabItem(title: 'Избранное', icon: Icons.add_card),
          TabItem(title: 'Просмотренные', icon: Icons.access_time_outlined),
          TabItem(title: 'Найти файл', icon: Icons.add),
          TabItem(title: 'Избранные', icon: Icons.favorite),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
             // context.read<ProviderPDF>().changeMenuItemFavourites = false;
              setState(() {
                position = true;
                debugPrint('position3 $position');

              });
              break;
            case 1:
              context.read<ProviderPDF>().addAndOpenPdf(context);
              setState(() {
                position = true;
              });
              break;
            case 2:

              setState(() {
                position = false;
                debugPrint('position2 $position');
                //context.read<ProviderPDF>().updatePDFListModelFavourites();
              });
              break;
          }
        },
        style: TabStyle.react,
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
          child: position ? PDFList() : PDFListFavourites()),
    );
  }
}
