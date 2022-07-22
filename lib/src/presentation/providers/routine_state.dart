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
    _userEmail = await LocalStorage.getItem("userEmail") ?? '';
    _userName = await LocalStorage.getItem("name") ?? '';
    notifyListeners();
  }

  Future<List<RoutineModel>> fetchRoutines() async {
    print('fetching');
    var records = await db.rawQuery('SELECT * from $tableName');
    var items = records.map((e) => RoutineModel.fromMap(e)).toList();
    var tempList = List<RoutineModel>.from(items.reversed);
    listOfRoutines = tempList;

    notifyListeners();
    return listOfRoutines;
  }

  num computed = 1;

  calculatePerformance() {
    var lengthOfCompletedRoutines =
        listOfRoutines.where((e) => e.status == 'Done').length;

    computed = lengthOfCompletedRoutines / listOfRoutines.length;
    computed = computed.abs();
    notifyListeners();
  }

  Future<List<RoutineModel>> fetchUnder12Routines() async {
    var records = await db.rawQuery('SELECT * from $tableName');
    var items = records.map((e) => RoutineModel.fromMap(e)).toList();
    var tempList = List<RoutineModel>.from(items.reversed);
    listOfRoutines12 = [];
    for (var i = 0; i < tempList.length; i++) {
      Jiffy((DateTime.parse(tempList[i].createdAt)))
          .startOf(Units.HOUR)
          .fromNow();
      if (num.parse(tempList[i].time ?? '0') < 12) {
        listOfRoutines12.add(tempList[i]);
      }

      // if ((tempList[i].frequency == 'hourly' ||
      //         tempList[i].frequency == 'daily') &&
      //     (TimeOfDay.fromDateTime((DateTime.parse(tempList[i].createdAt)))
      //                 .hourOfPeriod *
      //             num.parse(tempList[i].time ?? '0') <
      //         12)) {
      //   listOfRoutines12.add(tempList[i]);
      // }
    }
    listOfRoutines12.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    calculatePerformance();
    notifyListeners();
    return listOfRoutines12;
  }

  Future<RoutineModel?> createNewRoutine(RoutineModel routineModel,
      {Function()? onSuccess}) async {
    try {
      _stateBusy = true;
      notifyListeners();
      Future.delayed(Duration(seconds: 3), () {});
      var records = await db.rawQuery('SELECT * from $tableName');

      var listOfRecords = records.map((e) => RoutineModel.fromMap(e)).toList();
      var existingItem = listOfRecords
          .firstWhereOrNull((element) => element.title == routineModel.title);

      if (existingItem == null) {
        await db.insert(
          tableName,
          routineModel.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        logger.d("item inserted");
      }
      showSuccessToast(message: 'Routine Created Successfully ');

      // NotificationService.sendPeriodNotification();
      NotificationService.showNotifications(
          title: 'Upcoming routine', message: '${routineModel.title} ');
      fetchRoutines();
      fetchUnder12Routines();
      onSuccess?.call();
      return routineModel;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    } finally {
      _stateBusy = false;
      notifyListeners();
    }
  }

  Future<int> updateRoutine(
    RoutineModel routineModel,
  ) async {
    print(
      routineModel.toMap(),
    );
    int count = await db.update(tableName, routineModel.toMap(),
        where: 'routineId = ?', whereArgs: [routineModel.routineId]);

    fetchRoutines();
    fetchUnder12Routines();
    showSuccessToast(message: 'Routine Updated Successfully ');

    return count;
  }

  Future<int> deleteRoutine(RoutineModel routineModel, {Function()? onSuccess}) async {
    int count = await db.delete(tableName,
        where: 'routineId = ?', whereArgs: [routineModel.routineId]);
    showSuccessToast(message: 'Routine Deleted Successfully ');
    fetchRoutines();
    fetchUnder12Routines();
    onSuccess?.call();

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
