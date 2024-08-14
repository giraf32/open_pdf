
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../app/ui/page/home_page.dart';
import '../app/ui/viewer_pdf/pdf_rx.dart';
import '../app/ui/widget/widget_folder/folder_list.dart';
import '../app/ui/widget/widget_folder/folder_pdf_list.dart';
import '../app/ui/widget/widget_history/history_list.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/',
          children: [
            AutoRoute(page: HistoryRoute.page , path: 'history'),
            AutoRoute(page: FolderRoute.page , path: 'folder')
          ]
        ),
       AutoRoute(page: FolderPdfRoute.page, path: '/pdfList'),
       AutoRoute(page: PdfRxRoute.page, path: '/pdfRx'),
      ];

}
