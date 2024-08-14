// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [FolderList]
class FolderRoute extends PageRouteInfo<void> {
  const FolderRoute({List<PageRouteInfo>? children})
      : super(
          FolderRoute.name,
          initialChildren: children,
        );

  static const String name = 'FolderRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FolderList();
    },
  );
}

/// generated route for
/// [FolderPdfList]
class FolderPdfRoute extends PageRouteInfo<FolderPdfListArgs> {
  FolderPdfRoute({
    Key? key,
    required String nameFolder,
    List<PageRouteInfo>? children,
  }) : super(
          FolderPdfRoute.name,
          args: FolderPdfListArgs(
            key: key,
            nameFolder: nameFolder,
          ),
          initialChildren: children,
        );

  static const String name = 'FolderPdfRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FolderPdfListArgs>();
      return FolderPdfList(
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

  final Key? key;

  final String nameFolder;

  @override
  String toString() {
    return 'FolderPdfListArgs{key: $key, nameFolder: $nameFolder}';
  }
}

/// generated route for
/// [HistoryList]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HistoryList();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [PdfRx]
class PdfRxRoute extends PageRouteInfo<PdfRxArgs> {
  PdfRxRoute({
    Key? key,
    required File file,
    required String name,
    List<PageRouteInfo>? children,
  }) : super(
          PdfRxRoute.name,
          args: PdfRxArgs(
            key: key,
            file: file,
            name: name,
          ),
          initialChildren: children,
        );

  static const String name = 'PdfRxRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PdfRxArgs>();
      return PdfRx(
        key: args.key,
        file: args.file,
        name: args.name,
      );
    },
  );
}

class PdfRxArgs {
  const PdfRxArgs({
    this.key,
    required this.file,
    required this.name,
  });

  final Key? key;

  final File file;

  final String name;

  @override
  String toString() {
    return 'PdfRxArgs{key: $key, file: $file, name: $name}';
  }
}
