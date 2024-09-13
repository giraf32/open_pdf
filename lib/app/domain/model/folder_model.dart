class FolderModel {
  final int? id;
  final String nameFolder;

  FolderModel({
    this.id,
    required this.nameFolder,
  });

  Map<String, dynamic> toMapPDF() {
    return {
      'id': id,
      'nameFolder': nameFolder,
    };
  }

  @override
  String toString() {
    return 'PDFModel{id: $id,nameFolder: $nameFolder}';
  }

  FolderModel copyWith({
    int? id,
    String? nameFolder,
  }) {
    return FolderModel(
      id: id ?? this.id,
      nameFolder: nameFolder ?? this.nameFolder,
    );
  }
}
