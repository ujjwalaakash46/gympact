import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/models/workout.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/provider/user_state.dart';
import 'package:gympact/service/workout_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class CreateWorkout extends ConsumerStatefulWidget {
  static const createWorkoutRoute = "/create-workout";
  const CreateWorkout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateWorkoutState();
}

class ExerciseController {
  var id = 0;
  final nameController = TextEditingController();
  final noteController = TextEditingController();
  final setsController = TextEditingController();
  final repsController = TextEditingController();
  final weightController = TextEditingController();
  String error = "";
}

class _CreateWorkoutState extends ConsumerState<CreateWorkout> {
  TextEditingController workoutNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  // TextEditingController exerciseNameController = TextEditingController();
  // TextEditingController noteController = TextEditingController();
  // TextEditingController setsController = TextEditingController();
  // TextEditingController repsController = TextEditingController();
  // TextEditingController weightController = TextEditingController();

  var exerciseList = [ExerciseController()];

  _checkExercise() {
    bool isValid = true;
    for (ExerciseController e in exerciseList) {
      var error = "";
      if (e.nameController.text == '') {
        error = "Please fill exercise name";
      } else if (e.setsController.text == '') {
        error = "Please fill exercise sets";
      } else if (e.repsController.text == '') {
        error = "Please fill exercise reps";
      }

      setState(() {
        e.error = error;
      });
      if (error != "") isValid = false;
    }
    return isValid;
  }

  _onTapAddExercise() {
    if (_checkExercise()) {
      setState(() {
        ExerciseController e = ExerciseController();
        e.id = exerciseList.length;
        exerciseList.add(e);
      });
    }
  }

  _onTapSave(BuildContext context) async {
    if (!_checkExercise()) {
      showErrorAlert(context, "Please fill required details of exercise");
    } else if (workoutNameController.text == "") {
      showErrorAlert(context, "Please fill workout name");
    } else if (durationController.text == "") {
      showErrorAlert(context, "Please fill time required for workout");
    } else {
      // Navigator.of(context).pop();
      // print(DateTime.now());
      Workout newWorkout = Workout(
          name: workoutNameController.text,
          discription: descriptionController.text,
          note: "",
          durationInMin: int.parse(durationController.text),
          createdDate: DateTime.now(),
          updatedDate: DateTime.now(),
          exercises: [
            ...exerciseList
                .map((e) => Exercise(
                    0,
                    e.nameController.text,
                    e.noteController.text,
                    int.parse(e.setsController.text),
                    int.parse(e.repsController.text),
                    int.parse(e.weightController.text)))
                .toList()
          ]);

      // save the workout;
      User user = ref.read(userProvider.notifier).get()!;
      final response = await WorkoutService().saveWorkout(user.id!, newWorkout);
      if (response.statusCode == 200) {
        if (user.role == Role.member) {
          ref.read(userProvider.notifier).fetchUserData();
        } else {
          ref.read(gymProvider.notifier).fetchGymDetail();
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showErrorAlert(context, "Error while saving");
        });
      }
    }

    // final pref = await SharedPreferences.getInstance();
    // User userId = pref.getString("userId") ;
  }

  showErrorAlert(BuildContext context, String message) {
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
      },
    );

    AlertDialog alert = AlertDialog(
      // title: const Text("Great work Cham"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              message,
              textAlign: TextAlign.center,
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
            children: [continueButton],
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
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Center(
              child: Column(
                children: [
                  Container(
                    // margin: const EdgeInsets.only(top: 0),
                    width: width * 0.85,
                    child: "Create Workout"
                        .text
                        .size(24)
                        .fontFamily("Montserrat")
                        .fontWeight(FontWeight.w900)
                        .make(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    // padding: EdgeInsets.symmetric(horizontal: 12),
                    width: width * 0.85,
                    child: InputTextField(
                      label: "Workout Name",
                      hint: "eg Push Day",
                      type: TextInputType.name,
                      controller: workoutNameController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    // padding: EdgeInsets.symmetric(horizontal: 12),
                    width: width * 0.85,
                    child: InputTextField(
                      height: 0,
                      label: "Description",
                      hint: "eg: do as the list and last set to the limmit",
                      type: TextInputType.multiline,
                      controller: descriptionController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    // padding: EdgeInsets.symmetric(horizontal: 12),
                    width: width * 0.85,
                    child: InputTextField(
                      label: "Time Required",
                      hint: "eg 45 (in min)",
                      type: TextInputType.number,
                      controller: durationController,
                    ),
                  ),
                  ...exerciseList.map((e) {
                    return Container(
                      margin: EdgeInsets.only(top: height * 0.02),
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.02,
                      ),
                      width: width * 0.85,
                      decoration: BoxDecoration(
                          color: Pallete.surfaceColor3,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: "${e.id + 1}. Exercise"
                                .text
                                .semiBold
                                .size(16)
                                .make(),
                            width: width * 0.7,
                            margin: EdgeInsets.only(bottom: 12),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: width * 0.75,
                            child: InputTextField(
                              label: "Exercise Name",
                              hint: "eg Bench press",
                              type: TextInputType.name,
                              controller: e.nameController,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: width * 0.75,
                            child: InputTextField(
                              label: "note",
                              hint: "(optional)",
                              type: TextInputType.multiline,
                              controller: e.noteController,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                width: width * 0.350,
                                child: InputTextField(
                                  label: "Reps",
                                  hint: "eg 3",
                                  type: TextInputType.number,
                                  controller: e.repsController,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                width: width * 0.350,
                                child: InputTextField(
                                  label: "Sets",
                                  hint: "eg 12",
                                  type: TextInputType.number,
                                  controller: e.setsController,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(bottom: 10),
                                  width: width * 0.350,
                                  child: InputTextField(
                                    label: "weight",
                                    hint: "(optional)",
                                    type: TextInputType.number,
                                    controller: e.weightController,
                                  ),
                                ),
                                if (exerciseList.length > 1)
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Pallete.whiteDarkColor,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      // margin: EdgeInsets.only(bottom: 10),
                                      width: width * 0.350,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete_forever_rounded,
                                          color: Pallete.errorColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            exerciseList.removeAt(e.id);
                                            var i = 0;
                                            for (var exe in exerciseList) {
                                              exe.id = i;
                                              i++;
                                            }
                                          });
                                        },
                                      )),
                              ],
                            ),
                          ),
                          if (e.error != "")
                            "${e.error}".text.color(Pallete.primaryColor).make()
                        ],
                      ),
                    );
                  }).toList(),
                  Container(
                    width: width * 0.85,
                    margin: EdgeInsets.only(bottom: 15, top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        "Add Exercise"
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
                          _onTapAddExercise();
                        }),
                        // if (exerciseList.length > 1)
                        ("Save Workout"
                            .text
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
                          _onTapSave(context);
                        }))
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
