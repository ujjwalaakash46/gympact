import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/badges.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/models/workout.dart';
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
      workoutList: [
        Workout(
            id: 21,
            gymId: "23",
            name: "Push",
            discription: "desisis",
            note: "note sdf",
            createdDate: DateTime.now(),
            updatedDate: DateTime.now(),
            exercises: [
              Exercise(23, "bell", "note", 3, 12, 10),
              Exercise(24, "push ups", "note", 3, 20, 0),
              Exercise(23, "row", "note", 3, 12, 20),
              Exercise(23, "bench", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
            ],
            durationInMin: 24),
        Workout(
            id: 22,
            gymId: "23",
            name: "Push2",
            discription: "desisis",
            note: "note sdf",
            createdDate: DateTime.now(),
            updatedDate: DateTime.now(),
            exercises: [
              Exercise(23, "bell", "note", 3, 12, 10),
              Exercise(24, "push ups", "note", 3, 20, 0),
              Exercise(23, "row", "note", 3, 12, 20),
              Exercise(23, "bench", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
            ],
            durationInMin: 24),
        Workout(
            id: 23,
            gymId: "23",
            name: "Push3",
            discription: "desisis",
            note: "note sdf",
            createdDate: DateTime.now(),
            updatedDate: DateTime.now(),
            exercises: [
              Exercise(23, "bell", "note", 3, 12, 10),
              Exercise(24, "push ups", "note", 3, 20, 0),
              Exercise(23, "row", "note", 3, 12, 20),
              Exercise(23, "bench", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
            ],
            durationInMin: 24),
        Workout(
            id: 24,
            gymId: "23",
            name: "Push4",
            discription: "desisis",
            note: "note sdf",
            createdDate: DateTime.now(),
            updatedDate: DateTime.now(),
            exercises: [
              Exercise(23, "bell",
                  "do whatever you want and be grateful for it", 3, 12, 10),
              Exercise(24, "push ups", "note", 3, 20, 0),
              Exercise(23, "row", "", 3, 12, 20),
              Exercise(23, "bench", "", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
            ],
            durationInMin: 24),
        Workout(
            id: 25,
            gymId: "235",
            name: "Push5",
            discription: "desisis",
            note: "note sdf",
            createdDate: DateTime.now(),
            updatedDate: DateTime.now(),
            exercises: [
              Exercise(23, "bell", "note", 3, 12, 10),
              Exercise(24, "push ups", "note", 3, 20, 0),
              Exercise(23, "row", "note", 3, 12, 20),
              Exercise(23, "bench", "note", 3, 12, 20),
              Exercise(23, "extension", "note", 3, 12, 20),
            ],
            durationInMin: 24),
      ],
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
      progressList: [],
      role: Role.user);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // var workoutList = [
    //   {"name": "Push Day", "img": "url", "timeRequired": "45 min"},
    //   {"name": "Leg Day", "img": "url", "timeRequired": "45 min"},
    //   {"name": "Pull Day", "img": "url", "timeRequired": "45 min"},
    //   {"name": "Warm up", "img": "url", "timeRequired": "10 min"},
    //   {"name": "Push Day", "img": "url", "timeRequired": "60 min"},
    // ];
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text("GymPact")
                  .text
                  .color(Pallete.primaryColor)
                  .size(24)
                  .make(),
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
              "Good Morning"
                  .richText
                  .color(Pallete.secondaryColor)
                  .size(16)
                  .make()
                  .box
                  .alignCenterLeft
                  .padding(
                      EdgeInsets.only(top: height * 0.01, left: width * 0.055))
                  .make(),
              Container(
                margin: EdgeInsets.only(top: height * 0.03),
                width: width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    14
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
              "You're doing great! Make your Attendace and Complete your today's workout."
                  .text
                  .lineHeight(1.7)
                  .center
                  .make()
                  .box
                  .border(
                      style: BorderStyle.solid,
                      color: Pallete.primaryFade,
                      width: 1.5)
                  .rounded
                  .color(Pallete.surfaceColor)
                  .padding(EdgeInsets.all(12))
                  .height(height * 0.15)
                  .width(width * 0.85)
                  .makeCentered(),
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
                    ...user.workoutList.mapIndexed((workout, i) {
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
                                child: (workout.durationInMin)
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
