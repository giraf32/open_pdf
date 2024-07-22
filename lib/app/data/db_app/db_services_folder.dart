import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/domain/db_api_folder.dart';
import 'package:open_pdf/app/domain/model/folder_model.dart';
import 'package:sqflite/sqflite.dart';

class DbServicesFolder implements DbApiFolder {
  final InitDb initDb;

  DbServicesFolder(this.initDb);

  @override
  Future<void> deleteFolderDb({required int? id}) async {
    final db = await initDb.database;
    await db!.delete('folder', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<FolderModel?>> getListFolderDb() async {
    final db = await initDb.database;
    final List<Map<String, dynamic>> FolderMaps = await db!.query('folder');

    return List.generate(FolderMaps.length, (index) {
      return FolderModel(
        id: FolderMaps[index]['id'],
        nameFolder: FolderMaps[index]['nameFolder'],
      );
    });
  }

  @override
  Future<void> insertFolderDb({required FolderModel folder}) async {
    final db = await initDb.database;
    await db!.insert('folder', folder.toMapPDF(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateFolderDb({required FolderModel folder}) async {
    final db = await initDb.database;
    db!.update('folder', folder.toMapPDF(),
        where: 'id = ?', whereArgs: [folder.id]);
  }
}
