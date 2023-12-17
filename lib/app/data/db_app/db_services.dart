import 'dart:async';

import 'package:open_pdf/app/domain/db_api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/model/model_pdf.dart';

class DbServices implements DbApi {
  DbServices._();
  static final DbServices db = DbServices._();
  static Database? _database;

  @override
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  @override
  initDB() async {
    try {
      return await openDatabase(
        join(await getDatabasesPath(), 'pdf_database'),
        onCreate: (Database db, version) async {
          return await db.execute(
              'CREATE TABLE pdf (id INTEGER PRIMARY KEY, path TEXT, name TEXT, favourites INTEGER, dateTime TEXT)');
        },
        version: 1,
      );
    } catch (ex) {
      print(ex);
    }
  }

  // @override
  // Future<void> initDB() async {
  //   if (db != null) return;
  //   try {
  //     db = await openDatabase(
  //       join(await getDatabasesPath(), 'pdf_database'),
  //       onCreate: (Database db, version) async {
  //         return await db.execute(
  //             'CREATE TABLE pdf (id INTEGER PRIMARY KEY, path TEXT, name TEXT)');
  //       },
  //       version: 1,
  //     );
  //   } catch (ex) {
  //     print(ex);
  //   }
  // }

  @override
  Future<int?> insertPDF({required PDFModel pdfModel}) async {
    final db = await database;
    final id = await db!.insert('pdf', pdfModel.toMapPDF(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  @override
  Future<List<PDFModel>> getPDFList() async {
    final db = await database;
    final List<Map<String, dynamic>> pdfMaps = await db!.query('pdf');

    return List.generate(pdfMaps.length, (index) {
      return PDFModel(
          id: pdfMaps[index]['id'],
          path: pdfMaps[index]['path'],
          name: pdfMaps[index]['name'],
          favourites: pdfMaps[index]['favourites'],
          dateTime: pdfMaps[index]['dateTime']);
    });
  }

  @override
  Future<void> deletePDF({required int? id}) async {
    final db = await database;
    await db!.delete('pdf', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> updatePDF({required PDFModel pdfModel}) async {
    await _database?.update('pdf', pdfModel.toMapPDF(),
        where: 'id = ?', whereArgs: [pdfModel.id]);
  }
}
