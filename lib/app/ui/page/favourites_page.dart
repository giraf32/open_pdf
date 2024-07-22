import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';

import 'package:open_pdf/app/ui/widget/pdf_list_favourites.dart';
import 'package:open_pdf/route/open_pdf.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key, required this.title});

  final String title;

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  bool position = true;

  @override
  Widget build(BuildContext context) {
    // debugPrint('position $position');
    // context.read<ProviderPDF>().updatePDFListModel();
    // context.read<ProviderPDF>().updatePDFListModelFavourites();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        initialActiveIndex: 2,
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
             Navigator.of(context).pop();

              break;
            case 1:
              context.read<ProviderPDF>().addListPdfFileFromDeviceStorage(context);

              break;
            case 2:

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
          child: PDFListFavourites()),
    );
  }
}
