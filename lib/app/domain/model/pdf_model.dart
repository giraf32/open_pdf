class PdfModel {
  final int? id;
  final String path;
  final String name;
  final String dateTime;
  final String size;
  final String folder;
  final int favourites;

  PdfModel({
    this.id,
    required this.path,
    required this.name,
    required this.favourites,
    required this.dateTime,
    required this.size,
    required this.folder,
  });

  Map<String, dynamic> toMapPDF() {
    return {
      'id': id,
      'path': path,
      'name': name,
      'favourites': favourites,
      'dateTime': dateTime,
      'size': size,
      'folder': folder,
    };
  }

  @override
  String toString() {
    return 'PDFModel{id: $id, path: $path, name: $name, favourites: $favourites, dateTime: $dateTime, size: $size, folder: $folder}';
  }

  PdfModel copyWith({
     int? id,
     String? path,
     String? name,
     String? dateTime,
     String? size,
     String? folder,
     int? favourites,

  }) {
    return PdfModel(
        id: id ?? this.id,
        path: path ?? this.path ,
        name: name ?? this.name,
        favourites: favourites ?? this.favourites,
        dateTime: dateTime ?? this.dateTime,
        size: size ?? this.size,
        folder: folder ?? this.folder
    );
  }
}
