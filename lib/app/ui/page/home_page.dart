import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app_router/app_router.dart';
import 'package:provider/provider.dart';

import '../../domain/provider/provider_pdf.dart';


@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var indexActive ;


  @override
  Widget build(BuildContext context) {
    // context.read<ProviderPDF>().updatePdfListModelHistory();

    return AutoTabsRouter.pageView(
      routes: [
        HistoryRoute(),
        FolderRoute(),
      ],
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,

          appBar: AppBar(
            //automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Pdf Hub',
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
                    tabsRouter.setActiveIndex(index);
                    debugPrint('index0 $indexActive');
                  });

                  break;
                case 1:
                  setState(() {
                    tabsRouter.setActiveIndex(index);
                    indexActive = index;
                    debugPrint('index1 $indexActive');
                  });

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
            currentIndex: tabsRouter.activeIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'История'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.folder,
                  ),
                  label: 'Папки'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: 'Найти файл'),
            ],
          ),
          body: child,
        );
      },
    );
  }
}
