import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfRx extends StatefulWidget {
  final File file;
  final String name;
  const PdfRx({Key? key, required this.file, required this.name}) : super(key: key);

  @override
  State<PdfRx> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PdfRx> with WidgetsBindingObserver {
  // final Completer<PDFViewController> _controller =
  //     Completer<PDFViewController>();
  final controller = PdfViewerController();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  // PdfViewerController? controller;

  @override
  Widget build(BuildContext context) {
    // String? pagesLength = controller.pages.length.toString();
    //debugPrint(" $pagesLength");
    // String pagesFirst = controller.pages.first.toString();
    // final text = '${pagesFirst} из $pagesLength';
    return Scaffold(
        appBar: AppBar(
          title:  Text(widget.name,style: TextStyle(fontSize: 16),),
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
            //  IconButton(
            //    icon: const Icon(Icons.first_page),
            //    onPressed: () => controller.goToPage(pageNumber: 1),
            //  ),
            //  IconButton(
            //    icon: const Icon(Icons.last_page),
            //    onPressed: () =>
            //        controller.goToPage(pageNumber: controller.pages.length),
            //  ),
            // Text(pagesLength)
          ],
        ),
        body: PdfViewer.file(
          widget.file.path,
          controller: controller,
          params: PdfViewerParams(
              //  onPageChanged: ,
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
                        // color: Colors.black38,
                        // Show page number on the thumb
                        child: Center(
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              Text(
                                pageNumber.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                 height: 40,
                              ),
                              Icon(Icons.dehaze,color: Colors.black,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
        ));
  }
}
