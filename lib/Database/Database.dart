import 'dart:ffi';
import 'dart:io';
import 'package:e_gift_shoppe/DataBaseClasses/Products.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:e_gift_shoppe/DataBaseClasses/userCredentials.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  //Product Constants
  String tableName = 'Product';
  String name = 'name';
  String details = 'details';
  String price = 'price';
  String quantity = 'quantity';
  String id = "id";

  // Admin Credentials
  String adminTableName = 'Credentials';
  String username = 'username';
  String password = 'password';
  String type = 'type';
  String nameUser = 'name';

  Future<Database> get database async => _database ??= await initDB();

  /// Create Data Base
  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}eShop.db';
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $adminTableName ("
          "$username TEXT,"
          "$password TEXT,"
          "$type TEXT,"
          "$nameUser TEXT"
          ")");
      await db.execute("CREATE TABLE $tableName ("
          "$id INTEGER,"
          "$name TEXT,"
          "$details TEXT,"
          "$price TEXT,"
          "$quantity TEXT"
          ")");
    });
  }

// Insert Into DataBase
  Future<int> addNewProduct(Products products) async {
    final db = await database;
    var res = await db.insert(tableName, products.toMap());
    return res;
  }

// Fetch all records
  Future<List<Products>> getAllProducts() async {
    final db = await database;
    var res = await db.query(tableName);
    List<Products> list =
        res.isNotEmpty ? res.map((c) => Products.fromMap(c)).toList() : [];
    print(list.every((element) => true));
    return list;
  }

  //Update Products
  Future<int> updateProducts(Products products) async {
    final db = await database;
    var res = await db.update(tableName, products.toMap(),
        where: "id = ?", whereArgs: [products.id]);
    return res;
  }

  // Delete Product
  deleteProduct(int id) async {
    final db = await database;
    db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  // Delete All Product
  deleteAllProduct() async {
    final db = await database;
    db.rawDelete("Delete * from $tableName");
  }

  // Insert Into Admin DataBase
  Future<int> addUserCredentials(UserCredentials userCredentials) async {
    final db = await database;
    var res = await db.insert(adminTableName, userCredentials.toMap());
    return res;
  }

  //Fetch all user Credentials
  Future<List<UserCredentials>> getAllUserCredentials() async {
    final db = await database;
    var res = await db.query(adminTableName);
    List<UserCredentials> list = res.isNotEmpty
        ? res.map((c) => UserCredentials.fromMap(c)).toList()
        : [];
    return list;
  }
}
