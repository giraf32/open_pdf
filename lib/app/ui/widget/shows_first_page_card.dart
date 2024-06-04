import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class ShowsFirstPageCard extends StatelessWidget {
  final String filePath;

  // final PdfDocument pdfDocument =  PdfDocument.openFile(filePath);
  const ShowsFirstPageCard({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: const EdgeInsets.all(2.0),
       // padding: const EdgeInsets.all(1.0),
        decoration:  BoxDecoration(
         // borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1.0, color: Colors.black26),
        ),
        height: 70,
        width: 40,
        child: PdfDocumentLoader.openFile(
          filePath,
          pageNumber: 1,
        ),
    );







    //   Padding(
    //   padding: const EdgeInsets.all(1.0),
    //   child: Center(
    //     child: PdfDocumentLoader.openFile(
    //       filePath,
    //       pageNumber: 1,
    //     ),
    //   ),
    // );
    //PdfDocumentViewBuilder.file(filePath, builder: builder);
  }
}
