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
import 'package:routinechecker/src/presentation/widgets/appbars/app_bar.dart';
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
      backgroundColor: CbColors.white,
      appBar: CbAppBar(
   automaticallyImplyLeading: true,
        title: 'Create Routine.',
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              YMargin(40),
              CbTextField(
                  hint: 'Enter title',
                  controller: titleController,
                  label: 'Title',
                  validator: Validators.validateField),
              YMargin(14),
              CbDropDown(
                options: ['Hourly', 'Daily', 'Weekly', 'Monthly', 'Yearly'],
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
              YMargin(14),
              CbTextField(
                hint: 'Enter timeframe',
                controller: timeController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: Validators.validateField,
                label: 'Time',
              ),
              YMargin(14),
              CbTextField(
                hint: 'Enter description',
                controller: descController,
                maxLines: 4,
                validator: Validators.validateField,
                label: 'Description',
              ),
              YMargin(14),
              if (timeController.text != '')
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
                                  text: 'Routine: ',
                                  style: TextStyle(
                                      fontFamily: 'Graphik',
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: '${titleController.text}',
                                  style: TextStyle(
                                      fontFamily: CbFonts.circular,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: ' every',
                                  style: TextStyle(
                                      fontFamily: 'Graphik',
                                      fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text:
                                      ' ${timeController.text} ${getFreq(freqController.text)} ',
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
                  routineState.createNewRoutine(
                    RoutineModel(
                      createdAt: DateTime.now().toIso8601String(),
                      updatedAt: DateTime.now().toIso8601String(),
                      time: timeController.text,
                      status: 'Ongoing',
                      routineId: getRandomString(15),
                      title: titleController.text,
                      description: descController.text,
                      frequency: freqController.text.toLowerCase(),
                      // id: getRandomString(15),
                    ),
                    onSuccess: () => Navigator.pop(context),
                  );
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
    case 'hourly':
      return 'hour(s)';
    case 'daily':
      return 'day(s)';
    case 'weekly':
      return 'week(s)';
    case 'monthly':
      return 'month(s)';
    case 'yearly':
      return 'year(s)';
    default:
      return 'hour(s)';
  }
}
