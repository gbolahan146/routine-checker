
import 'package:flutter/material.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';
import 'package:routinechecker/src/core/utils/dimensions.dart';

class CbAppBar extends StatefulWidget implements PreferredSizeWidget {
  CbAppBar(
      {Key? key,
      this.actions = const [],
      this.isTransparent = false,
      this.leading,
      this.title,
      this.subtitle,
      this.bottom,
      this.automaticallyImplyLeading = false})
      : super(key: key);

  final List<Widget> actions;
  final Widget? leading;
  final String? title;
  final String? subtitle;
  final bool? isTransparent;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;

  @override
  _CbAppBarState createState() => _CbAppBarState();
  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _CbAppBarState extends State<CbAppBar> {
  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    return AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor:
            widget.isTransparent! ? Colors.transparent : Colors.white,
        bottom: widget.bottom,
        leadingWidth: 40,
        leading: widget.automaticallyImplyLeading
            ? SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 28),
                  child: GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: CbColors.cAccentBase,
                      size: 18,
                    ),
                  ),
                ),
              )
            : null,
        automaticallyImplyLeading: widget.automaticallyImplyLeading,
        title: widget.subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title ?? '',
                      style: CbTextStyle.book16.copyWith(
                          color: CbColors.cAccentBase, fontSize: config.sp(24)),
                    ),
                    Text(
                      widget.subtitle ?? '',
                      style: CbTextStyle.bold24,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Text(
                  widget.title ?? '',
                  style: CbTextStyle.bold24,
                ),
              ),
        // centerTitle: true,
        actions: [
          ...widget.actions,
        ]);
  }
}
