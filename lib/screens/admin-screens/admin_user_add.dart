import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/badges.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/diet.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:gympact/models/workout.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/service/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminUserAdd extends ConsumerStatefulWidget {
  static const adminUserAddRoute = "/admin-user-add";
  const AdminUserAdd({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminUserAddState();
}

class _AdminUserAddState extends ConsumerState<AdminUserAdd> {
  bool initialize = true;
  bool isAddUser = true;

  //user controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heigthController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late int coin;
  late int level;
  late int gymId;

  // List<Badges> badgesList = [];
  // List<Workout> workoutList = [];
  Diet? diet;
  CurrentPackage? currentPackage;
  Package? package;
  DateTime dob = DateTime.now();
  DateTime packageStarted = DateTime.now();

  DateTime lastVisit = DateTime.now();
  DateTime joinedOn = DateTime.now();
  bool isPresentToday = false;

  Role role = Role.member;
  String? goal;
  String? profileImg;
  File? image;
  String gender = "male";

  List<String> gymGoalList = [
    "Get Fitter",
    "Loss Weigth",
    "Gain Weight",
    "Maintain Health"
  ];
  List<Workout> gymWorkoutList = [];
  List<Workout> selectedWorkoutList = [];
  List<Diet> gymDietList = [];
  List<Package> gymPackageList = [];
  List<Role> gymRoleList = [
    Role.member,
    Role.admin,
    Role.trainer,
  ];

  Future getImage(ImageSource source) async {
    final img = await ImagePicker().pickImage(source: source);
    if (img == null) return;
    setState(() {
      image = File(img.path);
    });
  }

  String error = "";
  _onTapSave() async {
    var newErrorMessage = "";
    if (nameController.text.isEmpty) {
      newErrorMessage = "Name is Empty";
    } else if (phoneController.text.isEmpty) {
      newErrorMessage = "Phone number is not set";
    } else if (weightController.text.isEmpty) {
      newErrorMessage = "Weigth is not set";
    } else if (heigthController.text.isEmpty) {
      newErrorMessage = "Height is not set";
    } else if (image == null) {
      newErrorMessage = "Image is not set";
    } else if (selectedWorkoutList.isEmpty) {
      newErrorMessage = "Workouts is not set";
    }
    setState(() {
      error = newErrorMessage;
    });
    if (error.isEmpty) {
      //
      //save User;
      //
      // _onExit();
      if (gymPackageList.isEmpty) {
        setState(() {
          error = "No Package available";
        });
      }
      if (gymDietList.isEmpty) {
        setState(() {
          error = "No diet plan available";
        });
      }
      package ??= gymPackageList[0];
      diet ??= gymDietList[0];
      goal ??= gymGoalList[0];

      DateTime packageEndDate = DateTime(packageStarted.year,
          packageStarted.month + package!.durationInMonths, packageStarted.day);
      CurrentPackage userPackage = CurrentPackage(
          package: package!,
          startDate: packageStarted,
          endDate: packageEndDate);

      User newUser = User(
          joinOn: DateTime.now(),
          lastVisit: DateTime.now(),
          role: role,
          dob: dob,
          coin: 0,
          level: 1,
          weight: double.parse(weightController.text),
          heigth: double.parse(heigthController.text),
          name: nameController.text,
          phone: phoneController.text,
          goal: goal,
          gender: gender,
          diet: diet,
          badgesList: [],
          workoutList: selectedWorkoutList,
          pastWorkoutList: [],
          progressList: [],
          currentPackage: userPackage);

      final gymId = ref.read(gymProvider)!.id;
      final response = await UserService().updateUserData(gymId, newUser);
      // print(response.body);
      if (response.statusCode == 200) {
        User newuser = User.fromJson(response.body);
        final responseImg =
            await UserService().uploadProfileImg(newuser.id!, image!);
        print(responseImg.statusCode);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          newErrorMessage = "Error while saving";
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    weightController.dispose();
    heigthController.dispose();
    phoneController.dispose();
    emailController.dispose();
    // goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialize) {
      final data =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      isAddUser = data["isAddUser"] as bool;
      if (!isAddUser) {
        User user = data["user"] as User;
        print(user);
        setState(() {
          profileImg = user.profileImg;
          nameController.text = user.name;
          phoneController.text = user.phone;
          emailController.text = user.email ?? "";
          gender = user.gender ?? "male";
          role = user.role;
          weightController.text = user.weight.toString();
          heigthController.text = user.heigth.toString();
          dob = user.dob ?? DateTime.now();
          packageStarted = user.currentPackage!.startDate;
          package = user.currentPackage!.package;
          selectedWorkoutList = user.workoutList ?? [];
          diet = user.diet;
          goal = user.goal;
        });
      }
      initialize = false;
    }

    final gymState = ref.watch(gymProvider);
    gymDietList = gymState?.diets ?? [];
    gymPackageList = gymState?.packages ?? [];
    gymWorkoutList = gymState?.workouts ?? [];

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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Center(
              child: Column(
                children: [
                  Container(
                    // margin: const EdgeInsets.only(top: 0),
                    width: width * 0.85,
                    child: (isAddUser ? "Add Member" : "Edit Member")
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
                    // width: width * 0.85,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              // decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(20)),
                              // color: Pallete.commonBlueColor,
                              // padding: EdgeInsets.all(value),
                              margin: EdgeInsets.all(8),
                              height: width * 0.3,
                              width: width * 0.3,
                              child: image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : profileImg != null
                                      ? Image.network(
                                          profileImg!,
                                          fit: BoxFit.contain,
                                        )
                                      : const Icon(
                                          Icons.person,
                                        ),
                            ),
                            Column(
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () =>
                                        getImage(ImageSource.camera),
                                    icon: Icon(Icons.camera_alt_rounded),
                                    label: "".text.make()),
                                ElevatedButton.icon(
                                    onPressed: () =>
                                        getImage(ImageSource.gallery),
                                    icon: Icon(Icons.photo_library),
                                    label: "".text.make()),
                              ],
                            )
                          ],
                        )
                            .box
                            .border(color: Pallete.whiteDarkColor)
                            .color(Pallete.surfaceColor2)
                            .rounded
                            .padding(EdgeInsets.only(left: 8))
                            .make(),
                        if (!isAddUser) ...[
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.01),
                            // width: width * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    "Last visit"
                                        .text
                                        .size(16)
                                        .color(Pallete.primaryColor)
                                        .make(),
                                    SizedBox(
                                      // width: width * 0.1,
                                      height: height * 0.005,
                                    ),
                                    "${lastVisit.day.toString()} / ${lastVisit.month.toString()} / ${lastVisit.year.toString()}"
                                        .text
                                        .make(),
                                  ],
                                ),
                                Column(
                                  children: [
                                    "Joined on"
                                        .text
                                        .color(Pallete.primaryColor)
                                        .size(16)
                                        .make(),
                                    SizedBox(
                                      // width: width * 0.1,
                                      height: height * 0.005,
                                    ),
                                    "${joinedOn.day.toString()} / ${joinedOn.month.toString()} / ${joinedOn.year.toString()}"
                                        .text
                                        .make(),
                                  ],
                                ),

                                // SizedBox(
                                //   width: width * 0.006,
                                // ),
                                // "Joined on".text.size(16).make(),
                                // SizedBox(
                                //   width: width * 0.06,
                                // ),
                                // "${joinedOn.day.toString()} / ${joinedOn.month.toString()} / ${joinedOn.year.toString()}"
                                //     .text
                                //     .make(),
                              ],
                            ),
                          )
                              .box
                              .color(Pallete.surfaceColor2)
                              .rounded
                              .padding(EdgeInsets.only(left: 12))
                              .make(),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          SizedBox(
                            // width: width * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                "Present Today".text.size(16).make(),
                                Container(
                                  margin: EdgeInsets.only(right: width * 0.1),
                                  child: Switch(
                                      activeColor: Pallete.primaryColor,
                                      value: isPresentToday,
                                      onChanged: ((value) {
                                        setState(() {
                                          isPresentToday = !isPresentToday;
                                        });
                                      })),
                                )
                              ],
                            ),
                          )
                              .box
                              .color(Pallete.surfaceColor2)
                              .rounded
                              .padding(EdgeInsets.only(left: 12))
                              .make(),
                        ],
                        SizedBox(
                          height: height * 0.01,
                        ),
                        InputTextField(
                          label: "Name",
                          controller: nameController,
                          type: TextInputType.name,
                          boardRadius: 20,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        InputTextField(
                          label: "Phone Number",
                          controller: phoneController,
                          type: TextInputType.phone,
                          boardRadius: 20,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        if (emailController.text.isNotEmpty) ...[
                          InputTextField(
                            label: "Email",
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            boardRadius: 20,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          )
                        ],
                        SizedBox(
                          // width: width * 0.85,
                          child: Row(
                            children: [
                              "Gender".text.size(16).make(),
                              SizedBox(
                                width: width * 0.06,
                              ),
                              Radio(
                                // title: Text("Male"),
                                value: "male",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              "Male".text.make(),
                              SizedBox(
                                width: width * 0.06,
                              ),
                              Radio(
                                // title: Text("Female"),
                                value: "female",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                },
                              ),
                              "Female".text.make(),
                            ],
                          ),
                        )
                            .box
                            .color(Pallete.surfaceColor2)
                            .rounded
                            .padding(EdgeInsets.only(left: 12))
                            .make(),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Role".text.size(16).make().box.make(),
                            DropdownButton<Role>(
                              itemHeight: kMinInteractiveDimension,
                              style: const TextStyle(
                                  fontSize: 16, color: Pallete.primaryColor),
                              value: role,
                              borderRadius: BorderRadius.circular(24),
                              items: gymRoleList.map((var value) {
                                return DropdownMenuItem<Role>(
                                  value: (value),
                                  child: Text(value.name.toString().capitalized)
                                      .box
                                      .make(),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  // showSaveReminderBtn = true;
                                  role = value!;
                                });
                              },
                            )
                                .box
                                .width(width * 0.35)
                                .padding(EdgeInsets.only(left: 4, right: 12))
                                .makeCentered()
                          ],
                        )
                            .box
                            .color(Pallete.surfaceColor2)
                            .rounded
                            .padding(EdgeInsets.only(left: 12))
                            .make(),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // margin: EdgeInsets.only(top: 10),
                              // padding: EdgeInsets.symmetric(horizontal: 12),
                              width: width * 0.4,
                              child: InputTextField(
                                boardRadius: 20,
                                height: 0,
                                label: "Weight",
                                hint: "eg: (in Kg)",
                                type: TextInputType.number,
                                controller: weightController,
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.only(
                              //   top: 10,
                              // ),
                              // padding: EdgeInsets.symmetric(horizontal: 12),
                              width: width * 0.4,
                              child: InputTextField(
                                boardRadius: 20,
                                label: "Height",
                                hint: "eg: (in cm)",
                                type: TextInputType.number,
                                controller: heigthController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              "Date of Birth:".text.size(16).make(),
                              "${dob.day.toString()} / ${dob.month.toString()} / ${dob.year.toString()}"
                                  .text
                                  .color(Pallete.primaryColor)
                                  .makeCentered()
                                  .box
                                  .margin(EdgeInsets.all(6))
                                  .width(width * 0.35)
                                  .height(height * 0.06)
                                  .border(color: Pallete.whiteDarkColor)
                                  .color(Pallete.surfaceColor)
                                  .rounded
                                  .make()
                                  .onInkTap(
                                () async {
                                  DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: dob,
                                      firstDate: DateTime(1940),
                                      lastDate: DateTime.now());
                                  if (date != null) {
                                    setState(() {
                                      dob = date;
                                    });
                                  }
                                  print(
                                      "${dob.day.toString()}/${dob.month.toString()}/${dob.year.toString()}");
                                },
                              ),
                            ])
                            .box
                            .color(Pallete.surfaceColor2)
                            .rounded
                            .padding(EdgeInsets.only(left: 8))
                            .make(),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                              "Package Started:".text.size(16).make(),
                              "${packageStarted.day.toString()} / ${packageStarted.month.toString()} / ${packageStarted.year.toString()}"
                                  .text
                                  .color(Pallete.primaryColor)
                                  .makeCentered()
                                  .box
                                  .margin(EdgeInsets.all(6))
                                  .width(width * 0.35)
                                  .border(color: Pallete.whiteDarkColor)
                                  .height(height * 0.06)
                                  .color(Pallete.surfaceColor)
                                  .rounded
                                  .make()
                                  .onInkTap(
                                () async {
                                  DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: packageStarted,
                                      firstDate: DateTime.now()
                                          .subtract(Duration(days: 14)),
                                      lastDate: DateTime.now()
                                          .add(Duration(days: 14)));
                                  if (date != null) {
                                    setState(() {
                                      packageStarted = date;
                                    });
                                  }
                                  print(
                                      "${dob.day.toString()}/${dob.month.toString()}/${dob.year.toString()}");
                                },
                              ),
                            ])
                            .box
                            .color(Pallete.surfaceColor2)
                            .rounded
                            .padding(EdgeInsets.only(left: 8))
                            .make(),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Package"
                                .text
                                .size(16)
                                .make()
                                .box
                                .margin(EdgeInsets.only(
                                  top: 8,
                                ))
                                .make(),
                            DropdownButton<Package>(
                              itemHeight: kMinInteractiveDimension,
                              style: const TextStyle(
                                  fontSize: 16, color: Pallete.primaryColor),
                              value: package ?? gymPackageList[0],
                              borderRadius: BorderRadius.circular(24),
                              items: gymPackageList.map((var value) {
                                return DropdownMenuItem<Package>(
                                  value: (value),
                                  child: Text(value.name.toString().capitalized)
                                      .box
                                      .make(),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  // showSaveReminderBtn = true;
                                  package = value!;
                                });
                              },
                            )
                                .box
                                // .width(width * 0.35)
                                .padding(
                                    const EdgeInsets.only(left: 4, right: 12))
                                .makeCentered()
                          ],
                        )
                            .box
                            .color(Pallete.surfaceColor2)
                            .rounded
                            .padding(const EdgeInsets.only(left: 12))
                            .make(),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          // color: Pallete.blueColor,
                          // height: height * 0.06,
                          width: width * 0.85,
                          child: MultiSelectDialogField(
                            initialValue: selectedWorkoutList,
                            decoration: BoxDecoration(
                                color: Pallete.surfaceColor,
                                borderRadius: BorderRadius.circular(16)),
                            itemsTextStyle:
                                const TextStyle(color: Pallete.surfaceColor),
                            selectedItemsTextStyle:
                                const TextStyle(color: Pallete.surfaceColor),
                            selectedColor: Pallete.primaryColor,
                            unselectedColor: Pallete.whiteColor,
                            listType: MultiSelectListType.CHIP,
                            // searchable: true,
                            buttonText: const Text(
                              "Workouts",
                              style: TextStyle(fontSize: 16),
                            ),
                            title: const Text("Workouts"),
                            items: gymWorkoutList
                                .map((e) => MultiSelectItem(e, e.name))
                                .toList(),
                            onConfirm: (values) {
                              print(values);
                              selectedWorkoutList = values;
                            },
                            // chipDisplay: MultiSelectChipDisplay(
                            //   onTap: (value) {
                            //     setState(() {
                            //       selectedWorkoutList.remove(value);
                            //     });
                            //   },
                            // ),
                          ),
                        )
                            .box
                            .color(Pallete.surfaceColor2)
                            .rounded
                            .padding(const EdgeInsets.only(left: 12, right: 12))
                            .make(),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Diet"
                                .text
                                .size(16)
                                .make()
                                .box
                                .margin(EdgeInsets.only(
                                  top: 8,
                                ))
                                .make(),
                            DropdownButton<Diet>(
                              itemHeight: kMinInteractiveDimension,
                              style: const TextStyle(
                                  fontSize: 16, color: Pallete.primaryColor),
                              value: diet ?? gymDietList[0],
                              borderRadius: BorderRadius.circular(24),
                              items: gymDietList.map((var value) {
                                return DropdownMenuItem<Diet>(
                                  value: (value),
                                  child: Text(value.name.toString().capitalized)
                                      .text
                                      .make()
                                      .box
                                      .make(),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  // showSaveReminderBtn = true;
                                  diet = value!;
                                });
                              },
                            )
                                .box
                                // .width(width * 0.35)
                                .padding(
                                    const EdgeInsets.only(left: 4, right: 12))
                                .makeCentered()
                          ],
                        )
                            .box
                            .color(Pallete.surfaceColor2)
                            .rounded
                            .padding(const EdgeInsets.only(left: 12))
                            .make(),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Goal"
                                .text
                                .size(16)
                                .make()
                                .box
                                .margin(EdgeInsets.only(
                                  top: 8,
                                ))
                                .make(),
                            DropdownButton<String>(
                              itemHeight: kMinInteractiveDimension,
                              style: const TextStyle(
                                  fontSize: 16, color: Pallete.primaryColor),
                              value: goal ?? gymGoalList[0],
                              borderRadius: BorderRadius.circular(24),
                              items: gymGoalList.map((var value) {
                                return DropdownMenuItem<String>(
                                  value: (value),
                                  child: Text(value.capitalized)
                                      .text
                                      .make()
                                      .box
                                      .make(),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  // showSaveReminderBtn = true;
                                  goal = value!;
                                });
                              },
                            )
                                .box
                                // .width(width * 0.35)
                                .padding(
                                    const EdgeInsets.only(left: 4, right: 12))
                                .makeCentered()
                          ],
                        )
                            .box
                            .color(Pallete.surfaceColor2)
                            .rounded
                            .padding(const EdgeInsets.only(left: 12))
                            .make(),
                        if (error != "")
                          "${error}".text.color(Pallete.primaryColor).make(),
                        ("Save"
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
                          _onTapSave();
                        }))
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
