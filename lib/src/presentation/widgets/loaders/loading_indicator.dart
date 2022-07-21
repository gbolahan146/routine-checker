
import 'package:flutter/material.dart';
import 'package:routinechecker/src/config/styles/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(CbColors.cPrimaryBase),
    );
  }
}
