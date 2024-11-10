
import 'package:auto_route/auto_route.dart';
import 'package:open_pdf/app_router/app_router.gr.dart';


@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/',
          children: [
            AutoRoute(page: HistoryList.page , path: 'history'),
            AutoRoute(page: FolderList.page , path: 'folder')
          ]
        ),
       AutoRoute(page: FolderPdfList.page, path: '/pdfList'),
       AutoRoute(page: PdfRx.page, path: '/pdfRx'),
      ];

}
