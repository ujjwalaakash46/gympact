import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/common/common_methods.dart';
import 'package:gympact/models/badges.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/screens/user_setting.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfile extends ConsumerStatefulWidget {
  const UserProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  User user = User(
      id: 12,
      coin: 1004,
      level: 5,
      gymId: 007,
      name: "Aman Gupta",
      phone: "123",
      email: "amangupta@gh",
      password: "password",
      badgesList: [
        Badges(id: 1, name: "best", img: "/img", date: DateTime.now()),
        Badges(id: 4, name: "best4", img: "/img", date: DateTime.now()),
        Badges(id: 5, name: "best5", img: "/img", date: DateTime.now()),
        Badges(id: 6, name: "best6", img: "/img", date: DateTime.now()),
        Badges(
            id: 2,
            name: "best2",
            img: "/img",
            date: DateTime.now().add(Duration(days: 70))),
        Badges(
            id: 3,
            name: "best3",
            img: "/img",
            date: DateTime.now().add(Duration(days: 30))),
      ],
      workoutList: [],
      pastWorkoutList: [],
      diet: null,
      progress: null,
      weight: 65,
      heigth: 165,
      goal: "To get fitter",
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
      role: Role.user);

  int waterReminder = 0;
  var waterReminderList = [
    {"name": "No Reminder", "value": 0},
    {"name": "1 hr", "value": 1},
    {"name": "2 hrs", "value": 2},
    {"name": "3 hrs", "value": 3},
    {"name": "4 hrs", "value": 4},
  ];

  int stretchingReminder = 0;
  var stretchingReminderList = [
    {"name": "No Reminder", "value": 0},
    {"name": "1 hr", "value": 1},
    {"name": "2 hrs", "value": 2},
    {"name": "3 hrs", "value": 3},
    {"name": "4 hrs", "value": 4},
  ];

  var showSaveReminderBtn = false;
  @override
  Widget build(BuildContext context) {
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
                // color: Pallete.surfaceColor,
                width: width * 0.85,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: "Profile"
                          .text
                          .size(24)
                          .fontFamily("Montserrat")
                          .fontWeight(FontWeight.w900)
                          .make(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Power Coins"
                                  .text
                                  .color(Pallete.primaryColor)
                                  .make(),
                              "${user.coin}"
                                  .text
                                  .make()
                                  .box
                                  .width(width * 0.1)
                                  .makeCentered(),
                            ],
                          ).box.width(width * 0.35).make(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              "Level".text.color(Pallete.primaryColor).make(),
                              "${user.level}"
                                  .text
                                  .make()
                                  .box
                                  .width(width * 0.1)
                                  .makeCentered(),
                            ],
                          ).box.width(width * 0.35).make(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width * 0.85,
                margin: const EdgeInsets.only(top: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Pallete.surfaceColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      // color: Pallete.ligthBlack,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          user.name.text.size(20).make(),
                          // ("${Common.getAge(user.dob).toString()} yrs")
                          //     .text
                          //     .make()
                          //     .box
                          //     .margin(const EdgeInsets.only(right: 28))
                          //     .make()
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            user.currentPackage.package.name.text
                                .color(Pallete.primaryColor)
                                .make()
                                .box
                                .margin(const EdgeInsets.symmetric(vertical: 8))
                                .make(),
                            Text("${Common.formatDate(user.currentPackage.startDate)} - ${Common.formatDate(user.currentPackage.endDate)}")
                                .box
                                .margin(const EdgeInsets.only(bottom: 16))
                                .make(),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Joined on"
                                .text
                                .make()
                                .box
                                .margin(const EdgeInsets.symmetric(vertical: 8))
                                .make(),
                            Common.formatDate(user.joinOn)
                                .text
                                .make()
                                .box
                                .margin(const EdgeInsets.only(bottom: 16))
                                .make()
                          ],
                        )
                      ],
                    ),
                    HStack(
                      [
                        "Weight"
                            .text
                            // .color(Pallete.primaryFade)
                            .make()
                            .box
                            .width(width * 0.3)
                            .make(),
                        ("${user.weight.toString()} Kg")
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                      ],
                    )
                        .box
                        .margin(const EdgeInsets.symmetric(vertical: 8))
                        .make(),
                    HStack(
                      [
                        "Height".text.make().box.width(width * 0.3).make(),
                        ("${user.heigth.toString()} cm")
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                      ],
                    )
                        .box
                        .margin(const EdgeInsets.symmetric(vertical: 8))
                        .make(),
                    HStack(
                      [
                        "Goal".text.make().box.width(width * 0.3).make(),
                        user.goal
                            .toString()
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                      ],
                    )
                        .box
                        .margin(const EdgeInsets.symmetric(vertical: 8))
                        .make(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    HStack([
                      "Water Reminder"
                          .text
                          .make()
                          .box
                          .width(width * 0.45)
                          .make(),
                      DropdownButton<int>(
                        itemHeight: kMinInteractiveDimension,
                        style: const TextStyle(fontSize: 16),
                        value: waterReminder,
                        borderRadius: BorderRadius.circular(24),
                        items: waterReminderList.map((var value) {
                          return DropdownMenuItem<int>(
                            value: (value["value"] as int),
                            child: Text("${value["name"]}").box.make(),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            showSaveReminderBtn = true;
                            waterReminder = value!;
                          });
                        },
                      )
                    ]),
                    HStack([
                      "Stretching Reminder"
                          .text
                          .make()
                          .box
                          .width(width * 0.45)
                          .make(),
                      DropdownButton<int>(
                        style: const TextStyle(fontSize: 16),
                        value: stretchingReminder,
                        borderRadius: BorderRadius.circular(24),
                        items: stretchingReminderList.map((var value) {
                          return DropdownMenuItem<int>(
                            value: (value["value"] as int),
                            child: "${value["name"]}".text.make(),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            showSaveReminderBtn = true;
                            stretchingReminder = value!;
                          });
                        },
                      )
                    ]),
                    "we will send notification reminder"
                        .text
                        .italic
                        .color(Pallete.whiteDarkColor)
                        .make()
                        .box
                        .margin(EdgeInsets.only(top: 4, bottom: height * 0.012))
                        .make(),
                    if (showSaveReminderBtn)
                      "save"
                          .text
                          .size(16)
                          .color(Pallete.surfaceColor)
                          .makeCentered()
                          .box
                          .rounded
                          .height(height * 0.03)
                          .margin(EdgeInsets.only(
                              left: width * 0.6, bottom: height * 0.012))
                          .width(width * 0.16)
                          .color(Pallete.primaryColor)
                          .make(),
                    // "Badges Earned".text.make(),
                  ],
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                width: width * 0.85,
                height: height * 0.18,
                margin: EdgeInsets.all(16),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: Pallete.surfaceColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: VStack(
                  [
                    "Badges Earned"
                        .text
                        .make()
                        .box
                        .margin(const EdgeInsets.only(left: 10, bottom: 15))
                        .make(),
                    SizedBox(
                      height: height * 0.1,
                      width: width * 0.85,
                      child: GridView.count(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        crossAxisCount: 1,
                        children: user.badgesList
                            .map((e) => "${e.name}"
                                .text
                                .make()
                                .box
                                .margin(EdgeInsets.all(8))
                                .height(10)
                                .width(10)
                                .color(Pallete.commonBlueColor)
                                .make())
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (() {}),
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Pallete.primaryColor, width: 1.5)),
                      child: "Logout".text.size(14).makeCentered(),
                    ).box.make(),
                  ),
                  InkWell(
                    onTap: (() {
                      Navigator.of(context)
                          .pushNamed(UserSetting.userSettingRoute);
                    }),
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          color: Pallete.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Pallete.primaryColor, width: 1.5)),
                      child: "Edit Profile"
                          .text
                          .color(Pallete.surfaceColor)
                          .size(14)
                          .makeCentered(),
                    ),
                  )
                ],

                // crossAlignment: CrossAxisAlignment.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
