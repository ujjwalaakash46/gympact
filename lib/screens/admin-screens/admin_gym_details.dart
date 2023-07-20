// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/workout.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/gym.dart';
import 'package:gympact/models/package.dart';

class AdminGymDetails extends StatefulWidget {
  const AdminGymDetails({super.key});

  @override
  State<AdminGymDetails> createState() => _AdminGymDetailsState();
}

class PackagePerformance {
  Package package;
  int members;
  int totalPrice;
  PackagePerformance({
    required this.package,
    required this.members,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'package': package.toMap(),
      'members': members,
      'totalPrice': totalPrice,
    };
  }

  factory PackagePerformance.fromMap(Map<String, dynamic> map) {
    return PackagePerformance(
      package: Package.fromMap(map['package'] as Map<String, dynamic>),
      members: map['members'] as int,
      totalPrice: map['totalPrice'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackagePerformance.fromJson(String source) =>
      PackagePerformance.fromMap(json.decode(source) as Map<String, dynamic>);
}

class _AdminGymDetailsState extends State<AdminGymDetails> {
  Gym gym = Gym(
    id: 1,
    name: "The Power Gym",
    admins: [],
    trainers: [],
    workouts: [],
    diets: [],
    packages: [],
    groups: [],
  );

  int activeMembers = 150;
  int newMembers = 30;
  var newMembersP = 8.2;
  int discontiunedMembers = 20;
  var discontiunedMembersP = 6.2;
  int renewMember = 50;
  var renewMemberP = 7.2;
  int inactiveMember = 50;

  int totalmember = 150 + 50;

  int totalRevenue = 0;

  int memberAchievedGoal = 20;

  List<PackagePerformance> packageList = [
    PackagePerformance(
        package: Package(
            id: 1,
            benefits: ["sd"],
            durationInMonths: 3,
            name: "3 Normal Month",
            price: 4000),
        members: 55,
        totalPrice: 4000 * 55),
    PackagePerformance(
        package: Package(
            id: 1,
            benefits: ["sd"],
            durationInMonths: 1,
            name: "Silver 1M",
            price: 1500),
        members: 40,
        totalPrice: 1500 * 40),
    PackagePerformance(
        package: Package(
            id: 1,
            benefits: ["sd"],
            durationInMonths: 1,
            name: "Gold 1M",
            price: 4500),
        members: 56,
        totalPrice: 4500 * 56),
    PackagePerformance(
        package: Package(
            id: 1,
            benefits: ["sd"],
            durationInMonths: 3,
            name: "Gold 3M",
            price: 6500),
        members: 38,
        totalPrice: 6500 * 38),
    PackagePerformance(
        package: Package(
            id: 1,
            benefits: ["sd"],
            durationInMonths: 6,
            name: "Silver 6M",
            price: 8000),
        members: 34,
        totalPrice: 8000 * 34),
  ];
  Workout popularWorkout = Workout(
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
      durationInMin: 24);

  @override
  Widget build(BuildContext context) {
    totalRevenue = 0;
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
                alignment: Alignment.center,
                // margin: const EdgeInsets.only(top: 8),
                width: width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/gym logo.png",
                      width: width * 0.15,
                      fit: BoxFit.contain,
                    ),
                    gym.name!.text.size(24).make(),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Active members".text.size(14).make(),
                        activeMembers
                            .toString()
                            .text
                            .size(14)
                            .color(Pallete.primaryColor)
                            .make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.007,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Inactive members".text.make(),
                        inactiveMember
                            .toString()
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.004,
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.008),
                        height: height * 0.001,
                        width: width * 0.80,
                        color: Pallete.surfaceColor3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total members".text.color(Pallete.primaryColor).make(),
                        totalmember.text.make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: "New joinee".text.make()),
                        newMembers.text.color(Pallete.primaryColor).make(),
                        ("   ($newMembersP%)")
                            .text
                            .color(newMembersP >= 0
                                ? Pallete.successColor
                                : Pallete.errorColor)
                            .make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.007,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: "Renewed".text.make()),
                        renewMember.text.color(Pallete.primaryColor).make(),
                        ("   ($renewMemberP%)")
                            .text
                            .color(renewMemberP >= 0
                                ? Pallete.successColor
                                : Pallete.errorColor)
                            .make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.007,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 2, child: "Discontinued".text.make()),
                        discontiunedMembers.text
                            .color(Pallete.primaryColor)
                            .make(),
                        ("   ($discontiunedMembersP%)")
                            .text
                            .color(discontiunedMembersP >= 0
                                ? Pallete.successColor
                                : Pallete.errorColor)
                            .make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.007,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "(Till now this month)"
                            .text
                            .size(12)
                            .italic
                            .color(Pallete.whiteDarkColor)
                            .make(),
                      ],
                    ),
                    "Compared to Past Month"
                        .text
                        .size(12)
                        .italic
                        .color(Pallete.whiteDarkColor)
                        .make(),
                  ],
                ),
              ),
              // SizedBox(
              //   height: height * 0.02,
              // ),
              Container(
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Member Achieved thier Goal"
                            .text
                            .make()
                            .box
                            .width(width * 0.4)
                            .make(),
                        memberAchievedGoal.text.make()
                      ],
                    ),
                    '(This Month)'
                        .text
                        .size(12)
                        .italic
                        .color(Pallete.whiteDarkColor)
                        .make()
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Container(
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.007,
                    ),
                    "Package Performance"
                        .text
                        .size(16)
                        .semiBold
                        .color(Pallete.primaryColor)
                        .make(),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    "This Month"
                        .text
                        .size(14)
                        .color(Pallete.primaryFade)
                        .make(),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    ...packageList.mapIndexed((e, index) {
                      totalRevenue += e.totalPrice;
                      return Container(
                        margin: EdgeInsets.only(bottom: height * 0.007),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: width * 0.45,
                                  child: e.package.name.text.make()),
                              SizedBox(
                                width: width * 0.075,
                                child: e.members
                                    .toString()
                                    .text
                                    .color(Pallete.primaryColor)
                                    .make(),
                              ),
                              SizedBox(
                                width: width * 0.05,
                                child: "-"
                                    .text
                                    .color(Pallete.primaryColor)
                                    .make()
                                    .box
                                    .makeCentered(),
                              ),
                              SizedBox(
                                width: width * 0.2,
                                child: e.totalPrice
                                    .toString()
                                    .text
                                    .align(TextAlign.end)
                                    .color(Pallete.primaryColor)
                                    .make(),
                              ),
                            ]),
                      );
                    }),
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.01),
                        height: height * 0.001,
                        width: width * 0.80,
                        color: Pallete.surfaceColor3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        "Revenue".text.size(16).make(),
                        totalRevenue.toString().text.make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    "This Year".text.size(14).color(Pallete.primaryFade).make(),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    ...packageList.mapIndexed((e, index) {
                      totalRevenue += e.totalPrice;
                      return Container(
                        margin: EdgeInsets.only(bottom: height * 0.007),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: width * 0.45,
                                  child: e.package.name.text.make()),
                              SizedBox(
                                width: width * 0.075,
                                child: e.members
                                    .toString()
                                    .text
                                    .color(Pallete.primaryColor)
                                    .make(),
                              ),
                              SizedBox(
                                width: width * 0.05,
                                child: "-"
                                    .text
                                    .color(Pallete.primaryColor)
                                    .make()
                                    .box
                                    .makeCentered(),
                              ),
                              SizedBox(
                                width: width * 0.2,
                                child: e.totalPrice
                                    .toString()
                                    .text
                                    .align(TextAlign.end)
                                    .color(Pallete.primaryColor)
                                    .make(),
                              ),
                            ]),
                      );
                    }),
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.01),
                        height: height * 0.001,
                        width: width * 0.80,
                        color: Pallete.surfaceColor3,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        "Revenue".text.size(16).make(),
                        totalRevenue.toString().text.make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Container(
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            "Most Popular Workout"
                                .text
                                .make()
                                .box
                                .width(width * 0.4)
                                .make(),
                            '(This Month)'
                                .text
                                .size(12)
                                .italic
                                .color(Pallete.whiteDarkColor)
                                .make()
                                .box
                                .width(width * 0.4)
                                .make()
                          ],
                        ),
                        Column(
                          children: [
                            popularWorkout.name.text.make(),
                            "(36 member did this)"
                                .text
                                .color(Pallete.whiteDarkColor)
                                .make()
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
