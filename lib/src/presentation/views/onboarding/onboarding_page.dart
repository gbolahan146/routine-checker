import 'package:flutter/material.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';
import 'package:routinechecker/src/core/utils/helpers.dart';
import 'package:routinechecker/src/core/utils/spacer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routinechecker/src/core/utils/validators.dart';

import 'package:routinechecker/src/data/datasources/local/local_storage.dart';
import 'package:routinechecker/src/presentation/providers/notification_service.dart';
import 'package:routinechecker/src/presentation/views/homescreen/home.dart';
import 'package:routinechecker/src/presentation/widgets/buttons/theme_button.dart';
import 'package:routinechecker/src/presentation/widgets/textfields/textfield.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  void _saveUserOnboardingState() async {
    bool? onboardingState = await LocalStorage.getItem("hasSeenOnboarding");
    if (onboardingState == null) {
      await LocalStorage.setItem("hasSeenOnboarding", true);
    }
  }

  @override
  void initState() {
    super.initState();
    _saveUserOnboardingState();
  }

  final TextEditingController controller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: <String>[
  //     'email',
  //   ],
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CbColors.cBase,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              YMargin(40),
              Text(
                "Welcome to\nRoutine Checker.",
                style: CbTextStyle.bold24,
              ),
              YMargin(40),

              CbTextField(
                controller: namecontroller,
                validator: Validators.validateFullName,
                hint: 'Enter Full name',
                label: 'Full name',
              ),
              YMargin(10),
              CbTextField(
                controller: controller,
                validator: Validators.validateEmail,
                hint: 'Enter email address',
                label: 'Email address',
              ),
              YMargin(10),
              // Row(children: [
              //   SizedBox(
              //     height: 40,
              //     width: 40,
              //     child: Image.network(
              //       'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/2058fb75442843.5c4cd14030bd5.png',
              //     ),
              //   ),
              //   Expanded(
              //     child: CbThemeButton(
              //       text: 'Sign in with Google',
              //       onPressed: () async {
              //         var res = await _googleSignIn.signIn();
              //         if (res != null) {
              //           await LocalStorage.setItem("userEmail", res.email);
              //           await LocalStorage.setItem(
              //               "token", namecontroller.text);
              //           await LocalStorage.setItem("name", res.displayName);
              //           showSuccessToast(message: 'Sign up successful');
              //           Navigator.push(context,
              //               MaterialPageRoute(builder: (context) {
              //             return HomePage();
              //             // RegisterPage();
              //           }));
              //         }
              //       },
              //     ),
              //   ),
              // ]),
              YMargin(10),
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                            child: Text(
                                'Routine Checker requires email for routine notifications',
                                style: CbTextStyle.book14),
                          ),
                        )),
                child: Text(
                  'Why do we need email?',
                  style:
                      CbTextStyle.medium.copyWith(color: CbColors.cPrimaryBase),
                ),
              ),
              YMargin(36),
            ]),
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CbThemeButton(
            text: 'Get started',
            onPressed: () async {
              if (!_formkey.currentState!.validate()) return;
              await LocalStorage.setItem("userEmail", controller.text);
              await LocalStorage.setItem("name", namecontroller.text);
              showSuccessToast(message: 'Sign up successful');
              NotificationService.showNotifications(
                title: 'Welcome to Routine Check',
                message: 'Create your first routine'
              );

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomePage();
                // RegisterPage();
              }));
            },
          ),
        )
      ],
    );
  }
}
