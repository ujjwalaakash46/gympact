import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/workout.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/screens/common/create_workout.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminWorkouts extends ConsumerStatefulWidget {
  static const adminWorkoutsRoute = "/admin-workouts";
  const AdminWorkouts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminWorkoutsState();
}

class _AdminWorkoutsState extends ConsumerState<AdminWorkouts> {
  bool isViewWorkout = false;
  int viewWorkoutIndex = 0;

  List<Workout> workoutList = [
    Workout(
        id: 21,
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
        name: "Push4",
        discription: "desisis",
        note: "note sdf",
        createdDate: DateTime.now(),
        updatedDate: DateTime.now(),
        exercises: [
          Exercise(23, "bell", "do whatever you want and be grateful for it", 3,
              12, 10),
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
  ];

  _onExit() {
    if (isViewWorkout == true) {
      setState(() {
        isViewWorkout = false;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  _viewWorkout(BuildContext context) {
    Workout workout = workoutList[viewWorkoutIndex];
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return [
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
            SizedBox(
              height: height * 0.02,
            ),
            ...workout.exercises.mapIndexed((ex, i) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ex.name.text
                              .size(16)
                              .make()
                              .box
                              .margin(const EdgeInsets.only(bottom: 8))
                              .make(),
                          if (ex.note != "") ex.note.text.size(12).make(),
                          if (ex.weight != 0)
                            (('${ex.weight.toString()}kg')
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
                          ex.sets.toString().text.make()
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 7),
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
                          ex.reps.toString().text.make()
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final workoutListState = ref.watch(gymProvider)?.workouts;
    workoutList = workoutListState ?? [];

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: (() {
            _onExit();
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
                if (!isViewWorkout) ...[
                  Container(
                    margin: const EdgeInsets.only(),
                    width: width * 0.85,
                    child: "Workouts"
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
                        color: Pallete.surfaceColor,
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: Pallete.primaryFade,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: "Add New Workout"
                          .text
                          .color(Pallete.primaryFade2)
                          .makeCentered(),
                    ).onTap(() {
                      Navigator.of(context)
                          .pushNamed(CreateWorkout.createWorkoutRoute);
                    }),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ...workoutList.mapIndexed((workout, i) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Pallete.surfaceColor,
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.all(12),
                      height: height * 0.1,
                      width: width * 0.85,
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
                      setState(() {
                        isViewWorkout = !isViewWorkout;
                        viewWorkoutIndex = i;
                      });
                    });
                  }),
                ],
                if (isViewWorkout) ..._viewWorkout(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
