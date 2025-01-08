import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/app_const.dart';
import 'package:open_pdf/app/app_key_value.dart';
import 'package:open_pdf/app_router/app_router.gr.dart';
import 'package:open_pdf/route/open_pdf.dart';
import 'package:provider/provider.dart';
import '../../domain/provider/provider_pdf.dart';
import '../../settings/donate.dart';
import '../../settings/settings_app.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var indexActive;
   late int indexList;
  // var listFirstPages = <PageRouteInfo> [];
  late List<PageRouteInfo> listFirstPages;

  // var listNavigationBarItems = <BottomNavigationBarItem> [];
  late List<BottomNavigationBarItem> listNavigationBarItems;

  @override
  void initState() {
    if (AppKeyValue.settingsValueFirstPages == NAME_FIRST_PAGES_FOLDER) {
      indexList = 1;
      listFirstPages = [FolderList(), HistoryList()];
      listNavigationBarItems = [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.folder,
            ),
            label: 'Папки'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'История'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Найти файл'),
      ];
    } else {
      indexList = 0;
      listFirstPages = [HistoryList(), FolderList()];
      listNavigationBarItems = [
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'История'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.folder,
            ),
            label: 'Папки'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Найти файл'),
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<ProviderPDF>().updatePdfListModelHistory();

    return AutoTabsRouter.pageView(
      routes: listFirstPages,
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            foregroundColor: Colors.white,
            //automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'pdf Hub',
              style: const TextStyle(color: Colors.white),
            ),
            actions: [AppBarMenuButton()],
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
                    setState(() {
                      tabsRouter.setActiveIndex(indexList);
                      indexActive = index;
                      debugPrint('index2 $indexActive');
                    });
                    context
                        .read<ProviderPDF>()
                        .addListPdfFileFromDeviceStorage(context);
                    break;
                }
              },
              currentIndex: tabsRouter.activeIndex,
              items: listNavigationBarItems),
          body: Padding(
            padding: const EdgeInsets.all(6.0),
            child: child,
          ),
        );
      },
    );
  }
}

class AppBarMenuButton extends StatelessWidget {
  const AppBarMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: Colors.white,
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              padding: const EdgeInsets.all(5.0),
              onTap: () {
                showModalBottomSheet(
                    // backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => SettingsApp());
              },
              child: const Row(
                children: [
                  Icon(Icons.settings, color: Colors.black45),
                  SizedBox(width: 10),
                  Text('Настройки'),
                ],
              ),
            ),
            PopupMenuItem(
             // padding: const EdgeInsets.all(20.0),
              onTap: () {
                showModalBottomSheet(
                    //  backgroundColor: Colors.white,
                    context: context,
                    builder: (context) => Donate());
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.done_outline,
                    color: Colors.black45,
                  ),
                  SizedBox(width: 10),
                  Text('Donate')
                ],
              ),
            ),
            PopupMenuItem(
              // padding: const EdgeInsets.all(20.0),
              onTap: () {
                OpenInfo().openInfoAppRoute(context);
              //   showModalBottomSheet(
              //       backgroundColor: Colors.white,
              //       context: context,
              //       builder: (context) => InfoApp());
               },
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.black45,
                  ),
                  SizedBox(width: 10),
                  Text('О приложении')
                ],
              ),
            ),
          ];
        });
  }
}
