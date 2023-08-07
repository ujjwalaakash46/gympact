import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/screens/admin-screens/admin_package_list.dart';
import 'package:gympact/service/gym_service.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../provider/gym_state.dart';
import '../../service/user_service.dart';

class AdminPackages extends ConsumerStatefulWidget {
  static const adminPackagesRoute = "/admin-packages";
  const AdminPackages({super.key});

  @override
  ConsumerState<AdminPackages> createState() => _AdminPackagesState();
}

class _AdminPackagesState extends ConsumerState<AdminPackages> {
  List<User> membershipEnded = [
    User(
        gender: "male",
        id: 12,
        coin: 1004,
        level: 5,
        gymId: "007",
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
        gymId: "007",
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
        gymId: "007",
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

  List<User> membershipEndedIn = [];
  int packageEnded = 12;
  int packageEndsIn = 23;

  var showAllEndList = false;
  var showAllEndInList = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final packageEndState = ref.watch(packageEndsProvider);

    membershipEnded = (packageEndState.packageEnded ?? []);
    membershipEndedIn = (packageEndState.packageEndsIn ?? []);

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
                    child: "Packages"
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    // margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Package List".text.size(18).make(),
                            const Icon(
                              Icons.arrow_circle_right_outlined,
                              color: Pallete.whiteColor,
                              size: 32,
                            )
                          ],
                        ),
                      ],
                    ),
                  ).onTap(() {
                    Navigator.of(context)
                        .pushNamed(AdminPackageList.adminPackageListRoute);
                  }),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.85,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    // margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Package Ends".text.size(18).make(),
                            membershipEnded.length
                                .toString()
                                .text
                                .color(Pallete.primaryColor)
                                .make()
                                .box
                                .margin(EdgeInsets.only(right: width * 0.02))
                                .make()
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        ...membershipEnded
                            .getRange(
                                0,
                                showAllEndList || membershipEnded.length < 5
                                    ? membershipEnded.length
                                    : 5)
                            .map(
                              (e) => Container(
                                // width: width * 0.9,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: width * 0.03),
                                              decoration: BoxDecoration(
                                                // color: Pallete.surfaceColor,
                                                border: Border.all(
                                                    color: Pallete.whiteColor),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              width: width * 0.15,
                                              //change to network
                                              child: Image.asset(
                                                'assets/images/gym logo.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                e.name.text.size(16).make(),
                                                "Last Visited: ${DateFormat('d/MM/yyyy').format(e.lastVisit ?? DateTime.now())}"
                                                    .text
                                                    .color(
                                                        Pallete.whiteDarkColor)
                                                    .make()
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.arrow_circle_right_outlined,
                                          color: Pallete.whiteColor,
                                          size: 32,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            "Last Package".text.make(),
                                            e.currentPackage!.package.name.text
                                                .color(Pallete.primaryColor)
                                                .make()
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            "Joined on".text.make(),
                                            "${DateFormat('d/MM/yyyy').format(e.joinOn ?? DateTime.now())}"
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        "Call"
                                            .text
                                            .color(Pallete.backgroundColor)
                                            .size(16)
                                            .semiBold
                                            .makeCentered()
                                            .box
                                            .customRounded(
                                                BorderRadius.circular(
                                                    height * 0.02))
                                            .rounded
                                            .color(Pallete.primaryColor)
                                            .height(height * 0.05)
                                            .width(width * 0.3)
                                            .makeCentered(),
                                        Container(
                                          // margin: const EdgeInsets.only(top: 18, bottom: 6),
                                          // padding: const EdgeInsets.all(12),
                                          height: height * 0.05,
                                          width: width * 0.3,
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      66, 14, 14, 14),
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
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                              child: "Message"
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
                        if (membershipEnded.length > 5)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ((!showAllEndList) ? "View All" : "Hide All")
                                  .text
                                  .color(Pallete.primaryColor)
                                  .make()
                                  .box
                                  .padding(const EdgeInsets.all(8))
                                  .make()
                                  .onTap(() {
                                setState(() {
                                  showAllEndList = !showAllEndList;
                                });
                              }),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    width: width * 0.85,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    // margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Package Ends within 3days".text.size(16).make(),
                            membershipEndedIn.length
                                .toString()
                                .text
                                .color(Pallete.primaryColor)
                                .make()
                                .box
                                .margin(EdgeInsets.only(right: width * 0.02))
                                .make()
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        ...membershipEndedIn
                            .getRange(
                                0,
                                showAllEndInList || membershipEndedIn.length < 5
                                    ? membershipEndedIn.length
                                    : 5)
                            .map(
                              (e) => Container(
                                // width: width * 0.9,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: width * 0.03),
                                              decoration: BoxDecoration(
                                                // color: Pallete.surfaceColor,
                                                border: Border.all(
                                                    color: Pallete.whiteColor),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              width: width * 0.15,
                                              //change to network
                                              child: Image.asset(
                                                'assets/images/gym logo.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                e.name.text.size(16).make(),
                                                "last Visited: ${DateFormat('d/MM/yyyy').format(e.lastVisit ?? DateTime.now())}"
                                                    .text
                                                    .color(
                                                        Pallete.whiteDarkColor)
                                                    .make()
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Icon(
                                          Icons.arrow_circle_right_outlined,
                                          color: Pallete.whiteColor,
                                          size: 32,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.015,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            "Current Package".text.make(),
                                            e.currentPackage!.package.name.text
                                                .color(Pallete.primaryColor)
                                                .make()
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            "Ends on".text.make(),
                                            DateFormat('d/MM/yyyy')
                                                .format(
                                                    e.currentPackage!.endDate)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        "Call"
                                            .text
                                            .color(Pallete.backgroundColor)
                                            .size(16)
                                            .semiBold
                                            .makeCentered()
                                            .box
                                            .customRounded(
                                                BorderRadius.circular(
                                                    height * 0.02))
                                            .rounded
                                            .color(Pallete.primaryColor)
                                            .height(height * 0.05)
                                            .width(width * 0.3)
                                            .makeCentered(),
                                        Container(
                                          // margin: const EdgeInsets.only(top: 18, bottom: 6),
                                          // padding: const EdgeInsets.all(12),
                                          height: height * 0.05,
                                          width: width * 0.3,
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      66, 14, 14, 14),
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
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                              child: "Message"
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
                        if (membershipEndedIn.length > 5)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ((!showAllEndInList) ? "View All" : "Hide All")
                                  .text
                                  .color(Pallete.primaryColor)
                                  .make()
                                  .box
                                  .padding(const EdgeInsets.all(8))
                                  .make()
                                  .onTap(() {
                                setState(() {
                                  showAllEndInList = !showAllEndInList;
                                });
                              }),
                            ],
                          ),
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
