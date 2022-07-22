// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';
import 'package:routinechecker/src/core/state_registry.dart';
import 'package:routinechecker/src/core/utils/navigator.dart';
import 'package:routinechecker/src/core/utils/spacer.dart';
import 'package:routinechecker/src/core/utils/validators.dart';
import 'package:routinechecker/src/data/models/routine_model.dart';
import 'package:routinechecker/src/presentation/views/homescreen/home.dart';
import 'package:routinechecker/src/presentation/widgets/app/cb_scaffold.dart';
import 'package:routinechecker/src/presentation/widgets/appbars/app_bar.dart';
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
    setValues();
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
      backgroundColor: CbColors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              YMargin(40),
              if (widget.item.frequency == 'hourly')
                Text(
                    'You have ${widget.item.time} ${getFreq(widget.item.frequency ?? 'Hourly')} more to the next routine check',
                    style: CbTextStyle.book12)
              else
                Text(
                    'You have ${widget.item.time} ${getFreq(widget.item.frequency ?? 'Hourly')} more to the next routine check',
                    style: CbTextStyle.book12),
              YMargin(14),
              CbTextField(
                  hint: 'Enter title',
                  controller: titleController,
                  label: 'Title',
                  validator: Validators.validateField),
              YMargin(14),
              CbDropDown(
                options: ['Hourly', 'Daily', 'Weekly', 'Monthly', ''],
                label: 'Select Frequency',
                enabled: false,
                selected: widget.item.frequency?.capitalizeFirst,
                onChanged: null,
                hint: 'Select Frequency',
              ),
              YMargin(14),
              CbTextField(
                hint: 'Enter timeframe',
                controller: TextEditingController(text: widget.item.time),
                enabled: false,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: Validators.validateField,
                label: 'Time',
              ),
              YMargin(14),
              CbTextField(
                maxLines: 4,
                hint: 'Enter description',
                controller: descController,
                validator: Validators.validateField,
                label: 'Time',
              ),
              YMargin(36),
            ]),
          ),
        ),
      ),
      appBar: CbAppBar(
        title: 'Update Routine.',
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Icon(Icons.delete),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text('Delete Routine'),
                        content: Text(
                            'Are you sure you want to delete this routine?'),
                        actions: [
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          FlatButton(
                            child: Text('Delete'),
                            onPressed: () { 
                              routineState.deleteRoutine(widget.item,
                                  onSuccess: () {
                                pushUntil(context, HomePage());
                              });
                              // Navigator.pop(context);
                            },
                          )
                        ],
                      ));
            },
          )
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CbThemeButton(
                text: 'Update',
                loadingState: routineState.stateBusy,
                onPressed: () async {
                  if (!_formkey.currentState!.validate()) return;
                  routineState.updateRoutine(
                    RoutineModel(
                      routineId: widget.item.routineId,
                      createdAt: widget.item.createdAt,
                      updatedAt: DateTime.now().toIso8601String(),
                      time: widget.item.time,
                      status: widget.item.status,
                      title: titleController.text,
                      description: descController.text,
                      frequency: widget.item.frequency,
                      // id: widget.item.id,
                    ),
                    // widget.item.id!,
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
}
