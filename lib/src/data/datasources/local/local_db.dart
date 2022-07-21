import 'dart:async';
import 'package:routinechecker/src/presentation/providers/routine_state.dart';
import 'package:sqflite/sqflite.dart';
class LocalDB {
  late Database database;
  late RoutineState routineState;


  LocalDB._privateConstructor() {
    routineState = RoutineState();

  }

  static final LocalDB _instance = LocalDB._privateConstructor();

  factory LocalDB() => _instance;

  FutureOr<void> loadDb() async {
    var dbPath = await getDatabasesPath();
    String fullPath = "$dbPath/routine_local_db";

    database = await openDatabase(fullPath, version: 1, onCreate: _onCreateDB);

    routineState.load(database);

  }

  void _onCreateDB(Database db, version) async {
    // await db.execute('''CREATE TABLE recently_viewed (
    //   id INTEGER PRIMARY KEY AUTOINCREMENT,
    //   imageUrl TEXT NOT NULL,
    //   title TEXT NOT NULL,
    //   amount REAL NOT NULL,
    //   rating REAL NOT NULL,
    //   percentageDiscount INTEGER NOT NULL,
    //   productID TEXT NOT NULL)''');

    // await db.execute('''CREATE TABLE cart_db (
    //   id INTEGER PRIMARY KEY AUTOINCREMENT,
    //   image TEXT NOT NULL,
    //   title TEXT NOT NULL,
    //   productId TEXT NOT NULL,
    //   price REAL NOT NULL,
    //   totalPrice REAL NOT NULL,
    //   quantity INTEGER NOT NULL)''');
  }

  Future<void> clear() async {
    await routineState.clear();
  }

  void deleteDb() async {
    var dbPath = await getDatabasesPath();
    String fullPath = "$dbPath/twizll_local_db";
    await deleteDatabase(fullPath);
  }
}