// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/models/past_workout.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/provider/user_state.dart';
import 'package:gympact/service/user_service.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/workout.dart';

import '../../models/user.dart';

class ExerciseChecked {
  Exercise exercise;
  bool checked;
  int id;

  ExerciseChecked({
    required this.exercise,
    required this.checked,
    required this.id,
  });
}

class UserWorkout extends ConsumerStatefulWidget {
  static const userWorkoutRoute = "/user-workout";

  const UserWorkout({super.key});

  @override
  ConsumerState<UserWorkout> createState() => _UserWorkoutState();
}

class _UserWorkoutState extends ConsumerState<UserWorkout> {
  bool initialize = true;
  bool workoutStarted = false;
  bool workoutCompleted = false;
  String error = "";

  List<ExerciseChecked> exerciseList = [];
  Workout workout = Workout(
      id: 24,
      name: "Push Day",
      discription: "discription",
      note: "note",
      createdDate: DateTime.now(),
      updatedDate: DateTime.now(),
      exercises: [
        Exercise(1, "Dumb bell press", "note", 3, 12, 10),
        Exercise(2, "Push up", "note", 3, 12, 0),
      ],
      durationInMin: 24);

  workoutUnfinieshAlert(BuildContext context) {
    Widget exitButton = TextButton(
      child: Container(
        width: 100,
        height: 65,
        decoration: BoxDecoration(
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
            color: Pallete.primaryDarkFade,
            border: Border.all(
              style: BorderStyle.solid,
              color: Pallete.primaryFade,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: const Center(
          child: Text(
            "Yes,\nfor now",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: Container(
          width: 100,
          height: 65,
          decoration: BoxDecoration(
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
              color: Pallete.primaryColor,
              border: Border.all(
                style: BorderStyle.solid,
                color: Pallete.primaryFade,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: Text(
              "No, let's continue",
              textAlign: TextAlign.center,
              style: TextStyle(color: Pallete.backgroundColor),
            ),
          )),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
              "Your workout isn't completed yet. Do you wanna exit?",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [exitButton, continueButton],
          )
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  workoutFinishedAlert(BuildContext context) {
    Widget continueButton = TextButton(
      child: Container(
          width: 100,
          height: 45,
          decoration: BoxDecoration(
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
              color: Pallete.primaryColor,
              border: Border.all(
                style: BorderStyle.solid,
                color: Pallete.primaryFade,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: Text(
              "Okay",
              textAlign: TextAlign.center,
              style: TextStyle(color: Pallete.backgroundColor),
            ),
          )),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      // title: const Text("Great work Cham"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: const Text(
              "Great work Champion!\nKeep it up.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Pallete.whiteFadeColor,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: const Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Your have earned\n',
                      style: TextStyle(
                          fontSize: 14, color: Pallete.whiteFadeColor),
                    ),
                    TextSpan(
                      text: '+10 Respect',
                      style:
                          TextStyle(fontSize: 18, color: Pallete.primaryColor),
                    ),
                    TextSpan(
                      text: ' and\n',
                      style: TextStyle(
                          fontSize: 14, color: Pallete.whiteFadeColor),
                    ),
                    TextSpan(
                      text: '+100 Powercoin!',
                      style:
                          TextStyle(fontSize: 18, color: Pallete.primaryColor),
                    ),
                  ],
                ),
              )
              // const Text(
              //   "Your have earned\n+10 Respect and +100 Powercoin!",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: 14,
              //   ),
              // ),
              ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [continueButton],
          )
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onExit() async {
    if (workoutStarted) {
      if (!workoutCompleted) {
        workoutUnfinieshAlert(context);
      } else {
        PastWorkout p = PastWorkout(dateTime: DateTime.now(), workout: workout);
        User user = ref.read(userProvider.notifier).get()!;

        final response = await UserService().savePastWorkout(user.id!, p);
        if (response.statusCode == 200) {
          ref.read(userProvider.notifier).fetchUserData();
          setState(() {
            error = "";
          });
          if (context.mounted) workoutFinishedAlert(context);
        } else {
          setState(() {
            error = "Error while saving";
          });
        }
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var index = 0;

    if (initialize) {
      workout = ModalRoute.of(context)?.settings.arguments as Workout;
      exerciseList = workout.exercises.map((e) {
        ExerciseChecked eee =
            ExerciseChecked(exercise: e, checked: false, id: index++);
        return eee;
      }).toList();
      initialize = false;
    }

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        onExit();
        return false;
      },
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        appBar: AppBar(
          backgroundColor: Pallete.backgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: (() {
              onExit();
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
              child: Column(
                children: [
                  Container(
                    // margin: const EdgeInsets.only(top: 0),
                    width: width * 0.85,
                    child: workout.name.text
                        .size(24)
                        .fontFamily("Montserrat")
                        .fontWeight(FontWeight.w900)
                        .make(),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    width: width * 0.85,
                    child: workout.note.text.align(TextAlign.left).make(),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.92,
                    child: Column(
                      children: [
                        if (!workoutStarted)
                          (Container(
                                  child: "Start Workout"
                                      .text
                                      .color(Pallete.backgroundColor)
                                      .size(16)
                                      .semiBold
                                      .makeCentered()
                                      .box
                                      .customRounded(
                                          BorderRadius.circular(height * 0.02))
                                      .rounded
                                      .color(Pallete.primaryColor)
                                      .margin(
                                          EdgeInsets.only(top: height * 0.030))
                                      .height(height * 0.065)
                                      .width(width * 0.4)
                                      .makeCentered())
                              .onTap(() {
                            setState(() {
                              workoutStarted = true;
                            });
                          }))
                        else
                          ("Let's finish it Champion!"
                              .text
                              .size(16)
                              .semiBold
                              .makeCentered()),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        ...exerciseList.mapIndexed((ex, i) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: width,
                            // height: height * 0.12,
                            decoration: BoxDecoration(
                              color: Pallete.surfaceColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                '${i + 1}.'
                                    .toString()
                                    .text
                                    .size(12)
                                    .make()
                                    .box
                                    .margin(EdgeInsets.only(top: 2))
                                    .width(width * 0.05)
                                    .make(),
                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  width: width * 0.43,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ex.exercise.name.text
                                          .size(16)
                                          .make()
                                          .box
                                          .margin(
                                              const EdgeInsets.only(bottom: 8))
                                          .make(),
                                      if (ex.exercise.note != "")
                                        ex.exercise.note.text.size(12).make(),
                                      if (ex.exercise.weight != 0)
                                        (('${ex.exercise.weight.toString()}kg')
                                            .text
                                            .make()
                                            .box
                                            .margin(EdgeInsets.only(top: 4))
                                            .make())
                                      else
                                        (" ".toString().text.make())
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 6),
                                  // width: width * 0.5,
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "Sets"
                                          .text
                                          .color(Pallete.primaryColor)
                                          .make()
                                          .box
                                          // .margin(
                                          //     const EdgeInsets.only(bottom: 8))
                                          .make(),
                                      "".text.make(),
                                      ex.exercise.sets.toString().text.make()
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 10, right: 7),
                                  // width: width * 0.5,
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "Reps"
                                          .text
                                          .color(Pallete.primaryColor)
                                          .make()
                                          .box
                                          // .margin(
                                          //     const EdgeInsets.only(bottom: 8))
                                          .make(),
                                      "".text.make(),
                                      ex.exercise.reps.toString().text.make()
                                    ],
                                  ),
                                ),
                                if (workoutStarted)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18),
                                    child: Checkbox(
                                      splashRadius: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      activeColor: Pallete.primaryColor,
                                      checkColor: Pallete.backgroundColor,
                                      value: exerciseList[ex.id].checked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          exerciseList[ex.id].checked =
                                              !exerciseList[ex.id].checked;
                                        });
                                        if (exerciseList.any((element) =>
                                            element.checked == false)) {
                                          setState(() {
                                            workoutCompleted = false;
                                          });
                                        } else {
                                          setState(() {
                                            workoutCompleted = true;
                                          });
                                        }
                                        print(workoutCompleted);
                                      },
                                    ),
                                  )
                              ],
                            ),
                          );
                        }).toList(),
                        if (!error.isEmpty) error.text.make(),
                        if (workoutStarted)
                          Container(
                                  child: ((workoutCompleted)
                                          ? "Finished"
                                          : "Stop")
                                      .text
                                      .color(Pallete.backgroundColor)
                                      .size(16)
                                      .semiBold
                                      .makeCentered()
                                      .box
                                      .customRounded(
                                          BorderRadius.circular(height * 0.02))
                                      .rounded
                                      .color(Pallete.primaryColor)
                                      .margin(
                                          EdgeInsets.only(top: height * 0.030))
                                      .height(height * 0.065)
                                      .width(width * 0.4)
                                      .makeCentered())
                              .onTap(() {
                            onExit();
                          })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
