import 'package:flutter/material.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/diet.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/models/workout.dart';
import 'package:gympact/screens/admin-screens/admin_user_add.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminUserDetails extends StatefulWidget {
  const AdminUserDetails({super.key});

  @override
  State<AdminUserDetails> createState() => _AdminUserDetailsState();
}

class _AdminUserDetailsState extends State<AdminUserDetails> {
  TextEditingController searchController = TextEditingController();

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

  searchUser() {
    print(searchController.text);
    if (searchController.text.isEmpty) {
      //fetch all
    } else {
      // fetch by name.
    }
  }

  @override
  void initState() {
    // searchController.addListener(() {
    //   searchUser();
    // });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    // searchController.removeListener(() { })
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
                child: "Members"
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
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Pallete.surfaceColor2,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person_add_alt_1_rounded,
                              color: Pallete.whiteColor,
                              size: 28,
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            "Add Member".text.size(18).make(),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Pallete.whiteColor,
                          size: 32,
                        )
                      ],
                    ),
                  ],
                ),
              ).onInkTap(() {
                Navigator.of(context).pushNamed(AdminUserAdd.adminUserAddRoute,
                    arguments: {"isAddUser": true, "user": null});
              }),
              // SizedBox(
              //   height: height * 0.005,
              // ),
              Container(
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Pallete.surfaceColor2,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // const Icon(
                            //   Icons.person_search_rounded,
                            //   color: Pallete.whiteColor,
                            //   size: 30,
                            // ),
                            // SizedBox(
                            //   width: width * 0.04,
                            // ),
                            SizedBox(
                              width: width * 0.65,
                              child: InputTextField(
                                label: "Search Member",
                                hint: "Name or Phone number",
                                boardRadius: 14,
                                fillColor: Pallete.surfaceColor2,
                                hide: false,
                                controller: searchController,
                                type: TextInputType.text,
                              ),
                            ),
                            IconButton.filled(
                              onPressed: () {
                                searchUser();
                              },
                              icon: const Icon(
                                Icons.search_rounded,
                                color: Pallete.whiteColor,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        // const Icon(
                        //   Icons.arrow_circle_right_outlined,
                        //   color: Pallete.whiteColor,
                        //   size: 32,
                        // )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              ...members.map(
                (e) => Container(
                  width: width * 0.85,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    // color: Pallete.surfaceColor,
                    border: Border.all(color: Pallete.whiteColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: width * 0.03),
                                decoration: BoxDecoration(
                                  // color: Pallete.surfaceColor,
                                  border: Border.all(color: Pallete.whiteColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                width: width * 0.15,
                                //change to network
                                child: Image.asset(
                                  'assets/images/gym logo.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  e.name.text.size(16).make(),
                                  "last Visited: ${DateFormat('d/MM/yyyy').format(e.lastVisit)}"
                                      .text
                                      .color(Pallete.whiteDarkColor)
                                      .make()
                                ],
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.arrow_circle_right_outlined,
                            color: Pallete.whiteColor,
                            size: 32,
                          ).box.make().onTap(() {
                            Navigator.of(context).pushNamed(
                                AdminUserAdd.adminUserAddRoute,
                                arguments: {"isAddUser": false, "user": e});
                          })
                        ],
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              "Package".text.make(),
                              e.currentPackage.package.name.text
                                  .color(Pallete.primaryColor)
                                  .make()
                            ],
                          ),
                          Column(
                            children: [
                              "Join on".text.make(),
                              "${DateFormat('d/MM/yyyy').format(e.joinOn)}"
                                  .text
                                  .color(Pallete.primaryColor)
                                  .make(),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          "Call"
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
                              .height(height * 0.05)
                              .width(width * 0.35)
                              .makeCentered(),
                          Container(
                            // margin: const EdgeInsets.only(top: 18, bottom: 6),
                            // padding: const EdgeInsets.all(12),
                            height: height * 0.05,
                            width: width * 0.35,
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
                                child: "Make Present"
                                    .text
                                    .color(Pallete.primaryFade2)
                                    .makeCentered()
                                    .box
                                    .make()
                                    .onInkTap(() {})),
                          ),
                          // "Make Present".text.make()
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
