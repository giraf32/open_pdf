import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class ShowsFirstPageCard extends StatelessWidget {
  final String filePath;

  //final PdfDocument pdfDocument =  PdfDocument.openFile(filePath) as PdfDocument;
  const ShowsFirstPageCard({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    // final document = PdfDocument.openFile(filePath);
    return PdfDocumentViewBuilder.file(filePath,
        builder: (context, document) => Container(
              margin: const EdgeInsets.all(2.0),
              // padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1.0, color: Colors.black26),
              ),
              height: 70,
              width: 40,
              child: PdfPageView(
                document: document,
                pageNumber: 1,
                alignment: Alignment.topCenter,
                // maximumDpi: 200,
              ),
            ));
  }
}
