import 'dart:convert';

import 'package:d_chart/d_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/common/common_methods.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/progress.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/provider/user_state.dart';
import 'package:gympact/screens/common/add_todays_details.dart';
import 'package:gympact/screens/common/diet_plan.dart';
import 'package:gympact/service/user_service.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProgress extends ConsumerStatefulWidget {
  const UserProgress({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProgressState();
}

class _UserProgressState extends ConsumerState<UserProgress> {
  int inWeeks = 3;
  int weekWeight = 3;
  int weekWaterIntake = 0;
  int weekFat = -2;
  int weekCalBurn = 500;

  bool showWeightChart = false;
  bool showfatChart = false;
  bool showwaterIntakeChart = false;
  bool showCalBurnChart = false;

  int initialWeight = 0;
  int desiredWeight = 0;
  double goalPercentage = 0;
  double bmi = 0;
  String waterIntakeMessage = "-";
  String fatMessage = "-";
  String calBurnMessage = "-";
  String weigthMessage = "-";
  String goalMessage = "";

  //up down
  bool isBetter = true;

  User user = User(
      gender: "male",
      id: 12,
      coin: 1004,
      level: 5,
      gymId: "007",
      name: "Aman Gupta",
      phone: "123",
      email: "amangupta@gh",
      password: "password",
      badgesList: [],
      workoutList: [],
      pastWorkoutList: [],
      diet: null,
      progress: null,
      weight: 85,
      heigth: 165,
      goal: "To get fitter",
      progressList: [
        Progress(
            id: 1,
            dateTime: DateTime.now(),
            weight: 56,
            fat: 15,
            calBurn: 2000,
            waterIntake: 4),
        Progress(
            id: 1,
            dateTime: DateTime.now().add(Duration(days: 1)),
            weight: 57,
            fat: 15,
            calBurn: 2600,
            waterIntake: 4),
        Progress(
            id: 1,
            dateTime: DateTime.now().add(Duration(days: 2)),
            weight: 57,
            fat: 13,
            calBurn: 2100,
            waterIntake: 4),
        Progress(
            id: 1,
            dateTime: DateTime.now().add(Duration(days: 3)),
            weight: 58,
            fat: 12,
            calBurn: 2200,
            waterIntake: 4),
        Progress(
            id: 1,
            dateTime: DateTime.now().add(Duration(days: 4)),
            weight: 58,
            fat: 11,
            calBurn: 2200,
            waterIntake: 4),
        Progress(
            id: 1,
            dateTime: DateTime.now().add(Duration(days: 5)),
            weight: 59,
            fat: 10,
            calBurn: 2400,
            waterIntake: 4),
      ],
      currentPackage: CurrentPackage(
          id: 2,
          package: Package(
              id: 1,
              price: 600,
              durationInMonths: 3,
              name: "3 Month Power Plan",
              benefits: ["rt", "as", "asd"]),
          startDate: DateTime.now(),
          endDate: DateTime.now().add(const Duration(days: 90))),
      dob: DateTime(1999, 8, 1),
      joinOn: DateTime.now(),
      lastVisit: DateTime.now(),
      role: Role.member);

  fetchInitialData() async {
    final userId = ref.read(userProvider)?.id;
    await ref.read(progressDetailsProvider.notifier).fetchProgress(userId!);
    final list =
        await ref.read(progressListProvider.notifier).fetchProgress(userId);
    ref.read(userProvider.notifier).updateProgess(list!);
  }

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    user = ref.watch(userProvider)!;
    final map = ref.watch(progressDetailsProvider);
    if (map["initialWeight"] != null) {
      // setState(() {
      initialWeight = (map["initialWeight"] as double).toInt();
      desiredWeight = int.parse(map["desiredWeight"]);
      goalPercentage = double.parse(map["goalPercentage"]) / 100;
      bmi = double.parse(map["bmi"]);
      waterIntakeMessage = (map["waterIntakeMessage"]);
      fatMessage = (map["fatMessage"]);
      calBurnMessage = (map["calBurnMessage"]);
      weigthMessage = (map["weigthMessage"]);
      goalMessage = (map["goalMessage"]);
      // });
    }
    // double goalPercentage =
    //     (user.weight! - initialWeight) / (desiredWeight - initialWeight);
    // goalPercentage = goalPercentage > 1 ? 1 : goalPercentage;
    // goalPercentage = goalPercentage < 0 ? 0 : goalPercentage;
    // goalPercentage = desiredWeight == initialWeight ? 1 : goalPercentage;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: width * 0.85,
                child: "Progress"
                    .text
                    .size(24)
                    .fontFamily("Montserrat")
                    .fontWeight(FontWeight.w900)
                    .make(),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Pallete.surfaceColor2,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Goal".text.size(16).lineHeight(1.4).make(),
                    Container(
                      margin: EdgeInsets.only(
                          top: height * 0.01, bottom: height * 0.01),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          initialWeight.toString().text.make(),
                          desiredWeight.toString().text.make(),
                        ],
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(15.0),
                      child: LinearPercentIndicator(
                        // restartAnimation: true,
                        // width: width * 0.7,
                        animation: true,
                        lineHeight: 16.0,
                        animationDuration: 1000,
                        percent: goalPercentage,
                        center: Text(
                          "${(goalPercentage * 100).round()}%",
                          style: TextStyle(color: Pallete.blackColor),
                        ),
                        barRadius: const Radius.circular(20),
                        progressColor: Pallete.primaryColor,
                        backgroundColor: Pallete.surfaceColor4,
                      ),
                    ),
                    (goalMessage)
                        .text
                        .align(TextAlign.center)
                        .makeCentered()
                        .box
                        .margin(EdgeInsets.only(
                            top: height * 0.02, bottom: height * 0.01))
                        .make(),
                  ],
                ),
              ),
              Container(
                width: width * 0.85,
                margin: EdgeInsets.only(bottom: 4, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Diet Plan"
                        .text
                        .color(Pallete.primaryColor)
                        .makeCentered()
                        .box
                        .rounded
                        .color(Pallete.surfaceColor2)
                        .width(width * 0.4)
                        .margin(EdgeInsets.only(top: height * 0.015))
                        .height(height * 0.06)
                        .border(color: Pallete.primaryColor)
                        .makeCentered()
                        .onInkTap(() {
                      Navigator.of(context).pushNamed(DietPlan.dietPlanRoute);
                    }),
                    ("Add Today's Details"
                        .text
                        .align(TextAlign.center)
                        .color(Pallete.surfaceColor)
                        .makeCentered()
                        .box
                        .rounded
                        .color(Pallete.primaryColor)
                        .width(width * 0.4)
                        .margin(EdgeInsets.only(top: height * 0.015))
                        .height(height * 0.06)
                        .border(color: Pallete.primaryColor)
                        .makeCentered()
                        .onInkTap(() {
                      Navigator.of(context)
                          .pushNamed(AddTodaysDetails.addTodaysDetailsRoute);
                    }))
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                  padding: const EdgeInsets.all(16),
                  width: width * 0.85,
                  decoration: BoxDecoration(
                    color: Pallete.surfaceColor2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(bottom: 4, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Current BMI:".text.size(16).make(),
                      bmi
                          .toStringAsFixed(1)
                          .text
                          .size(16)
                          .bold
                          .makeCentered()
                          .box
                          .margin(EdgeInsets.only(right: width * 0.1))
                          .make(),
                    ],
                  )),
              // SizedBox(
              //   height: 4,
              // ),
              Container(
                padding: const EdgeInsets.all(16),
                width: width * 0.85,
                decoration: BoxDecoration(
                  color: Pallete.surfaceColor2,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.only(bottom: 4, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Weight"
                        .text
                        .size(16)
                        .make()
                        .box
                        .margin(EdgeInsets.only(bottom: 12))
                        .make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ("${user.progressList!.isEmpty ? user.weight : user.progressList?[0].weight}kg")
                            .text
                            .size(16)
                            .make(),
                        weigthMessage.text
                            .size(14)
                            .color(Pallete.primaryColor)
                            .make(),
                      ],
                    ),
                    if (showWeightChart &&
                        user.progressList != null &&
                        user.progressList!.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: height * 0.02),
                        // width: width * 0.7,
                        height: width * 0.7,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: DChartTime(
                            chartRender: DRenderLine(),
                            innerPadding: 8,
                            outerPadding: 8,
                            startFromZero: false,
                            measureLabel: (value) => '${value}kg',
                            domainLabel: (dateTime) {
                              return DateFormat('d MMM').format(dateTime!);
                            },
                            groupData: [
                              DChartTimeGroup(
                                id: 'Keyboard',
                                color: Pallete.primaryColor,
                                data: [
                                  ...user.progressList!.map((e) {
                                    return DChartTimeData(
                                        time: e.dateTime, value: e.weight ?? 0);
                                  }).toList(),
                                ],
                              ),
                            ],
                            animate: true,
                            measureLabelStyle: const TextStyle(
                              fontSize: 12,
                              color: Pallete.whiteColor,
                            ),
                            domainLabelStyle: const TextStyle(
                              fontSize: 12,
                              color: Pallete.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    if (user.progressList == null || user.progressList!.isEmpty)
                      "No Data Present"
                          .text
                          .color(Pallete.whiteFadeColor)
                          .makeCentered()
                          .box
                          .margin(EdgeInsets.only(top: 4))
                          .makeCentered(),
                    Container(
                      height: height * 0.03,
                      // color: Pallete.blueColor,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            showWeightChart
                                ? Icons.arrow_drop_up_outlined
                                : Icons.arrow_drop_down_outlined,
                            color: Pallete.surfaceColor4,
                          ),
                          onPressed: () {
                            setState(() {
                              showWeightChart = !showWeightChart;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //fat
              Container(
                padding: const EdgeInsets.all(16),
                width: width * 0.85,
                decoration: BoxDecoration(
                  color: Pallete.surfaceColor2,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.only(bottom: 4, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Fat %"
                        .text
                        .size(16)
                        .make()
                        .box
                        .margin(EdgeInsets.only(bottom: 12))
                        .make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ("${user.progressList!.isEmpty ? "-" : user.progressList?[0].fat}%")
                            .text
                            .size(16)
                            .make(),
                        fatMessage
                            // "${weekWeight}kg loss in $inWeeks weeks")
                            .text
                            .size(14)
                            .color(Pallete.primaryColor)
                            .make(),
                      ],
                    ),
                    if (showfatChart &&
                        user.progressList != null &&
                        user.progressList!.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: height * 0.02),
                        // width: width * 0.7,
                        height: width * 0.7,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: DChartTime(
                            chartRender: DRenderLine(),
                            innerPadding: 8,
                            outerPadding: 8,
                            startFromZero: false,
                            measureLabel: (value) => '${value}%',
                            domainLabel: (dateTime) {
                              return DateFormat('d MMM').format(dateTime!);
                            },
                            groupData: [
                              DChartTimeGroup(
                                id: 'Keyboard',
                                color: Pallete.primaryColor,
                                data: [
                                  ...user.progressList!.map((e) {
                                    return DChartTimeData(
                                        time: e.dateTime, value: e.fat ?? 0);
                                  }).toList(),
                                ],
                              ),
                            ],
                            animate: true,
                            measureLabelStyle: const TextStyle(
                              fontSize: 12,
                              color: Pallete.whiteColor,
                            ),
                            domainLabelStyle: const TextStyle(
                              fontSize: 12,
                              color: Pallete.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    if (user.progressList == null || user.progressList!.isEmpty)
                      "No Data Present"
                          .text
                          .color(Pallete.whiteFadeColor)
                          .makeCentered()
                          .box
                          .margin(EdgeInsets.only(top: 4))
                          .makeCentered(),
                    Container(
                      height: height * 0.03,
                      // color: Pallete.blueColor,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            showfatChart
                                ? Icons.arrow_drop_up_outlined
                                : Icons.arrow_drop_down_outlined,
                            color: Pallete.surfaceColor4,
                          ),
                          onPressed: () {
                            setState(() {
                              showfatChart = !showfatChart;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //cal
              Container(
                padding: const EdgeInsets.all(16),
                width: width * 0.85,
                decoration: BoxDecoration(
                  color: Pallete.surfaceColor2,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.only(bottom: 4, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Calorie Burn"
                        .text
                        .size(16)
                        .make()
                        .box
                        .margin(EdgeInsets.only(bottom: 12))
                        .make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ("${user.progressList!.isEmpty ? "-" : user.progressList?[0].weight} cal burn avg")
                            .text
                            .size(16)
                            .make(),
                        calBurnMessage
                            // "${weekWeight}kg loss in $inWeeks weeks")
                            .text
                            .size(14)
                            .color(Pallete.primaryColor)
                            .make(),
                      ],
                    ),
                    if (showCalBurnChart &&
                        user.progressList != null &&
                        user.progressList!.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: height * 0.02),
                        // width: width * 0.7,
                        height: width * 0.7,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: DChartTime(
                            chartRender: DRenderLine(),
                            innerPadding: 8,
                            outerPadding: 8,
                            startFromZero: false,
                            measureLabel: (value) => '${value} cal',
                            domainLabel: (dateTime) {
                              return DateFormat('d MMM').format(dateTime!);
                            },
                            groupData: [
                              DChartTimeGroup(
                                id: 'Keyboard',
                                color: Pallete.primaryColor,
                                data: [
                                  ...user.progressList!.map((e) {
                                    return DChartTimeData(
                                        time: e.dateTime,
                                        value: e.calBurn ?? 0);
                                  }).toList(),
                                ],
                              ),
                            ],
                            animate: true,
                            measureLabelStyle: const TextStyle(
                              fontSize: 12,
                              color: Pallete.whiteColor,
                            ),
                            domainLabelStyle: const TextStyle(
                              fontSize: 12,
                              color: Pallete.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    if (user.progressList == null || user.progressList!.isEmpty)
                      "No Data Present"
                          .text
                          .color(Pallete.whiteFadeColor)
                          .makeCentered()
                          .box
                          .margin(EdgeInsets.only(top: 4))
                          .makeCentered(),
                    Container(
                      height: height * 0.03,
                      // color: Pallete.blueColor,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            showCalBurnChart
                                ? Icons.arrow_drop_up_outlined
                                : Icons.arrow_drop_down_outlined,
                            color: Pallete.surfaceColor4,
                          ),
                          onPressed: () {
                            setState(() {
                              showCalBurnChart = !showCalBurnChart;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //waterIntake
              Container(
                padding: const EdgeInsets.all(16),
                width: width * 0.85,
                decoration: BoxDecoration(
                  color: Pallete.surfaceColor2,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.only(bottom: 4, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Water consumed"
                        .text
                        .size(16)
                        .make()
                        .box
                        .margin(EdgeInsets.only(bottom: 12))
                        .make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ("${user.progressList!.isEmpty ? "-" : user.progressList?[0].waterIntake} L")
                            .text
                            .size(16)
                            .make(),
                        waterIntakeMessage
                            // "${weekWeight}kg loss in $inWeeks weeks")
                            .text
                            .size(14)
                            .color(Pallete.primaryColor)
                            .make(),
                      ],
                    ),
                    if (showwaterIntakeChart &&
                        user.progressList != null &&
                        user.progressList!.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: height * 0.02),
                        // width: width * 0.7,
                        height: width * 0.7,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: DChartTime(
                            chartRender: DRenderLine(),
                            innerPadding: 8,
                            outerPadding: 8,
                            startFromZero: false,
                            measureLabel: (value) => '${value}L',
                            domainLabel: (dateTime) {
                              return DateFormat('d MMM').format(dateTime!);
                            },
                            groupData: [
                              DChartTimeGroup(
                                id: 'Keyboard',
                                color: Pallete.primaryColor,
                                data: [
                                  ...(user.progressList ?? []).map((e) {
                                    return DChartTimeData(
                                        time: e.dateTime,
                                        value: e.waterIntake ?? 0);
                                  }).toList(),
                                ],
                              ),
                            ],
                            animate: true,
                            measureLabelStyle: const TextStyle(
                              fontSize: 12,
                              color: Pallete.whiteColor,
                            ),
                            domainLabelStyle: const TextStyle(
                              fontSize: 12,
                              color: Pallete.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    if (user.progressList == null || user.progressList!.isEmpty)
                      "No Data Present"
                          .text
                          .color(Pallete.whiteFadeColor)
                          .makeCentered()
                          .box
                          .margin(EdgeInsets.only(top: 4))
                          .makeCentered(),
                    Container(
                      height: height * 0.03,
                      // color: Pallete.blueColor,
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            showwaterIntakeChart
                                ? Icons.arrow_drop_up_outlined
                                : Icons.arrow_drop_down_outlined,
                            color: Pallete.surfaceColor4,
                          ),
                          onPressed: () {
                            setState(() {
                              showwaterIntakeChart = !showwaterIntakeChart;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
