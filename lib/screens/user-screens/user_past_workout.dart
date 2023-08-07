import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/past_workout.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/models/workout.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../provider/user_state.dart';

class UserPastWorkout extends ConsumerStatefulWidget {
  static const userPastWorkoutRoute = "/user-past-workout";
  const UserPastWorkout({super.key});

  @override
  ConsumerState<UserPastWorkout> createState() => _UserPastWorkoutState();
}

class _UserPastWorkoutState extends ConsumerState<UserPastWorkout> {
  DateTime selectedDay = DateTime.now();
  List<Workout> workoutList = [];

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    user = ref.watch(userProvider) ?? user;

    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: (() {
            Navigator.of(context).pop();
          }),
          icon: const Icon(
            Icons.arrow_back,
            color: Pallete.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: SizedBox(
              width: width * 0.85,
              child: Column(
                children: [
                  Container(
                    // margin: const EdgeInsets.only(top: 0),
                    width: width * 0.85,
                    child: "Past Workouts"
                        .text
                        .size(24)
                        .fontFamily("Montserrat")
                        .fontWeight(FontWeight.w900)
                        .make(),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TableCalendar(
                    focusedDay: selectedDay,
                    firstDay: DateTime.now().subtract(const Duration(days: 30)),
                    lastDay: DateTime.now(),
                    rowHeight: height * 0.06,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Pallete.primaryFade2),
                      weekendStyle: TextStyle(color: Pallete.primaryFade2),
                    ),
                    calendarStyle: CalendarStyle(
                      outsideTextStyle:
                          const TextStyle(color: Pallete.surfaceColor4),
                      weekendTextStyle:
                          const TextStyle(color: Pallete.whiteColor),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Pallete.primaryColor),
                        // color: Pallete.primaryFade2,
                      ),
                      selectedTextStyle:
                          const TextStyle(color: Pallete.backgroundColor),
                      markerDecoration: BoxDecoration(
                        border: Border.all(
                            color: Pallete.backgroundColor,
                            width: 1.5,
                            strokeAlign: BorderSide.strokeAlignCenter),
                        color: Pallete.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(91, 0, 0, 0),
                            offset: Offset(
                              0,
                              4.0,
                            ),
                            blurRadius: 9.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      selectedDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(color: Pallete.primaryColor),
                        color: Pallete.primaryFade2,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                        titleCentered: true, formatButtonVisible: false),
                    onDaySelected: (day, focusedDay) => {
                      setState(
                        () {
                          selectedDay = day;
                        },
                      )
                    },
                    selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                    eventLoader: (date) {
                      return (user.pastWorkoutList ?? [])
                          .filter((e) => isSameDay(e.dateTime, date))
                          .map((e) => e.workout)
                          .toList();
                    },
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Container(
                    width: width * 0.85,
                    // height: 2,
                    decoration: const BoxDecoration(
                      color: Pallete.surfaceColor2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: DateFormat('dd  MMM  yyyy')
                              .format(selectedDay)
                              .toString()
                              .text
                              .size(16)
                              .makeCentered(),
                        ),
                        ...(user.pastWorkoutList ?? [])
                            .filter((e) => isSameDay(e.dateTime, selectedDay))
                            .map((e) => Container(
                                  height: height * 0.1,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.07),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      e.workout.name.text
                                          .size(22)
                                          .make()
                                          // .makeCentered()
                                          .box
                                          // .padding(EdgeInsets.only(
                                          //     left: width * 0.08))
                                          // .width(width * 0.5)
                                          .make(),
                                      DateFormat('hh:mm a')
                                          .format(e.dateTime)
                                          .text
                                          .color(Pallete.primaryFade)
                                          .make()
                                          .box
                                          .make()
                                    ],
                                  ),
                                ))
                            .toList(),
                        if ((user.pastWorkoutList ?? [])
                            .filter((e) => isSameDay(e.dateTime, selectedDay))
                            .map((e) => e.workout)
                            .toList()
                            .isEmpty)
                          "No workout"
                              .text
                              .color(Pallete.whiteDarkColor)
                              .makeCentered()
                              .box
                              .height(height * 0.1)
                              .makeCentered()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
