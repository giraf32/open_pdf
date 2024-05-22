import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;

  const PDFViewerPage({super.key, required this.file});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFViewController? controller;
  int? pages = 0;
  int? indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage! + 1} из $pages';
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return IconButton(
          //       icon: const Icon(Icons.label_important_outline),
          //       onPressed: () async {
          //         // final file = await PdfRepository(dbServices: DbServices.db).addFilePDF();
          //         // if (file == null) return;
          //         // if (!context.mounted) return;
          //         // OpenPDF().openPDFRoute(context, file);
          //        await context.read<ProviderPDF>().addAndOpenPdf(context);
          //       },
          //       // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          //     );
          //   },
          // ),
          title: Text(name),
          actions: pages! >= 2
              ? <Widget>[
                  Center(child: Text(text)),
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 32,
                    ),
                    onPressed: () {
                      int? page = indexPage == 0 ? pages : indexPage! - 1;
                      controller?.setPage(page!);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 32,
                    ),
                    onPressed: () {
                      int? page = indexPage == pages! - 1 ? 0 : indexPage! + 1;
                      controller?.setPage(page);
                    },
                  ),
                ]
              : null),
      body: PDFView(
        //swipeHorizontal: true,
        filePath: widget.file.path,
        //fitEachPage: false,
        // autoSpacing: false,
       // pageSnap: false,
        // pageFling: false,
        onRender: (pages) => setState(() {
          this.pages = pages;
        }),
        onViewCreated: (controller) => setState(() {
          this.controller = controller;
        }),
        onPageChanged: (indexPage, _) => setState(() {
          this.indexPage = indexPage;
        }),
      ),
    );
  }
}
