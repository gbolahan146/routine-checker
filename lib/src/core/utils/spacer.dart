import 'package:flutter/material.dart';
import 'package:routinechecker/src/core/utils/dimensions.dart';

class XMargin extends StatelessWidget {
  const XMargin(this.x);
  final double x;
  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();

    return SizedBox(width: config.sw(x));
  }
}

class YMargin extends StatelessWidget {
  const YMargin(this.y);
  final double y;
  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();

    return SizedBox(height: config.sh(y));
  }
}

double screenHeight(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.height * percent;

double screenWidth(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.width * percent;
