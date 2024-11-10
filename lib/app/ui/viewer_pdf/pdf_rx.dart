import 'dart:io';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:open_pdf/app/ui/viewer_pdf/init_pages_pdf.dart';
import 'package:pdfrx/pdfrx.dart';

@RoutePage()
class PdfRx extends StatefulWidget {
  final File file;
  final PdfModel pdfModel;

  const PdfRx({Key? key, required this.file, required this.pdfModel})
      : super(key: key);

  @override
  State<PdfRx> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PdfRx> with WidgetsBindingObserver {
  final controller = PdfViewerController();

  bool isPortrait = true;
  String errorMessage = '';
  double? _toolbarHeight = 50;
  late int myPagesNumber;

  _deleteToolBar() {
    _toolbarHeight = 0;
  }

  _showToolBar() {
    _toolbarHeight = 50;
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) _deleteToolBar();
    if (orientation == Orientation.portrait && context.mounted) _showToolBar();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          toolbarHeight: _toolbarHeight,
          title: Text(
            widget.pdfModel.name,
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.zoom_in,
                color: Colors.red,
                size: 40,
              ),
              onPressed: () => controller.zoomUp(),
            ),
            IconButton(
              icon: const Icon(
                Icons.zoom_out,
                color: Colors.blue,
                size: 40,
              ),
              onPressed: () => controller.zoomDown(),
            ),
          ],
        ),
         body: InitPagesPdf(file: widget.file,pdfModel: widget.pdfModel,)
      // PdfViewer.file(
        //   widget.file.path,
        //   controller: controller,
        //   initialPageNumber: _pages,
        //   params: PdfViewerParams(
        //       onViewSizeChanged: (viewSize, oldViewSize, controller) {
        //         if (oldViewSize != null) {
        //           final centerPosition =
        //               controller.value.calcPosition(oldViewSize);
        //           final newMatrix = controller.calcMatrixFor(centerPosition);
        //           Future.delayed(const Duration(milliseconds: 200), () {
        //             controller.goTo(newMatrix);
        //           });
        //         }
        //       },
        //       viewerOverlayBuilder: (context, size, handleLinkTap) => [
        //             PdfViewerScrollThumb(
        //                 controller: controller,
        //                 orientation: ScrollbarOrientation.right,
        //                 thumbSize: const Size(
        //                   40,
        //                   100,
        //                 ),
        //                 thumbBuilder:
        //                     (context, thumbSize, pageNumber, controller) {
        //                   myPagesNumber = pageNumber!;
        //                   return Container(
        //                     decoration: BoxDecoration(
        //                       color: Colors.black26,
        //                       borderRadius: BorderRadius.circular(5),
        //                     ),
        //                     child: Center(
        //                       child: Column(
        //                         crossAxisAlignment: CrossAxisAlignment.center,
        //                         children: [
        //                           Text(
        //                             pageNumber.toString(),
        //                             style: const TextStyle(color: Colors.black),
        //                           ),
        //                           SizedBox(
        //                             height: 40,
        //                           ),
        //                           Icon(
        //                             Icons.dehaze,
        //                             color: Colors.black,
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   );
        //                 }),
        //           ]),
        // )
    );
  }


}
