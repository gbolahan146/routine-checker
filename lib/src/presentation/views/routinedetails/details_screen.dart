
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';
import 'package:routinechecker/src/core/state_registry.dart';
import 'package:routinechecker/src/core/utils/spacer.dart';
import 'package:routinechecker/src/core/utils/validators.dart';
import 'package:routinechecker/src/data/models/routine_model.dart';
import 'package:routinechecker/src/presentation/widgets/app/cb_scaffold.dart';
import 'package:routinechecker/src/presentation/widgets/buttons/theme_button.dart';
import 'package:routinechecker/src/presentation/widgets/textfields/dropdown.dart';
import 'package:routinechecker/src/presentation/widgets/textfields/textfield.dart';

class DetailsScreen extends StatefulHookWidget {
  final RoutineModel item;
  DetailsScreen({
    required this.item,
  });
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController descController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  setValues() {
    descController.text = widget.item.description ?? '';
    titleController.text = widget.item.title ?? '';
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
            Text(
                'You have ${widget.item.time} ${getFreq(widget.item.frequency ?? 'Hourly')} more to the next routine check',
                style: CbTextStyle.book12),
            CbTextField(
                hint: 'Enter title',
                controller: titleController,
                label: 'Title',
                validator: Validators.validateField),
            YMargin(10),
            CbDropDown(
              options: ['Hourly', 'Daily', 'Weekly', 'Monthly', ''],
              label: 'Select Frequency',
              enabled: false,
              selected: widget.item.frequency?.capitalizeFirst,
              onChanged: null,
              hint: 'Select Frequency',
            ),
            CbTextField(
              hint: 'Ente timeframe',
              controller: TextEditingController(text: widget.item.time),
              enabled: false,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: Validators.validateEmail,
              label: 'Time',
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
                text: 'Update',
                loadingState: routineState.stateBusy,
                onPressed: () async {
                  if (!_formkey.currentState!.validate()) return;
                  routineState.updateRoutine(
                    RoutineModel(
                      createdAt: widget.item.createdAt,
                      updatedAt: DateTime.now().toIso8601String(),
                      time: widget.item.time,
                      status: widget.item.status,
                      title: titleController.text,
                      description: descController.text,
                      frequency: widget.item.frequency,
                      id: widget.item.id,
                    ),
                    widget.item.id!,
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
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
}
