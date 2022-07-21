
import 'package:flutter/material.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/fonts.dart';
import 'package:routinechecker/src/core/utils/dimensions.dart';

class CbTextStyle {
  static SizeConfig config = SizeConfig();

  static TextStyle book12 = TextStyle(
      fontSize: config.sp(12),
      color: CbColors.cAccentLighten3,
      fontStyle: FontStyle.normal,
      fontFamily: CbFonts.circular);

  static TextStyle book14 = TextStyle(
      fontSize: config.sp(14),
      color: CbColors.cAccentLighten3,
      fontStyle: FontStyle.normal,
      fontFamily: CbFonts.circular);

  static TextStyle book16 = TextStyle(
      fontSize: config.sp(16),
      color: CbColors.cAccentLighten3,
      fontStyle: FontStyle.normal,
      fontFamily: CbFonts.circular);

  static TextStyle medium = TextStyle(
    fontSize: config.sp(16),
    fontFamily: CbFonts.circular,
    fontWeight: FontWeight.w500,
    color: CbColors.cAccentBase,
  );

  static TextStyle bold12 = TextStyle(
    fontSize: config.sp(12),
    fontFamily: CbFonts.circular,
    fontWeight: FontWeight.bold,
    color: CbColors.cAccentLighten3,
  );
  static TextStyle bold14 = TextStyle(
    fontSize: config.sp(14),
    fontFamily: CbFonts.circular,
    fontWeight: FontWeight.bold,
    color: CbColors.cAccentBase,
  );

  static TextStyle bold16 = TextStyle(
    fontSize: config.sp(16),
    fontFamily: CbFonts.circular,
    fontWeight: FontWeight.w700,
    color: CbColors.cPrimaryBase,
  );

  static TextStyle bold18 = TextStyle(
    fontSize: config.sp(18),
    fontWeight: FontWeight.bold,
    color: CbColors.cAccentBase,
  );

  static TextStyle bold20 = TextStyle(
    fontSize: config.sp(20),
    fontFamily: CbFonts.circular,
    fontWeight: FontWeight.bold,
    color: CbColors.cAccentBase,
  );

  static TextStyle bold24 = TextStyle(
    fontSize: config.sp(24),
    fontFamily: CbFonts.circular,
    fontWeight: FontWeight.bold,
    color: CbColors.cAccentBase,
  );
  static TextStyle bold28 = TextStyle(
    fontSize: config.sp(28),
    fontWeight: FontWeight.bold,
    color: CbColors.cAccentBase,
  );

  static TextStyle label = TextStyle(
      fontSize: config.sp(10),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontFamily: CbFonts.circular,
      color: CbColors.cAccentLighten4);

  static TextStyle error = TextStyle(
      fontSize: config.sp(12),
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontFamily: CbFonts.circular,
      color: CbColors.cErrorBase);

  static TextStyle hint = TextStyle(
      fontSize: config.sp(16),
      fontWeight: FontWeight.w400,
      color: CbColors.cAccentLighten4,
      fontFamily: CbFonts.circular,
      fontStyle: FontStyle.normal);

  static TextStyle black = TextStyle(
      fontSize: config.sp(40),
      fontWeight: FontWeight.w900,
      color: CbColors.white,
      fontFamily: CbFonts.circular,
      fontStyle: FontStyle.normal);
}
