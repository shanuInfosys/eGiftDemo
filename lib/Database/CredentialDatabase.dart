// import 'dart:io';
// import 'package:e_gift_shoppe/DataBaseClasses/userCredentials.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';

// class AdminDBProvider {
//   AdminDBProvider._();
//   static final AdminDBProvider db = AdminDBProvider._();

//   static Database? _database;
//   // Admin Credentials
//   String adminTableName = 'Credentials';
//   String username = 'username';
//   String password = 'password';
//   String type = 'type';

//   Future<Database> get database async => _database ??= await initDB();

//   /// Create Data Base
  // Future<Database> initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   // String path = join(documentsDirectory.path, "TestDB.db");
  //   String path = '${documentsDirectory.path}eShop.db';
  //   return await openDatabase(path, version: 1, onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //     await db.execute("CREATE TABLE $adminTableName ("
  //         "$username TEXT,"
  //         "$password TEXT,"
  //         "$type TEXT"
  //         ")");
          
  //   });
  // }

//   // Insert Into Admin DataBase
//   Future<int> addUserCredentials(UserCredentials userCredentials) async {
//     final db = await database;
//     var res = await db.insert(adminTableName, userCredentials.toMap());
//     return res;
//   }

//   //Fetch all user Credentials
//   Future<List<UserCredentials>> getAllUserCredentials() async {
//     final db = await database;
//     var res = await db.query(adminTableName);
//     List<UserCredentials> list = res.isNotEmpty
//         ? res.map((c) => UserCredentials.fromMap(c)).toList()
//         : [];
//     print(list.every((element) => true));
//     return list;
//   }
// }
