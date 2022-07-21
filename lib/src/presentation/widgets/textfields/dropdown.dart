
import 'package:flutter/material.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';

// ignore: must_be_immutable
class CbDropDown extends StatelessWidget {
  CbDropDown(
      {this.label,
      this.onChanged,
      this.validator,
      this.enabled = true,
      this.selected,
      required this.options,
      this.suffix,
      this.prefix,
      this.hint = ''});

  final String? hint;
  final String? label;
  final Function(String?)? onChanged;
  final String? Function(Object?)? validator;
  final List<String>? options;
  final Widget? suffix;
  final bool? enabled;
  final Widget? prefix;
  final String? selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            DropdownButtonFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validator,
                items: options!.map((String f) {
                  return DropdownMenuItem(
                    child: Text(
                      '$f',
                      style: CbTextStyle.book14,
                    ),
                    value: f,
                  );
                }).toList(),
                onChanged: onChanged,
                value: selected,
                // hint: Text(
                //   hint ?? "Hint",
                //   style: CbTextStyle.hint,
                // ),
                style: CbTextStyle.bold16,
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: CbTextStyle.hint,
                    border: border,
                    filled: true,
                    fillColor: !enabled! ? CbColors.cDarken1 : CbColors.cBase,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                            color: !enabled!
                                ? CbColors.cPrimaryBase
                                : CbColors.cAccentLighten5)),
                    errorStyle: CbTextStyle.error,
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: CbColors.cErrorBase),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: CbColors.cErrorBase),
                    ),
                    prefixIcon: prefix,
                    focusedBorder: border,
                    disabledBorder: border),
                icon: suffix ??
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: CbColors.cAccentLighten5,
                    )),
            Positioned(
                left: 13,
                top: 8,
                child: Text(
                  selected == null ? '' : label!,
                  style: CbTextStyle.label,
                ))
          ],
        ),
      ],
    );
  }

  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: CbColors.cAccentLighten5));
}
