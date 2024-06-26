import 'dart:async';

import 'package:open_pdf/app/data/db_app/init_db.dart';
import 'package:open_pdf/app/domain/db_api.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/model/model_pdf.dart';

class DbServices implements DbApi {
  final InitDb initDb;

  DbServices(this.initDb);

  @override
  Future<void> insertPdfDb({required PdfModel pdfModel}) async {
    final db = await initDb.database;
    await db!.insert('pdf', pdfModel.toMapPDF(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<PdfModel>> getPdfListDb() async {
    final db = await initDb.database;
    final List<Map<String, dynamic>> pdfMaps = await db!.query('pdf');

    return List.generate(pdfMaps.length, (index) {
      return PdfModel(
        id: pdfMaps[index]['id'],
        path: pdfMaps[index]['path'],
        name: pdfMaps[index]['name'],
        favourites: pdfMaps[index]['favourites'],
        dateTime: pdfMaps[index]['dateTime'],
        size: pdfMaps[index]['size'],
      );
    });
  }

  @override
  Future<void> deletePdfDb({required int? id}) async {
    final db = await initDb.database;
    await db!.delete('pdf', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> updatePdfDb({required PdfModel pdfModel}) async {
    final db = await initDb.database;
    db!.update('pdf', pdfModel.toMapPDF(),
        where: 'id = ?', whereArgs: [pdfModel.id]);
  }
}
