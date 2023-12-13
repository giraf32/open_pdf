class PDFModel {
  final int? id;
  final String path;
  final String name;
  final String? dateTime;
  int? favourites;

  PDFModel({this.id, required this.path, required this.name,required this.favourites,this.dateTime});

  Map<String, dynamic> toMapPDF() {
    return {'id': id, 'path': path, 'name': name,'favourites': favourites, 'dateTime': dateTime};
  }

  @override
  String toString() {
    return 'PDFModel{id: $id, path: $path, name: $name, favourites: $favourites, dateTime: $dateTime}';
  }
}
