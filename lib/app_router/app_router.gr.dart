// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i8;

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:open_pdf/app/domain/model/pdf_model.dart' as _i9;
import 'package:open_pdf/app/ui/page/home_page.dart' as _i4;
import 'package:open_pdf/app/ui/viewer_pdf/pdf_rx.dart' as _i5;
import 'package:open_pdf/app/ui/widget/widget_folder/folder_list.dart' as _i1;
import 'package:open_pdf/app/ui/widget/widget_folder/folder_pdf_list.dart'
    as _i2;
import 'package:open_pdf/app/ui/widget/widget_history/history_list.dart' as _i3;

/// generated route for
/// [_i1.FolderList]
class FolderList extends _i6.PageRouteInfo<void> {
  const FolderList({List<_i6.PageRouteInfo>? children})
      : super(
          FolderList.name,
          initialChildren: children,
        );

  static const String name = 'FolderList';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.FolderList();
    },
  );
}

/// generated route for
/// [_i2.FolderPdfList]
class FolderPdfList extends _i6.PageRouteInfo<FolderPdfListArgs> {
  FolderPdfList({
    _i7.Key? key,
    required String nameFolder,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          FolderPdfList.name,
          args: FolderPdfListArgs(
            key: key,
            nameFolder: nameFolder,
          ),
          initialChildren: children,
        );

  static const String name = 'FolderPdfList';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FolderPdfListArgs>();
      return _i2.FolderPdfList(
        key: args.key,
        nameFolder: args.nameFolder,
      );
    },
  );
}

class FolderPdfListArgs {
  const FolderPdfListArgs({
    this.key,
    required this.nameFolder,
  });

  final _i7.Key? key;

  final String nameFolder;

  @override
  String toString() {
    return 'FolderPdfListArgs{key: $key, nameFolder: $nameFolder}';
  }
}

/// generated route for
/// [_i3.HistoryList]
class HistoryList extends _i6.PageRouteInfo<void> {
  const HistoryList({List<_i6.PageRouteInfo>? children})
      : super(
          HistoryList.name,
          initialChildren: children,
        );

  static const String name = 'HistoryList';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.HistoryList();
    },
  );
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomePage();
    },
  );
}

/// generated route for
/// [_i5.PdfRx]
class PdfRx extends _i6.PageRouteInfo<PdfRxArgs> {
  PdfRx({
    _i7.Key? key,
    required _i8.File file,
    required _i9.PdfModel pdfModel,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          PdfRx.name,
          args: PdfRxArgs(
            key: key,
            file: file,
            pdfModel: pdfModel,
          ),
          initialChildren: children,
        );

  static const String name = 'PdfRx';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PdfRxArgs>();
      return _i5.PdfRx(
        key: args.key,
        file: args.file,
        pdfModel: args.pdfModel,
      );
    },
  );
}

class PdfRxArgs {
  const PdfRxArgs({
    this.key,
    required this.file,
    required this.pdfModel,
  });

  final _i7.Key? key;

  final _i8.File file;

  final _i9.PdfModel pdfModel;

  @override
  String toString() {
    return 'PdfRxArgs{key: $key, file: $file, pdfModel: $pdfModel}';
  }
}
