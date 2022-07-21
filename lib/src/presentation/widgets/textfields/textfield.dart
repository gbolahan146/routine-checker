
import 'package:flutter/material.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';
import 'package:routinechecker/src/core/utils/dimensions.dart';

// ignore: must_be_immutable
class CbTextField extends StatefulWidget {
  CbTextField(
      {this.label,
      this.onChanged,
      this.focusNode,
      this.hasFocus = false,
      this.prefix,
      this.nextNode,
      this.validator,
      this.fillColor,
      this.obscureText = false,
      this.enabled = true,
      this.textCapitalization,
      this.keyboardType,
      this.maxLines = 1,
      this.inputFormatters,
      this.suffix,
      this.readOnly = false,
      this.hint,
      this.onTap,
      this.isDense = false,
      this.controller});

  final String? hint;
  final String? label;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final bool? hasFocus;
  final bool? readOnly;
  final bool enabled;
  final int maxLines;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final FocusNode? nextNode;
  final inputFormatters;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool isDense;
  final Widget? suffix;
  final Widget? prefix;

  @override
  _CbTextFieldState createState() => _CbTextFieldState();
}

class _CbTextFieldState extends State<CbTextField> {
  @override
  Widget build(BuildContext context) {
    final SizeConfig config = SizeConfig();
    return Stack(
      children: [
        TextFormField(
          onTap: widget.onTap,
          controller: widget.controller,
          onChanged: widget.onChanged,
          focusNode: widget.focusNode,
          obscuringCharacter: "*",
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly!,
          validator: widget.validator,
          onFieldSubmitted: (String val) {
            FocusScope.of(context).requestFocus(widget.nextNode);
          },
          style: widget.enabled ? CbTextStyle.bold16 : CbTextStyle.hint,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.none,
          decoration: InputDecoration(
              hintText: widget.hint,
              isDense: widget.isDense,
              suffixIcon: widget.suffix,
              prefixIcon: widget.prefix,
              hintStyle: CbTextStyle.hint,
              border: border,
              fillColor: widget.controller!.text.isNotEmpty
                  ? CbColors.cDarken1
                  : CbColors.cBase,
              filled: widget.enabled,
              enabledBorder: border,
              errorStyle: CbTextStyle.error,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: CbColors.cPrimaryBase),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: CbColors.cErrorBase),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: CbColors.cPrimaryBase)),
              disabledBorder: border),
        ),
        Positioned(
            left: config.sh(13.76),
            top: config.sh(7),
            child: Text(
              widget.controller!.text.isNotEmpty ? widget.label! : "",
              style: CbTextStyle.label,
            ))
      ],
    );
  }

  OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: CbColors.cAccentLighten5));
}
