

import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class ShowsFirstPageCard extends StatelessWidget {
  final String filePath;
   ShowsFirstPageCard({super.key, required this.filePath});
  //final size = Size(40, 70);
 // final pages = PdfPage;
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
              //  pageSizeCallback: v(Size(70, 40)) ,
                // maximumDpi: 200,
              ),
            ));
  }

  v (Size size ) {
  // var pageHeight = page.height ;
  // var pageWidth = page.width ;
   var widgetHeight = size.height;
   var widgetWidth = size.width;
   return Size(widgetWidth, widgetHeight);
 }
}
