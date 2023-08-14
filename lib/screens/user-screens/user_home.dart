import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/gym.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/provider/user_state.dart';
import 'package:gympact/screens/common/create_workout.dart';
import 'package:gympact/screens/user-screens/user_attendance.dart';
import 'package:gympact/screens/user-screens/user_past_workout.dart';
import 'package:gympact/screens/user-screens/user_workout.dart';
import 'package:velocity_x/velocity_x.dart';

class UserHome extends ConsumerStatefulWidget {
  const UserHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserHomeState();
}

class _UserHomeState extends ConsumerState<UserHome> {
  void onTapMarkAttendance() {
    Navigator.of(context).pushNamed(UserAttendance.userAttendanceRoute);
  }

  User user = User(
      gender: "male",
      id: 1,
      coin: 1,
      level: 1,
      gymId: "007",
      name: "",
      phone: "",
      email: "",
      password: "",
      badgesList: [],
      workoutList: [],
      pastWorkoutList: [],
      diet: null,
      progress: null,
      weight: 65,
      heigth: 165,
      goal: "To get fitter",
      currentPackage: null,
      dob: DateTime(1999, 8, 1),
      joinOn: DateTime.now(),
      lastVisit: DateTime.now(),
      progressList: [],
      role: Role.member);
  Gym gym = Gym(
    id: 1,
    name: "The Power Gym",
    admins: [],
    trainers: [],
    workouts: [],
    diets: [],
    packages: [],
    groups: [],
  );
  String greeting = "Good Morning";

  fetchDetails() async {
    user = ref.read(userProvider.notifier).get()!;
    gym = ref.read(gymProvider.notifier).get()!;
    ref.read(homeMessageProvider.notifier).fetchMessages(user.id!);
    DateTime currentTime = DateTime.now();
    int currentHour = currentTime.hour;
    if (currentHour >= 16) {
      greeting = "Good Evening";
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    user = ref.watch(userProvider) ?? user;
    gym = ref.watch(gymProvider) ?? gym;

    String message = "Yo do something";
    Map<String, dynamic> messageMap = ref.watch(homeMessageProvider);
    try {
      List<String> movitaionalList =
          (messageMap["movitaional"] as List<dynamic>)
              .map((e) => e.toString())
              .toList();

      print(movitaionalList);
      int messageIndex = Random().nextInt(movitaionalList.length);
      message = movitaionalList[messageIndex];
      print(message);
    } catch (e) {
      print(e);
    }
    final imgIndex = Random().nextInt(4) + 1;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              gym.name.text.color(Pallete.primaryColor).size(24).make(),
              Container(
                margin: EdgeInsets.only(top: height * 0.03),
                width: width * 0.85,
                child: Row(
                  children: [
                    "Hello ".text.color(Pallete.secondaryColor).size(26).make(),
                    // '${user.name},'
                    user.name
                        .split(" ")[0]
                        .text
                        .color(Pallete.secondaryColor)
                        .fontWeight(FontWeight.w700)
                        .size(26)
                        .make()
                  ],
                ),
              ),
              greeting.richText
                  .color(Pallete.secondaryColor)
                  .size(16)
                  .make()
                  .box
                  .alignCenterLeft
                  .padding(
                      EdgeInsets.only(top: height * 0.01, left: width * 0.055))
                  .make(),
              if ((user.currentStreak ?? 0) != 0)
                Container(
                  margin: EdgeInsets.only(top: height * 0.03),
                  width: width * 0.85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      user.currentStreak
                          .toString()
                          .text
                          .color(Pallete.orange)
                          .color(Pallete.secondaryColor)
                          .fontWeight(FontWeight.w700)
                          .size(16)
                          .make(),
                      ' days Streak! 🔥'
                          .text
                          .color(Pallete.secondaryColor)
                          .fontWeight(FontWeight.w700)
                          .size(16)
                          .make()
                    ],
                  ),
                ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/lion$imgIndex.png",
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                      width: width * 0.5,
                      child: ("\"" + message + "\"")
                          .text
                          .size(16)
                          .lineHeight(1.7)
                          .center
                          .make())
                ],
              )
                  .box
                  .rounded
                  .color(Pallete.surfaceColor)
                  // .padding(EdgeInsets.all(12))
                  .height(height * 0.15)
                  .width(width * 0.85)
                  .makeCentered(),
              // message.text
              //     .lineHeight(1.7)
              //     .center
              //     .make()
              //     .box
              //     // .border(
              //     //     style: BorderStyle.solid,
              //     //     // color: Pallete.primaryFade,
              //     //     width: 1.5)
              //     .rounded
              //     .color(Pallete.surfaceColor)
              //     .padding(EdgeInsets.all(12))
              //     .height(height * 0.15)
              //     .width(width * 0.85)
              //     .makeCentered(),
              HStack(
                [
                  "Mark Attendance"
                      .text
                      .color(Pallete.backgroundColor)
                      .size(16)
                      .semiBold
                      .make()
                      .box
                      .margin(EdgeInsets.only(left: width * 0.1))
                      .make(),
                  const Icon(
                    Icons.arrow_right_alt_sharp,
                    color: Pallete.backgroundColor,
                    size: 42,
                  )
                ],
                alignment: MainAxisAlignment.spaceAround,
              )
                  .box
                  .customRounded(BorderRadius.circular(height * 0.025))
                  .rounded
                  .color(Pallete.primaryColor)
                  .margin(EdgeInsets.only(top: height * 0.030))
                  .height(height * 0.07)
                  .width(width * 0.75)
                  .makeCentered()
                  .onTap(() {
                onTapMarkAttendance();
                // VxToast.show(context, msg: "Hello from vx");
                // print(DateTime.now().day);
              }),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                // padding: EdgeInsets.only(top: height * 0.03),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Workout Plan".text.size(18).make(),
                          "Past Workout"
                              .text
                              .color(Pallete.primaryColor)
                              .size(12)
                              .makeCentered()
                              .box
                              .padding(const EdgeInsets.all(8))
                              .rounded
                              .border(
                                color: Pallete.surfaceColor4,
                                width: 0.8,
                              )
                              .make()
                              .onInkTap(() {
                            Navigator.of(context).pushNamed(
                                UserPastWorkout.userPastWorkoutRoute);
                          })
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    "Last you did Push Day workout on 15th May"
                        .text
                        .size(12)
                        .makeCentered(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    ...(user.workoutList ?? []).mapIndexed((workout, i) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Pallete.backgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                        margin: const EdgeInsets.only(bottom: 3),
                        padding: const EdgeInsets.all(12),
                        height: height * 0.1,
                        width: width * 0.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: (workout.name).text.size(14).make(),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Container(
                                padding: const EdgeInsets.only(left: 8),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        width: 2, color: Pallete.primaryColor),
                                  ),
                                ),
                                child: ("${workout.durationInMin} min")
                                    .text
                                    .color(Pallete.whiteDarkColor)
                                    .size(12)
                                    .make()),
                          ],
                        ),
                      ).onInkTap(() {
                        Navigator.pushNamed(
                            context, UserWorkout.userWorkoutRoute,
                            arguments: workout);
                      });
                    }).toList(),
                    Container(
                      margin: const EdgeInsets.only(top: 18, bottom: 6),
                      padding: const EdgeInsets.all(12),
                      height: height * 0.065,
                      width: width * 0.7,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(66, 14, 14, 14),
                              offset: Offset(
                                0,
                                4.0,
                              ),
                              blurRadius: 9.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                          color: Pallete.primaryDarkFade,
                          // border: Border.all(
                          //   style: BorderStyle.solid,
                          //   color: Pallete.primaryFade,
                          //   width: 1.5,
                          // ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: "Add New Workout"
                              .text
                              .color(Pallete.primaryFade2)
                              .makeCentered()
                              .box
                              .make()
                              .onInkTap(() {
                        Navigator.of(context)
                            .pushNamed(CreateWorkout.createWorkoutRoute);
                      })),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
