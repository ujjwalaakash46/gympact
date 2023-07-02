import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class UserNotification extends ConsumerStatefulWidget {
  const UserNotification({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserNotificationState();
}

class _UserNotificationState extends ConsumerState<UserNotification> {
  var notificationList = [
    "Gym will be closed from 11am to 2pm  for tomorrow.",
    "Your Package will end in 4 days. Pay early to avoid inconvenience.",
    "Zumba session will be at 6pm Mon-Sat. ",
    "Great Work! Trainer Arjun gave to “Silver Streak”. Now, get 10% off on your next package",
  ];
  var showAllStreakList = false;
  var streakList = [
    {"name": "Arjun Kumar", "streak": 24},
    {"name": "Arun Kumar", "streak": 24},
    {"name": "Aj Kumar", "streak": 23},
    {"name": "Kumar", "streak": 21},
    {"name": "jun Kumar", "streak": 20},
    {"name": "mar", "streak": 20},
    {"name": "Ku", "streak": 20},
  ];

  var showAllAchieversList = false;
  var achieversList = [
    {"name": "Arjun Kumar", "streak": 24},
    {"name": "Arun Kumar", "streak": 24},
    {"name": "Aj Kumar", "streak": 23},
    {"name": "Kumar", "streak": 21},
    {"name": "jun Kumar", "streak": 20},
    {"name": "mar", "streak": 20},
    {"name": "Ku", "streak": 20},
  ];

  var showAllBadgesList = false;
  var badgesList = [
    {
      "name": "Arjun Kumar",
      "badges": ["/img", "/img"]
    },
    {
      "name": "Arun Kumar",
      "badges": ["/img", "/img"]
    },
    {
      "name": "Aj Kumar",
      "badges": ["/img"]
    },
    {
      "name": "Kumar",
      "badges": ["/img"]
    },
    {
      "name": "jun Kumar",
      "badges": ["/img"]
    },
    {
      "name": "mar",
      "badges": ["/img"]
    },
    {
      "name": "Ku",
      "badges": ["/img"]
    },
  ];

  var currentMonth = "June";

  @override
  Widget build(BuildContext context) {
    var streakIndex = 0;
    var achieverIndex = 0;
    var badgesIndex = 0;
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
              ...notificationList.map(
                (e) => Container(
                  width: width * 0.85,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Pallete.surfaceColor2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: e.text.size(14).lineHeight(1.4).make(),
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
                    ...streakList
                        .getRange(0, showAllStreakList ? streakList.length : 5)
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
                                child: Text(e["name"].toString())),
                            SizedBox(
                                // color: Pallete.blueColor,
                                width: width * 0.07,
                                child: Text(e["streak"].toString()))
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
                            0, showAllAchieversList ? achieversList.length : 5)
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
                                child: Text(e["name"].toString())),
                            SizedBox(
                                // color: Pallete.blueColor,
                                width: width * 0.07,
                                child: Text(e["streak"].toString()))
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
                        "People who Earned Badges in $currentMonth",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    ...badgesList
                        .getRange(0, showAllBadgesList ? badgesList.length : 5)
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
