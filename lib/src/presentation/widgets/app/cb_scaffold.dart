
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/presentation/widgets/appbars/app_bar.dart';
import 'package:routinechecker/src/presentation/widgets/loaders/loading_indicator.dart';

class CbScaffold extends StatefulWidget {
  CbScaffold(
      {this.body,
      this.appBar,
      this.isLoading = false,
      this.loadingText,
      this.resizeToAvoidBottomInset,
      this.bottomNavigationBar,
      this.backgroundColor,
      this.scaffoldKey,
      this.canRefreshScreen = false,
      this.refreshKey,
      this.onRefresh,
      this.floatingActionButton,
      this.persistentFooterButtons});

  final Widget? body;
  final bool? isLoading;
  final CbAppBar? appBar;
  final String? loadingText;
  final bool? resizeToAvoidBottomInset;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final Key? refreshKey;
  final bool canRefreshScreen;
  final Key? scaffoldKey;
  final Future<void> Function()? onRefresh;
  final List<Widget>? persistentFooterButtons;
  final Widget? floatingActionButton;

  @override
  _CbScaffoldState createState() => _CbScaffoldState();
}

class _CbScaffoldState extends State<CbScaffold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      color: CbColors.white,
      progressIndicator: LoadingIndicator(),
      isLoading: widget.isLoading!,
      child: Scaffold(
        floatingActionButton: widget.floatingActionButton,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        key: widget.scaffoldKey,
        backgroundColor: widget.backgroundColor ?? Colors.white,
        appBar: widget.appBar ?? null,
        bottomNavigationBar: widget.bottomNavigationBar ?? null,
        body: widget.canRefreshScreen
            ? RefreshIndicator(
                key: widget.refreshKey,
                onRefresh: widget.onRefresh!,
                child: widget.body!)
            : widget.body,
        persistentFooterButtons: widget.persistentFooterButtons,
      ),
    );
  }
}
