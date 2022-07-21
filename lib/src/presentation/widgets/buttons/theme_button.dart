
import 'package:flutter/material.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';
import 'package:routinechecker/src/core/utils/dimensions.dart';

class CbThemeButton extends StatelessWidget {
  const CbThemeButton(
      {Key? key,
      this.onPressed,
      this.text,
      this.loadingState = false,
      this.buttonColor,
      this.textColor,
      this.buttonTextSize,
      this.buttonRadius,
      this.enabled = true})
      : super(key: key);

  final VoidCallback? onPressed;

  final String? text;
  final bool enabled;
  final bool loadingState;
  final Color? buttonColor;
  final Color? textColor;
  final double? buttonTextSize;
  final BorderRadius? buttonRadius;

  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();
    final textWidget = Text(
      "$text",
      textAlign: TextAlign.center,
      maxLines: 1,
      // overflow: TextOverflow.ellipsis,
      style: CbTextStyle.bold16.copyWith(
        color: textColor ?? Colors.white,
      ),
    );
    return Container(
      width: double.infinity,
      height: config.sh(53),
      child: loadingState
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(CbColors.cPrimaryBase),
              ),
            )
          : TextButton(
              onPressed: enabled ? onPressed : null,
              child: textWidget,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(enabled
                      ? buttonColor ?? CbColors.cPrimaryBase
                      : CbColors.cPrimaryLighten3),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: buttonRadius ?? BorderRadius.circular(4)))),
            ),
    );
  }
}
