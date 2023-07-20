import 'package:flutter/material.dart';
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

class UserPastWorkout extends StatefulWidget {
  static const userPastWorkoutRoute = "/user-past-workout";
  const UserPastWorkout({super.key});

  @override
  State<UserPastWorkout> createState() => _UserPastWorkoutState();
}

class _UserPastWorkoutState extends State<UserPastWorkout> {
  DateTime selectedDay = DateTime.now();
  List<Workout> workoutList = [];

  User user = User(
      gender: "male",
      id: 12,
      coin: 1004,
      level: 5,
      gymId: 007,
      name: "Aman Gupta",
      phone: "123",
      email: "amangupta@gh",
      password: "password",
      progressList: [],
      badgesList: [],
      workoutList: [],
      pastWorkoutList: [
        PastWorkout(
          id: 1,
          dateTime: DateTime.now().add(const Duration(days: 2)),
          workout: Workout(
              id: 25,
              gymId: "235",
              name: "Push5",
              discription: "desisis",
              note: "note sdf",
              createdDate: DateTime.now(),
              updatedDate: DateTime.now(),
              exercises: [],
              durationInMin: 24),
        ),
        PastWorkout(
          id: 1,
          dateTime: DateTime.now().add(const Duration(days: -2)),
          workout: Workout(
              id: 25,
              gymId: "235",
              name: "Push5",
              discription: "desisis",
              note: "note sdf",
              createdDate: DateTime.now(),
              updatedDate: DateTime.now(),
              exercises: [],
              durationInMin: 24),
        ),
        PastWorkout(
          id: 1,
          dateTime: DateTime.now().add(const Duration(days: -6)),
          workout: Workout(
              id: 25,
              gymId: "235",
              name: "Push5",
              discription: "desisis",
              note: "note sdf",
              createdDate: DateTime.now(),
              updatedDate: DateTime.now(),
              exercises: [],
              durationInMin: 24),
        )
      ],
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
      role: Role.member);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
                      return user.pastWorkoutList
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
                        ...user.pastWorkoutList
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
                        if (user.pastWorkoutList
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
