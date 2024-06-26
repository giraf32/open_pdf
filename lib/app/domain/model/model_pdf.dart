class PdfModel {
  final int? id;
  final String path;
  final String name;
  final String dateTime;
  final String size;
  final int favourites;

  PdfModel({
    this.id,
    required this.path,
    required this.name,
    required this.favourites,
    required this.dateTime,
    required this.size,
  });

  Map<String, dynamic> toMapPDF() {
    return {
      'id': id,
      'path': path,
      'name': name,
      'favourites': favourites,
      'dateTime': dateTime,
      'size': size
    };
  }

  @override
  String toString() {
    return 'PDFModel{id: $id, path: $path, name: $name, favourites: $favourites, dateTime: $dateTime, size: $size}';
  }
}
