import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:routinechecker/src/core/utils/navigator.dart';
import 'package:routinechecker/src/data/datasources/local/local_db.dart';
import 'package:routinechecker/src/data/models/routine_model.dart';
import 'package:routinechecker/src/presentation/providers/notification_service.dart';
import 'package:routinechecker/src/presentation/views/homescreen/create_routine.dart';
import 'package:routinechecker/src/presentation/views/routinedetails/details_screen.dart';
import 'package:routinechecker/src/presentation/widgets/buttons/theme_button.dart';
import 'package:share/share.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routinechecker/src/config/styles/colors.dart';
import 'package:routinechecker/src/config/styles/textstyles.dart';
import 'package:routinechecker/src/core/state_registry.dart';
import 'package:routinechecker/src/core/utils/dimensions.dart';
import 'package:routinechecker/src/core/utils/spacer.dart';
import 'package:routinechecker/src/presentation/widgets/app/cb_scaffold.dart';

class HomePage extends StatefulHookWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool obscureText = false;
  LocalDB localDB = LocalDB();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    }
    if (hour < 17) {
      return 'afternoon';
    }
    return 'evening';
  }

  String greetingIcon() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return '☀️';
    }
    if (hour < 17) {
      return '⛅';
    }

    return '🌙';
  }

  @override
  void initState() {
    super.initState();
    context.read(routineProvider).fetchUserDetails();
    context.read(routineProvider).load(localDB.database);
  }

  @override
  Widget build(BuildContext context) {
    final config = SizeConfig();
    var routineState = useProvider(routineProvider);
    // var user = authState.fetchUserResponse.data;
    return CbScaffold(
      backgroundColor: CbColors.cBase,
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CbThemeButton(
            text: 'Create new Routine',
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CreateRoutinePage();
              }));
            },
          ),
        )
      ],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              YMargin(60),
              GestureDetector(
                onTap: () {
                  NotificationService.showNotifications();
                  // routineState.fetchRoutines();
                  routineState.fetchUnder12Routines();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good ${greeting()} ${greetingIcon()}",
                          style: CbTextStyle.book14,
                        ),
                        Text(
                          "${routineState.userName}.",
                          style: CbTextStyle.bold24,
                        ),
                      ],
                    ),
                    Icon(Icons.notifications_none)
                  ],
                ),
              ),
              YMargin(24),
              Center(
                  child: Text('Routine Tracking', style: CbTextStyle.medium)),
              YMargin(14),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 10.0,
                animation: true,
                backgroundColor: Colors.grey,
                circularStrokeCap: CircularStrokeCap.round,
                percent: routineState.computed.toDouble(),
                center: new Text(
                  "${(routineState.computed.toDouble() * 100).toStringAsFixed(2)}%",
                  style: CbTextStyle.medium,
                ),
                progressColor: Colors.green,
              ),
              YMargin(24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: CbColors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YMargin(16),
                    Row(
                      children: [
                        Text(
                          'Next Up.',
                          style: CbTextStyle.medium
                              .copyWith(color: CbColors.cAccentLighten3),
                        ),
                        Spacer(),
                        Text(
                          'Under 12 hours.',
                          style: CbTextStyle.medium.copyWith(
                              fontSize: config.sp(12),
                              color: CbColors.cAccentLighten3),
                        ),
                        XMargin(8),
                        Icon(Icons.date_range, size: 14),
                      ],
                    ),
                    YMargin(16),
                    routineState.listOfRoutines12.isEmpty
                        ? Center(
                            child: Text(
                              'No routines yet.',
                              style: CbTextStyle.medium.copyWith(
                                  fontSize: config.sp(14),
                                  color: CbColors.cAccentLighten3),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => YMargin(16),
                            itemCount: routineState.listOfRoutines12.length,
                            itemBuilder: (context, index) {
                              if (routineState.listOfRoutines12[index].status ==
                                  'Ongoing') {
                                if (DateTime.now()
                                        .difference(DateTime.parse(routineState
                                            .listOfRoutines12[index].createdAt))
                                        .inMinutes >
                                    15) {
                                  routineState.listOfRoutines12[index].status =
                                      'Expired';
                                  NotificationService.showNotifications(
                                      title: 'Oops! Routine expired',
                                      message:
                                          'Routine ${routineState.listOfRoutines12[index].title} has expired');
                                }
                              }
                              if (DateTime.parse(routineState
                                          .listOfRoutines12[index].createdAt)
                                      .subtract(Duration(minutes: 5)) ==
                                  0) {
                                routineState.sendEmailNotification(routineState
                                        .listOfRoutines12[index].title ??
                                    '');
                                NotificationService.showNotifications();
                              }
                              return Container(
                                decoration: BoxDecoration(
                                    color: CbColors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        routineState.listOfRoutines12[index]
                                                    .status ==
                                                'Expired'
                                            ? Icon(Icons.error,
                                                color: CbColors.cErrorBase)
                                            : Checkbox(
                                                checkColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                activeColor:
                                                    CbColors.cPrimaryBase,
                                                value: routineState
                                                        .listOfRoutines12[index]
                                                        .status ==
                                                    'Done',
                                                onChanged: (val) {
                                                  if (routineState
                                                          .listOfRoutines12[
                                                              index]
                                                          .status ==
                                                      'Ongoing')
                                                    routineState.updateRoutine(
                                                      RoutineModel(
                                                        routineId: routineState
                                                            .listOfRoutines12[
                                                                index]
                                                            .routineId,
                                                        createdAt: routineState
                                                            .listOfRoutines12[
                                                                index]
                                                            .createdAt,
                                                        updatedAt: DateTime
                                                                .now()
                                                            .toIso8601String(),
                                                        status: 'Done',
                                                        time: routineState
                                                            .listOfRoutines12[
                                                                index]
                                                            .time,
                                                        title: routineState
                                                            .listOfRoutines12[
                                                                index]
                                                            .title,
                                                        description: routineState
                                                            .listOfRoutines12[
                                                                index]
                                                            .description,
                                                        frequency: routineState
                                                            .listOfRoutines12[
                                                                index]
                                                            .frequency,
                                                        // id: routineState
                                                        //     .listOfRoutines12[
                                                        //         index]
                                                        //     .id
                                                      ),
                                                    );
                                                }),
                                        XMargin(16),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      '${routineState.listOfRoutines12[index].title}',
                                                      style:
                                                          CbTextStyle.medium),
                                                  Spacer(),
                                                  IconButton(
                                                      icon: Icon(Icons.share,
                                                          size: 20),
                                                      onPressed: () =>
                                                          Share.share(
                                                            'Routine:${routineState.listOfRoutines12[index].title}',
                                                          ))
                                                ],
                                              ),
                                              YMargin(4),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      'Every ${routineState.listOfRoutines12[index].time} ${getFreq(routineState.listOfRoutines12[index].frequency ?? '')} ',
                                                      style:
                                                          CbTextStyle.book12),
                                                  XMargin(5),
                                                  Text(
                                                      '${routineState.listOfRoutines12[index].status}',
                                                      style: CbTextStyle.book12
                                                          .copyWith(
                                                              color: routineState
                                                                      .listOfRoutines12[
                                                                          index]
                                                                      .status!
                                                                      .contains(
                                                                          'Done')
                                                                  ? CbColors
                                                                      .cSuccessBase
                                                                  : routineState
                                                                          .listOfRoutines12[
                                                                              index]
                                                                          .status!
                                                                          .contains(
                                                                              'Ongoing')
                                                                      ? Colors
                                                                          .orange
                                                                      : CbColors
                                                                          .cErrorBase)),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      navigate(DetailsScreen(
                                                          item: routineState
                                                                  .listOfRoutines12[
                                                              index]));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text('View',
                                                            style: CbTextStyle
                                                                .book12),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 1.0),
                                                          child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 10,
                                                              color: routineState
                                                                      .listOfRoutines12[
                                                                          index]
                                                                      .status!
                                                                      .contains(
                                                                          'Done')
                                                                  ? CbColors
                                                                      .cSuccessBase
                                                                  : routineState
                                                                          .listOfRoutines12[
                                                                              index]
                                                                          .status!
                                                                          .contains(
                                                                              'Ongoing')
                                                                      ? Colors
                                                                          .orange
                                                                      : CbColors
                                                                          .cErrorBase),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                    YMargin(16),
                  ],
                ),
              ),
              YMargin(24),
            ],
          ),
        ),
      ),
    );
  }

  String calculatePercentage(num a, num b) {
    var fig = (a - b) * a / 100;
    return '$fig%';
  }
}
