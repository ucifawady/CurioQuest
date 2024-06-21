// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DatabaseHelper {
//   static final _databaseName = "myDatabase.db";
//   static final _databaseVersion = 1;
//
//   DatabaseHelper._privateConstructor();
//
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//
//   static Database? _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   _initDatabase() async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, _databaseName);
//     return await openDatabase(path,
//         version: _databaseVersion,
//         onCreate: _onCreate);
//   }
//
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE User(
//         id INTEGER PRIMARY KEY,
//         firstName TEXT,
//         lastName TEXT,
//         email TEXT,
//         password TEXT,
//         birthDate TEXT
//       )
//     ''');
//   }
//
//   Future<User?> login(String email, String password) async {
//     final db = await instance.database;
//     final result = await db.query(
//       'User',
//       where: 'email = ? AND password = ?',
//       whereArgs: [email, password],
//     );
//     if (result.isNotEmpty) {
//       return User.fromMap(result.first);
//     }
//     return null;
//   }
//
//   Future<void> insertUser(User user) async {
//     final db = await instance.database;
//     await db.insert('User', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
//   }
// }
//
// class User {
//   final int? id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String password;
//   final String birthDate;
//
//   User({
//     this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.password,
//     required this.birthDate,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'password': password,
//       'birthDate': birthDate,
//     };
//   }
//
//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['id'],
//       firstName: map['firstName'],
//       lastName: map['lastName'],
//       email: map['email'],
//       password: map['password'],
//       birthDate: map['birthDate'],
//     );
//   }
// }
//