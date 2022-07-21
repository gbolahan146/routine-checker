import 'package:flutter/material.dart';
import 'package:routinechecker/main.dart';
import 'package:routinechecker/src/core/utils/helpers.dart';
import 'package:routinechecker/src/data/datasources/local/local_storage.dart';
import 'package:routinechecker/src/data/models/routine_model.dart';
import 'package:routinechecker/src/presentation/providers/notification_service.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:jiffy/jiffy.dart';

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

class RoutineState extends ChangeNotifier {
  static final String tableName = "routines";

  late Database db;

  bool _stateBusy = false;
  bool get stateBusy => _stateBusy;

  String _userName = '';
  String get userName => _userName;
  String _userEmail = '';
  String get userEmail => _userEmail;

  List<RoutineModel> listOfRoutines12 = [];
  List<RoutineModel> listOfRoutines = [];

  void load(Database database) {
    db = database;
  }

  fetchUserDetails() async {
    _userEmail = await LocalStorage.getItem("userEmail");
    _userName = await LocalStorage.getItem("name");
    notifyListeners();
  }

  Future<List<RoutineModel>> fetchRoutines() async {
    var records = await db.rawQuery('SELECT * from $tableName');
    var items = records.map((e) => RoutineModel.fromMap(e)).toList();
    var tempList = List<RoutineModel>.from(items.reversed);
    listOfRoutines = tempList;

    notifyListeners();
    return listOfRoutines;
  }

  Future<List<RoutineModel>> fetchUnder12Routines() async {
    var records = await db.rawQuery('SELECT * from $tableName');
    var items = records.map((e) => RoutineModel.fromMap(e)).toList();
    var tempList = List<RoutineModel>.from(items.reversed);
    // final Duration durdef = DateTime.now().difference(Dur);
    // print("${durdef.inHours} Hours");

    for (var i = 0; i < tempList.length; i++) {
      Jiffy((DateTime.parse(tempList[i].createdAt)))
          .startOf(Units.HOUR)
          .fromNow();
      if ((tempList[i].frequency == 'Hourly' ||
              tempList[i].frequency == 'Daily') &&
          (TimeOfDay.fromDateTime((DateTime.parse(tempList[i].createdAt)))
                      .hourOfPeriod *
                  num.parse(tempList[i].time ?? '0') <
              12)) {
        listOfRoutines12.add(tempList[i]);
      }
    }
    listOfRoutines12.sort((b, a) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
    return listOfRoutines12;
  }

  Future<RoutineModel?> createNewRoutine(RoutineModel routineModel) async {
    try {
      _stateBusy = true;
      Future.delayed(Duration(seconds: 2), () {});
      var records = await db.rawQuery('SELECT * from $tableName');
      var listOfRecords = records.map((e) => RoutineModel.fromMap(e)).toList();

      var existingItem = listOfRecords
          .firstWhereOrNull((element) => element.id == routineModel.id);

      if (existingItem == null) {
        await db.insert(
          tableName,
          routineModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        logger.d("item inserted");
      }
      showSuccessToast(message: 'Routine Created Successfully ');

      NotificationService.sendPeriodNotification();
      fetchRoutines();
      return routineModel;
    } catch (e) {
      return null;
    } finally {
      _stateBusy = false;
      notifyListeners();
    }
  }

  Future<int> updateRoutine(RoutineModel routineModel, String id) async {
    int count = await db.update(tableName, routineModel.toMap(),
        where: 'id = $id', whereArgs: [routineModel.title]);

    fetchRoutines();
    showSuccessToast(message: 'Routine Updated Successfully ');

    return count;
  }

  Future<int> deleteRoutine(RoutineModel routineModel, int id) async {
    int count = await db
        .delete(tableName, where: 'id = $id', whereArgs: [routineModel.title]);
    showSuccessToast(message: 'Routine Deleted Successfully ');
    fetchRoutines();
    return count;
  }

  void sendEmailNotification(String? text) async {
    var token = await LocalStorage.getItem("token");
    final smptServer = gmailSaslXoauth2('gbolahanoduyemi1@gmail.com', token);
    final message = Message()
      ..from = Address('gbolahangamer@gmail.com', 'Routine Checker gb')
      ..recipients.add('$_userEmail')
      ..subject = 'Routine Notification :: 😀 :: ${DateTime.now()}'
      ..text = '5 mins reminder\n Kindly check the app for your routine: $text';
    try {
      final sendReport = await send(message, smptServer);
      showSuccessToast(message: 'Reminder to check Routine: $text ');
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<void> clear() async {
    await db.delete(tableName);
    notifyListeners();
  }
}
