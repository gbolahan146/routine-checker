// ignore_for_file: implementation_imports

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';
import 'package:routinechecker/src/core/utils/dimensions.dart';
import 'package:routinechecker/src/core/utils/navigator.dart';
import 'package:routinechecker/src/data/datasources/local/local_storage.dart';
import 'package:routinechecker/src/presentation/views/homescreen/home.dart';
import 'package:routinechecker/src/presentation/views/onboarding/onboarding_page.dart';

class SplashPage extends StatefulHookWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // context.read(accountsProvider).fetchBanks();
    Timer(Duration(seconds: 2), () => decideNav());
    super.initState();
  }

  decideNav() async {
    bool? onboardingState = await LocalStorage.getItem("hasSeenOnboarding");
    bool loggedinState = await LocalStorage.getItem("loggedIn") ?? false;
    print("loggedinState: $loggedinState");
    if (onboardingState != null && onboardingState) {
      navigateReplaceTo(context, HomePage());
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return OnboardingPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig config = SizeConfig();
    return Scaffold(
      backgroundColor: CbColors.cAccentBase,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Text(
                  'RC',
                  style: CbTextStyle.bold28.copyWith( fontSize: config.sp(50), color: Colors.black),
                ),
              )),
        ],
      ),
    );
  }
}
