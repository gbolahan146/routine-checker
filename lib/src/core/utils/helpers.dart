import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:get/get.dart';
import 'package:routinechecker/src/config/styles/colors.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

String convertToAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);
  return '${diff.inDays}';
}

void showErrorToast({String? message, int duration = 3}) {
  Get.rawSnackbar(
    message: message?.capitalizeFirst ?? "An error occured! 🙂",
    title: 'Oops!',
    instantInit: true,
    duration: Duration(seconds: duration),
    backgroundColor: Colors.red.withOpacity(.8),
    margin: EdgeInsets.symmetric(horizontal: 20),
    snackPosition: SnackPosition.TOP,
    borderRadius: 8,
  );
}

void showSuccessToast({String? message}) {
  Get.rawSnackbar(
    message: message?.capitalizeFirst ?? '',
    title: 'Success',
    instantInit: true,
    duration: Duration(seconds: 4),
    backgroundColor: CbColors.cSuccessBase.withOpacity(.8),
    margin: EdgeInsets.symmetric(horizontal: 20),
    snackPosition: SnackPosition.TOP,
    borderRadius: 8,
  );
}
