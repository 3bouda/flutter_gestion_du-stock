import 'package:bouda/models/materiel.dart';
import 'package:bouda/models/borrowed.dart';
import 'package:bouda/services/config/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Materielservice {
  static Future<bool> add(Materiel mat) async {
    Database db = await Mydatabase.getDatabase();
    List<Map> material = await db.query("MATERIEL",
        where: "nomMateriel=? and quantite=? and dateAcquisition=? and nomF=?",
        whereArgs: [
          mat.nomMateriel,
          mat.quantite,
          mat.dateAcqui!.microsecondsSinceEpoch,
          mat.nomF
        ]);
    if (material.isEmpty) {
      await db.insert("MATERIEL", mat.toMap());
      return true;
    }
    return false;
  }

  static Future<List<Materiel>> getAllMaterial() async {
    Database db = await Mydatabase.getDatabase();
    List<Map<String, Object?>> mapMaterial = await db.query("MATERIEL");
    List<Materiel> allMaterial = [];
    mapMaterial
        .forEach((element) => allMaterial.add(Materiel.fromMap(element)));
    return allMaterial;
  }

  static Future<bool> borrowMaterial(Borrowed bor, Materiel mat) async {
    Database db = await Mydatabase.getDatabase();
    mat.quantite = mat.quantite! - bor.quantite!;
    await db.insert("BORROW", bor.toMap());
    await db.update("MATERIEL", mat.toMap(), where: "id = ?", whereArgs: [mat.id]);
    return true;
  }

  static Future<List<Borrowed>> getAllBorrowed() async {
    Database db = await Mydatabase.getDatabase();
    List<Map<String, Object?>> mapBorrowed = await db.query("BORROW");
    List<Borrowed> allBorrowed = [];
    mapBorrowed.forEach((element) => allBorrowed.add(Borrowed.fromMap(element)));
    return allBorrowed;
  }

  static Future<Materiel> getMaterialById(int id) async {
    Database db = await Mydatabase.getDatabase();
    List<Map<String, Object?>> map =
        await db.query("MATERIEL", where: "id = ?", whereArgs: [id]);
    return Materiel.fromMap(map.first);
  }

  static Future<List<Materiel>> getMaterialByNomF(String nomF) async {
    Database db = await Mydatabase.getDatabase();
    List<Map<String, dynamic>> materials =
        await db.query("MATERIEL", where: "nomF = ?", whereArgs: [nomF]);
    List<Materiel> allMaterial = [];
    materials.forEach((element) => allMaterial.add(Materiel.fromMap(element)));
    return allMaterial;
  }

  static Future<bool> returnBorrow(Borrowed bor) async {
    Database db = await Mydatabase.getDatabase();
    await db
        .update("BORROW", bor.toMap(), where: "id = ?", whereArgs: [bor.id]);
    return true;
  }
}
