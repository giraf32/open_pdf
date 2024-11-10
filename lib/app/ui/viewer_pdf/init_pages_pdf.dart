import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_pdf/app/domain/model/pdf_model.dart';
import 'package:open_pdf/app/domain/provider/provider_pdf.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:provider/provider.dart';

class InitPagesPdf extends StatefulWidget {
  InitPagesPdf({super.key, required this.pdfModel, required this.file});

  final PdfModel pdfModel;
  final File file;

  @override
  State<InitPagesPdf> createState() => _InitPagesPdfState();
}

class _InitPagesPdfState extends State<InitPagesPdf> {
  late final Future<int> future;
  final controller = PdfViewerController();
  bool isPortrait = true;
  String errorMessage = '';
  ProviderPDF? providerPdf;
  // int? _pages = 1;
  int myPagesNumber = 1;

  @override
  void initState() {
    super.initState();
    providerPdf = context.read<ProviderPDF>();
    // _pages;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
        future: context.read<ProviderPDF>().getPageNumber(widget.pdfModel),
        builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
          // List<Widget> children;
          if (snapshot.hasData) {
            //  context.router.push(PdfRxRoute(file: file, name: pdfModel.name));
            return PdfViewer.file(
              widget.file.path,
              controller: controller,
              initialPageNumber: snapshot.data!,
              params: PdfViewerParams(
                  onViewSizeChanged: (viewSize, oldViewSize, controller) {
                    if (oldViewSize != null) {
                      final centerPosition =
                          controller.value.calcPosition(oldViewSize);
                      final newMatrix =
                          controller.calcMatrixFor(centerPosition);
                      Future.delayed(const Duration(milliseconds: 200), () {
                        controller.goTo(newMatrix);
                      });
                    }
                  },
                  viewerOverlayBuilder: (context, size, handleLinkTap) => [
                        PdfViewerScrollThumb(
                            controller: controller,
                            orientation: ScrollbarOrientation.right,
                            thumbSize: const Size(
                              40,
                              100,
                            ),
                            thumbBuilder:
                                (context, thumbSize, pageNumber, controller) {
                              myPagesNumber = pageNumber!;
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        pageNumber.toString(),
                                        style: const TextStyle(
                                            color: Colors.black),
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
                              );
                            }),
                      ]),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  @override
  void dispose() {
    debugPrint('MyPagesNumber ======= $myPagesNumber');
   // PdfModel newPdfModel = widget.pdfModel.copyWith(pageNumber: myPagesNumber);
    providerPdf?.updatePageNumber(myPagesNumber, widget.pdfModel);
    super.dispose();
  }
}
