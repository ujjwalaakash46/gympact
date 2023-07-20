import 'package:flutter/material.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/diet.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/group.dart';
import 'package:gympact/models/gym.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/models/workout.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:search_choices/search_choices.dart';

class AdminNotification extends StatefulWidget {
  const AdminNotification({super.key});

  @override
  State<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends State<AdminNotification> {
  Gym gym = Gym(
    id: 1,
    name: "The Power Gym",
    admins: [],
    trainers: [],
    workouts: [],
    diets: [],
    packages: [],
    groups: [
      Group(
          id: 12,
          gymId: 122,
          name: "Beginner",
          totalMembers: 142,
          members: [],
          messages: []),
      Group(
          id: 12,
          gymId: 122,
          name: "Moring Batch",
          totalMembers: 103,
          members: [],
          messages: []),
      Group(
          id: 12,
          gymId: 122,
          name: "Evening Batch",
          totalMembers: 122,
          members: [],
          messages: []),
      Group(
          id: 12,
          gymId: 122,
          name: "PT Batch",
          totalMembers: 25,
          members: [],
          messages: [])
    ],
  );

  int showMessageIndex = -1;
  int showAddMemberIndex = -1;
  bool showCreateNewGroup = false;

  TextEditingController messageController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();

  List<User> members = [
    User(
        gender: "male",
        id: 12,
        coin: 1004,
        level: 5,
        gymId: 007,
        name: "Aman Gupta",
        phone: "123",
        email: "amangupta@gh",
        password: "password",
        badgesList: [],
        workoutList: [
          Workout(
              id: 21,
              gymId: "23",
              name: "Push",
              discription: "desisis",
              note: "note sdf",
              createdDate: DateTime(2023),
              updatedDate: DateTime(2023),
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
        diet: Diet(
            id: 1,
            name: "High",
            note:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            protine: 100,
            waterIntake: "4",
            calToBurn: "1500"),
        progress: null,
        weight: 65,
        heigth: 165,
        goal: "Gain Weight",
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
        role: Role.member),
    User(
        gender: "male",
        id: 12,
        coin: 1004,
        level: 5,
        gymId: 007,
        name: "Aman Gupta",
        phone: "123",
        email: "amangupta@gh",
        password: "password",
        badgesList: [],
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
        progressList: [],
        role: Role.member),
    User(
        gender: "male",
        id: 12,
        coin: 1004,
        level: 5,
        gymId: 007,
        name: "Aman Gupta",
        phone: "123",
        email: "amangupta@gh",
        password: "password",
        badgesList: [],
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
        progressList: [],
        role: Role.member),
  ];
  User? addUser;
  searchMember(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    print(2);
    return Container(
      // height: height * 0.046,
      decoration: BoxDecoration(
        color: Pallete.surfaceColor2,
        borderRadius: BorderRadius.circular(25.7),
      ),
      child: SearchChoices<User>.single(
        // futureSearchFilterOptions: ,
        underline: Container(),
        hint: Container(
          // height: height * 0.045,
          decoration: BoxDecoration(
              color: Pallete.surfaceColor4,
              borderRadius: BorderRadius.circular(25.7),
              border:
                  Border.all(color: Pallete.primaryFade) ////////////////////
              ),
          width: width * 0.61,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Search Member by Name',
              style: TextStyle(
                  color: Pallete.whiteDarkColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        isExpanded: true,
        style: const TextStyle(
            fontSize: 16,
            // backgroundColor: Colors.white,
            color: Pallete.primaryColor),
        searchInputDecoration: InputDecoration(
          label: const Text('To'),
          labelStyle: const TextStyle(
              color: Pallete.surfaceColor2,
              fontSize: 16,
              fontWeight: FontWeight.w700),
          filled: true,
          contentPadding: const EdgeInsets.only(
            left: 14.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
            borderRadius: BorderRadius.circular(25.7),
          ),
          floatingLabelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          fillColor: Pallete.surfaceColor,
          enabledBorder: UnderlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 200, 97, 97)),
            borderRadius: BorderRadius.circular(25.7),
          ),
        ),
        searchFn: (String keyword, items) {
          List<int> ret = [];
          if (items != null && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              items.forEach((item) {
                if (!ret.contains(i) &&
                    k.isNotEmpty &&
                    (item.value
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                  ret.add(i);
                }
                i++;
              });
            });
          }
          if (keyword.isEmpty) {
            ret = Iterable<int>.generate(items.length).toList();
          }
          return (ret);
        },
        items: members.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e.name),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            addUser = value;
            showAddMemberIndex = -1;
            addUser = null;
          });
          //Add Member
          print(value);
        },
        value: addUser,
      ),
    );
  }

  createNewGroup(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.025),
      width: width * 0.85,
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Pallete.surfaceColor2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Create New Group".text.size(16).make(),
          SizedBox(
            height: height * 0.03,
          ),
          InputTextField(
              fillColor: Pallete.surfaceColor4,
              label: "Group Name",
              controller: groupNameController,
              type: TextInputType.name),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: width * 0.25,
                height: height * 0.05,
                decoration: BoxDecoration(
                    color: Pallete.primaryDarkFade,
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: Pallete.primaryFade,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                  ),
                ),
              ).onInkTap(() {
                setState(() {
                  groupNameController.text = "";
                  showCreateNewGroup = false;
                });
              }),
              ("Save"
                  .text
                  .color(Pallete.surfaceColor)
                  .makeCentered()
                  .box
                  .rounded
                  .color(Pallete.primaryColor)
                  .width(width * 0.25)
                  .margin(EdgeInsets.only(top: height * 0.005))
                  .height(height * 0.05)
                  .border(color: Pallete.primaryColor)
                  .makeCentered()
                  .onInkTap(() {
                setState(() {
                  groupNameController.text = "";
                  showCreateNewGroup = false;
                });

                //Creaete new group
              })),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

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
                margin: const EdgeInsets.only(top: 8),
                width: width * 0.85,
                child: "Notify"
                    .text
                    .size(24)
                    .fontFamily("Montserrat")
                    .fontWeight(FontWeight.w900)
                    .make(),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              ...gym.groups.mapIndexed(
                (e, index) => Container(
                  width: width * 0.85,
                  padding: const EdgeInsets.only(
                      top: 12, bottom: 12, left: 20, right: 12),
                  margin: const EdgeInsets.only(
                    top: 4,
                    bottom: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Pallete.surfaceColor2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: e.name.text
                                .size(18)
                                .make()
                                .box
                                .margin(EdgeInsets.only(bottom: 4))
                                .make(),
                          ),

                          //Imp! don't delete

                          // "See Members"
                          //     .text
                          //     .color(Pallete.primaryColor)
                          //     .size(12)
                          //     .makeCentered()
                          //     .box
                          //     .padding(const EdgeInsets.all(8))
                          //     .rounded
                          //     .border(
                          //       color: Pallete.surfaceColor4,
                          //       width: 0.8,
                          //     )
                          //     .make()
                          //     .onInkTap(() {})
                        ],
                      ),
                      SizedBox(
                        height: height * 0.005,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  "Members  ".text.make(),
                                  "${e.totalMembers}"
                                      .text
                                      .color(Pallete.primaryColor)
                                      .make(),
                                ],
                              )),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (showAddMemberIndex == index) {
                                  showAddMemberIndex = -1;
                                } else {
                                  showAddMemberIndex = index;
                                }
                                showMessageIndex = -1;
                              });
                            },
                            icon: const Icon(
                              Icons.person_add_alt_1_rounded,
                              color: Pallete.whiteColor,
                              size: 28,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (showMessageIndex == index) {
                                  showMessageIndex = -1;
                                } else {
                                  showMessageIndex = index;
                                }
                                showAddMemberIndex = -1;
                                messageController.text = "";
                              });
                            },
                            icon: const Icon(
                              Icons.message_rounded,
                              color: Pallete.primaryColor,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      if (index == showMessageIndex)
                        Container(
                          margin: EdgeInsets.only(top: height * 0.005),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: InputTextField(
                                      fillColor: Pallete.surfaceColor,
                                      label: "Message",
                                      controller: messageController,
                                      type: TextInputType.multiline)),
                              IconButton(
                                onPressed: () {
                                  print(messageController.text);

                                  //send message!!
                                  setState(() {
                                    showMessageIndex = -1;
                                    messageController.text = "";
                                  });
                                },
                                icon: const Icon(
                                  Icons.send_rounded,
                                  color: Pallete.whiteColor,
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (showAddMemberIndex == index) searchMember(context)
                    ],
                  ),
                ),
              ),
              if (!showCreateNewGroup)
                Container(
                  margin: const EdgeInsets.only(top: 16),
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
                      color: Pallete.primaryDarkFade2,
                      border: Border.all(
                        style: BorderStyle.solid,
                        color: Pallete.primaryFade,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: "Create New Group"
                          .text
                          .color(Pallete.primaryFade2)
                          .makeCentered()
                          .box
                          .make()
                          .onInkTap(() {
                    setState(() {
                      showCreateNewGroup = true;
                    });
                  })),
                ),
              if (showCreateNewGroup) createNewGroup(context)
            ],
          ),
        ),
      ),
    );
  }
}
