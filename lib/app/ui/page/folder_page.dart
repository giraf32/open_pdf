

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/create_folder_name.dart';
import 'package:open_pdf/app/ui/widget/widget_folder/folder_list.dart';



class FolderPage extends StatelessWidget {
  FolderPage({super.key});


  final int _indexActive = 0;
  final String _title = 'Папки';
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        key: _globalKey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade400,
          child: Icon(Icons.add,color: Colors.black,),
          onPressed: () {
            this
                ._globalKey
                .currentState
                ?.showBottomSheet(backgroundColor: Theme.of(context).cardColor , (c) => CreateFolderName());
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: ConvexAppBar(
          // controller: controller ,
          style: TabStyle.reactCircle,
          backgroundColor: Theme.of(context).primaryColor,
          initialActiveIndex: _indexActive,
          // curveSize: 80,
          // height: 80,
          top: -16,
          items: const [
            TabItem(icon: Icons.folder),
            TabItem(icon: Icons.access_time_outlined),
            TabItem(icon: Icons.add),
            TabItem(icon: Icons.favorite),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                // context.read<ProviderPDF>().changeMenuItemFavourites = false;
                //   setState(() {
                //     indexActive = 0;
                //     debugPrint('index0 $indexActive');
                //   });
                break;
              case 1:
                // setState(() {
                //   indexActive = 1;
                //   debugPrint('index1 $indexActive');
                // });
                break;
              case 2:

                // context.read<ProviderPDF>().addListPdfFileFromDeviceStorage(context);
                // setState(() {
                //   indexActive = 1;
                //   debugPrint('index2 $indexActive');
                // });
                break;
              case 3:
                // OpenPdfScreenFavourites().openPDFRoute(context);
                //   setState(() {
                //     indexActive = 2;
                //     debugPrint('index3 $indexActive');
                //   });
                break;
            }
          },
        ),
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            _title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: FolderList()

     );

  }
}
