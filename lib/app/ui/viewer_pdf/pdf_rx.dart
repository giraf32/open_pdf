import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfRx extends StatefulWidget {
  final File file;
  final String name;

  const PdfRx({Key? key, required this.file, required this.name})
      : super(key: key);

  @override
  State<PdfRx> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PdfRx> with WidgetsBindingObserver {
  // final Completer<PDFViewController> _controller =
  //     Completer<PDFViewController>();
  final controller = PdfViewerController();


  // final controllerV = ValueNotifier(_value);

  int? pages = 0;
  int? currentPage = 0;

  // bool isReady = false;
  bool isPortrait = true;
  String errorMessage = '';

  double ? _toolbarHeight = 50;
 // double ? _AppBarConceal = null;

  _deleteToolBar(){
     _toolbarHeight = 0;
    //  controller.relayout();
   // debugPrint('valueToolBar  = $_toolbarHeight');
  }
  _showToolBar(){
    _toolbarHeight = 50;
   // controller.relayout();
  }

  @override
  Widget build(BuildContext context) {
    //  isPortrait = context.watch<ProviderPDF>().appBarHide;
    // if(!isPortrait) _deleteToolBar();
    var orientation = MediaQuery.of(context).orientation;
   // var orientationSize = MediaQuery.of(context).size;
    if  (orientation == Orientation.landscape) _deleteToolBar();
    if(orientation == Orientation.portrait && context.mounted) _showToolBar();
    // // String? pagesLength = controller.pages.length.toString();
    //debugPrint(" $pagesLength");
    // String pagesFirst = controller.pages.first.toString();
    // final text = '${pagesFirst} из $pagesLength';
    return Scaffold(
        //extendBodyBehindAppBar: true,
        // extendBody: ,
        appBar: AppBar(
         // elevation: 100,
          backgroundColor: Colors.grey.shade300,
          // toolbarOpacity: ,
          toolbarHeight: _toolbarHeight ,
          title: Text(
            widget.name,
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
        body: PdfViewer.file(
          widget.file.path,
          controller: controller,
          params: PdfViewerParams(
            onViewSizeChanged: (viewSize, oldViewSize, controller) {
              if (oldViewSize != null) {
                // The most important thing here is that the transformation matrix
                // is not changed on the view change.
             // final d =  orientationSize.width;
              // var sizeW = viewSize.width;
              // final sizeO = oldViewSize.height;
                final centerPosition =
                controller.value.calcPosition(oldViewSize);
                final newMatrix =
                controller.calcMatrixFor(centerPosition);

                // Don't change the matrix in sync; the callback might be called
                // during widget-tree's build process.
                Future.delayed(
                  const Duration(milliseconds: 200),
                      () {
                    controller.goTo(newMatrix);

                  }
                );
              }
            },
              viewerOverlayBuilder: (context, size) => [
                    PdfViewerScrollThumb(
                      controller: controller,
                      orientation: ScrollbarOrientation.right,
                      thumbSize: const Size(
                        40,
                        100,
                      ),
                      thumbBuilder:
                          (context, thumbSize, pageNumber, controller) =>
                              Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                pageNumber.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Icon(
                                Icons.dehaze,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
        ));
  }
}
