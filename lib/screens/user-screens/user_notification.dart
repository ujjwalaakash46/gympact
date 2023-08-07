// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:gympact/constants/colors.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/provider/user_state.dart';
import 'package:gympact/service/user_service.dart';

import '../../models/user.dart';

class DiffProgress {
  double weight;
  String name;
  DiffProgress({
    required this.weight,
    required this.name,
  });

  DiffProgress copyWith({
    double? weight,
    String? name,
  }) {
    return DiffProgress(
      weight: weight ?? this.weight,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'weight': weight,
      'name': name,
    };
  }

  factory DiffProgress.fromMap(Map<String, dynamic> map) {
    return DiffProgress(
      weight: map['weight'] as double,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiffProgress.fromJson(String source) =>
      DiffProgress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DiffProgress(weight: $weight, name: $name)';

  @override
  bool operator ==(covariant DiffProgress other) {
    if (identical(this, other)) return true;

    return other.weight == weight && other.name == name;
  }

  @override
  int get hashCode => weight.hashCode ^ name.hashCode;
}

class UserNotification extends ConsumerStatefulWidget {
  const UserNotification({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserNotificationState();
}

class _UserNotificationState extends ConsumerState<UserNotification> {
  var notificationList = [];
  var showAllStreakList = false;
  List<User> streakList = [];

  var showAllAchieversList = false;
  List<DiffProgress> achieversList = [];

  var showAllBadgesList = false;
  var badgesList = [
    // {
    //   "name": "Arjun Kumar",
    //   "badges": ["/img", "/img"]
    // },
    // {
    //   "name": "Arun Kumar",
    //   "badges": ["/img", "/img"]
    // },
    // {
    //   "name": "Aj Kumar",
    //   "badges": ["/img"]
    // },
    // {
    //   "name": "Kumar",
    //   "badges": ["/img"]
    // },
    // {
    //   "name": "jun Kumar",
    //   "badges": ["/img"]
    // },
    // {
    //   "name": "mar",
    //   "badges": ["/img"]
    // },
    // {
    //   "name": "Ku",
    //   "badges": ["/img"]
    // },
  ];

  var currentMonth = "June";

  fetchInitialData() async {
    setState(() {
      currentMonth = DateFormat('MMMM').format(DateTime.now());
    });
    final gymId = ref.read(gymProvider)?.id;
    final responseStreak = await UserService().thisMonthStreakList(gymId!);
    final responseAchiever = await UserService().highAchieverList(gymId);
    if (responseStreak.statusCode == 200 &&
        responseAchiever.statusCode == 200) {
      setState(() {
        print(responseStreak.body);
        streakList = List<User>.from(
            (json.decode(responseStreak.body) as List<dynamic>)
                .map((e) => User.fromMap(e))
                .toList());
        achieversList = List<DiffProgress>.from(
            (json.decode(responseStreak.body) as List<dynamic>)
                .map((e) => DiffProgress.fromMap(e))
                .toList());
      });
    }
  }

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var streakIndex = 0;
    var achieverIndex = 0;
    var badgesIndex = 0;

    final noti = ref.watch(notificationProvider);
    notificationList = noti;

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                child: "Notification"
                    .text
                    .size(24)
                    .fontFamily("Montserrat")
                    .fontWeight(FontWeight.w900)
                    .make(),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              if (notificationList.isEmpty)
                "No Notification"
                    .text
                    .color(Pallete.whiteDarkColor)
                    .makeCentered()
                    .box
                    .width(width * 0.85)
                    .padding(const EdgeInsets.all(12))
                    .withDecoration(BoxDecoration(
                      color: Pallete.surfaceColor2,
                      borderRadius: BorderRadius.circular(15),
                    ))
                    .margin(EdgeInsets.symmetric(vertical: height * 0.02))
                    .make(),
              ...notificationList.map(
                (e) => Container(
                  width: width * 0.85,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Pallete.surfaceColor2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: e.data.text.size(14).lineHeight(1.4).make(),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: width * 0.85,
                child: "Leaderboard"
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Pallete.primaryFade,
                    width: 1.5,
                  ),
                  color: Pallete.surfaceColor,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 12, bottom: 16, left: 4),
                      width: width * 0.85,
                      child: Text(
                        "Highest streak in $currentMonth",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                    //cahnge map to mapIndexed()
                    ...streakList
                        .getRange(
                            0,
                            showAllStreakList || streakList.length < 5
                                ? streakList.length
                                : 5)
                        .map((e) {
                      streakIndex++;
                      return Container(
                        width: width * 0.85,
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 12, left: 15, right: 12),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: streakIndex <= 3
                                ? Pallete.orange
                                : Pallete.surfaceColor3,
                            width: 1,
                          ),
                          color: streakIndex <= 3
                              ? Pallete.orangeFade
                              : Pallete.surfaceColor3,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "$streakIndex.".text.make(),
                            SizedBox(
                                // color: Pallete.commonBlueColor,
                                width: width * 0.55,
                                child: Text(e.name.toString())),
                            SizedBox(
                                // color: Pallete.blueColor,
                                width: width * 0.07,
                                child:
                                    Text(e.highestStreakThisMonth.toString()))
                          ],
                        ),
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ((!showAllStreakList) ? "View All" : "Hide All")
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                            .box
                            .padding(const EdgeInsets.all(8))
                            .make()
                            .onTap(() {
                          setState(() {
                            showAllStreakList = !showAllStreakList;
                          });
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Pallete.primaryFade,
                    width: 1.5,
                  ),
                  color: Pallete.surfaceColor,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 12, bottom: 16, left: 4),
                      width: width * 0.85,
                      child: Text(
                        "Highest Achiever in $currentMonth",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ...achieversList
                        .getRange(
                            0,
                            showAllAchieversList || achieversList.length < 5
                                ? achieversList.length
                                : 5)
                        .map((e) {
                      achieverIndex++;
                      return Container(
                        width: width * 0.85,
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 12, left: 15, right: 12),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: achieverIndex <= 3
                                ? Pallete.orange
                                : Pallete.surfaceColor3,
                            width: 1,
                          ),
                          color: achieverIndex <= 3
                              ? Pallete.orangeFade
                              : Pallete.surfaceColor3,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "$achieverIndex.".text.make(),
                            SizedBox(
                                // color: Pallete.commonBlueColor,
                                width: width * 0.55,
                                child: Text(e.name.toString())),
                            SizedBox(
                                // color: Pallete.blueColor,
                                width: width * 0.09,
                                child: Text(e.weight.toString()))
                          ],
                        ),
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ((!showAllAchieversList) ? "View All" : "Hide All")
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                            .box
                            .padding(const EdgeInsets.all(8))
                            .make()
                            .onTap(() {
                          setState(() {
                            showAllAchieversList = !showAllAchieversList;
                          });
                        }),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: width * 0.85,
                child: "Badges Won"
                    .text
                    .size(24)
                    .fontFamily("Montserrat")
                    .fontWeight(FontWeight.w900)
                    .make(),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Pallete.primaryFade,
                    width: 1.5,
                  ),
                  color: Pallete.surfaceColor,
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 12, bottom: 16, left: 4),
                      width: width * 0.85,
                      child: Text(
                        "People who Earned Badges in $currentMonth}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    if (badgesList.isEmpty)
                      "adding this shortly"
                          .text
                          .color(Pallete.whiteDarkColor)
                          .makeCentered()
                          .box
                          .width(width * 0.85)
                          .padding(const EdgeInsets.all(12))
                          // .withDecoration(BoxDecoration(
                          //   color: Pallete.surfaceColor2,
                          //   borderRadius: BorderRadius.circular(15),
                          // ))
                          // .margin(EdgeInsets.symmetric(vertical: height * 0.02))
                          .make(),
                    ...badgesList
                        .getRange(
                            0,
                            showAllBadgesList || badgesList.length < 5
                                ? badgesList.length
                                : 5)
                        .map((e) {
                      badgesIndex++;
                      return Container(
                        width: width * 0.85,
                        padding: const EdgeInsets.only(
                            top: 12, bottom: 12, left: 15, right: 12),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Pallete.surfaceColor3,
                            width: 1,
                          ),
                          color: Pallete.surfaceColor3,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "$badgesIndex.".text.make(),
                            SizedBox(
                                // color: Pallete.commonBlueColor,
                                width: width * 0.3,
                                child: Text(e["name"].toString())),
                            SizedBox(
                                // color: Pallete.blueColor,
                                width: width * 0.3,
                                child: Text(e["badges"].toString()))
                          ],
                        ),
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ((!showAllBadgesList) ? "View All" : "Hide All")
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                            .box
                            .padding(const EdgeInsets.all(8))
                            .make()
                            .onTap(() {
                          setState(() {
                            showAllBadgesList = !showAllBadgesList;
                          });
                        }),
                      ],
                    )
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
