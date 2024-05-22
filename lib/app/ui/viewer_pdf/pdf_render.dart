import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfRender extends StatefulWidget {
  final File? file;

  const PdfRender({Key? key, this.file}) : super(key: key);

  @override
  State<PdfRender> createState() => _PdfRenderState();
}

class _PdfRenderState extends State<PdfRender> with WidgetsBindingObserver {
  int? pages = 0;
  int? currentPage = 1;
  bool isReady = false;
  String errorMessage = '';
  int? indexPage = 0;
  late TextEditingController _controller;
  PdfViewerController? _controllerPdf;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controllerPdf = PdfViewerController();
  }

  @override
  void dispose() {
    _controller.dispose();
   // _controllerPdf?.dispose();
    super.dispose();
  }

  //_controllerPdf = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    String? name = basename(widget.file!.path);

    // final text = '${indexPage! + 1} of $pages';

    // final text = '$pages's
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        actions: <Widget>[
          // Text(text),
          SizedBox(
            height: 30,
            width: 100,
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,fontSize: 16),
                //Theme.of(context).textTheme.bodyMedium,
              keyboardType: TextInputType.number,
              controller: _controller,
              onSubmitted: (String value) {
               // value.isEmpty ? currentPage = 1 :
                currentPage = int.parse(value);

                _controllerPdf?.ready?.goToPage(pageNumber: currentPage ?? 1);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: '№ страницы',
                labelStyle: TextStyle(color: Colors.white),


              ),
            ),
          ),
          IconButton(
              onPressed: () =>
                  _controllerPdf?.ready?.goToPage(pageNumber: currentPage = int.parse(_controller.text)),
              icon: Icon(Icons.last_page,color: Colors.white,))

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     FloatingActionButton(
          //       child: Icon(Icons.first_page),
          //       onPressed: () => controller?.ready?.goToPage(pageNumber: 1),
          //     ),
          //     IconButton(
          //         onPressed: () => controller?.ready
          //             ?.goToPage(pageNumber: controller?.pageCount ?? 1),
          //         icon: Icon(Icons.last_page))
          //   ],
          // ),
        ],
      ),
      //body:  PdfViewer.openFile(widget.file!.path),
      body: PdfViewer.openFile(widget.file!.path,
          viewerController: _controllerPdf,
          params: PdfViewerParams(
              // buildPagePlaceholder: ,
              // pageNumber: currentPage ,
              // onViewerControllerInitialized: (PdfViewerController c) {
              //controller = c;
              // pages = controller?.pageCount;
              // context.read<ProviderPDF>().setPages(pages);

              //}
              )),
    );
  }
}
