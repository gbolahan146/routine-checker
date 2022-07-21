import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/fonts.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';
import 'package:routinechecker/src/core/state_registry.dart';
import 'package:routinechecker/src/core/utils/spacer.dart';
import 'package:routinechecker/src/core/utils/validators.dart';
import 'package:routinechecker/src/data/models/routine_model.dart';
import 'package:routinechecker/src/presentation/widgets/app/cb_scaffold.dart';
import 'package:routinechecker/src/presentation/widgets/buttons/theme_button.dart';
import 'package:routinechecker/src/presentation/widgets/textfields/dropdown.dart';
import 'package:routinechecker/src/presentation/widgets/textfields/textfield.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateRoutinePage extends StatefulHookWidget {
  const CreateRoutinePage({Key? key}) : super(key: key);

  @override
  _CreateRoutinePageState createState() => _CreateRoutinePageState();
}

class _CreateRoutinePageState extends State<CreateRoutinePage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController descController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController freqController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  var _rnd = Random();
  @override
  Widget build(BuildContext context) {

    var routineState = useProvider(routineProvider);

    return CbScaffold(
      backgroundColor: CbColors.cBase,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CbTextField(
                hint: 'Enter title',
                controller: titleController,
                label: 'Title',
                validator: Validators.validateField),
            YMargin(10),
            CbDropDown(
              options: ['Hourly', 'Daily', 'Weekly', 'Monthly', ''],
              label: 'Select Frequency',
              enabled: true,
              selected:
                  freqController.text.isEmpty ? null : freqController.text,
              onChanged: (val) {
                setState(() {
                  freqController.text = val ?? '';
                });
              },
              hint: 'Select Frequency',
            ),
            CbTextField(
              hint: 'Enter timeframe',
              controller: timeController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: Validators.validateEmail,
              label: 'Time',
            ),
            YMargin(10),
            Row(
              children: [
                Icon(Icons.info, color: Color(0xffE5861A)),
                SizedBox(width: 13),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                        text: '',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                            color: Colors.black,
                            fontSize: 12),
                        children: [
                          TextSpan(
                              text: 'Do ',
                              style: TextStyle(
                                  fontFamily: 'Graphik',
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: '${titleController.text}',
                              style: TextStyle(
                                  fontFamily: CbFonts.circular,
                                  fontWeight: FontWeight.w600)),
                          TextSpan(
                              text: 'every',
                              style: TextStyle(
                                  fontFamily: 'Graphik',
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: ' ${timeController.text} ',
                              style: TextStyle(
                                  fontFamily: CbFonts.circular,
                                  fontWeight: FontWeight.w600)),
                        ]),
                  ),
                )
              ],
            ),
         
            YMargin(36),
          ]),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('* Note: All routines expire in 15 mins',
                  style: CbTextStyle.error),
              CbThemeButton(
                text: 'Create',
                loadingState: routineState.stateBusy,
                onPressed: () async {
                  if (!_formkey.currentState!.validate()) return;
                  routineState.createNewRoutine(RoutineModel(
                    createdAt: DateTime.now().toIso8601String(),
                    updatedAt: DateTime.now().toIso8601String(),
                    time: timeController.text,
                    status: 'Ongoing',
                    title: titleController.text,
                    description: descController.text,
                    frequency: freqController.text.toLowerCase(),
                    id: getRandomString(15),
                  ));
                },
              ),
            ],
          ),
        )
      ],
    );
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

String? getFreq(String value) {
  switch (value) {
    case 'Hourly':
      'hour(s)';
      break;
    case 'Daily':
      'day(s)';
      break;
    case 'Weekly':
      'week(s)';
      break;
    case 'Monthly':
      'month(s)';
      break;
    case 'Yearly':
      'year(s)';
      break;
    default:
      'hour(s)';
  }
}
