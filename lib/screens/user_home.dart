import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:velocity_x/velocity_x.dart';

class UserHome extends ConsumerStatefulWidget {
  const UserHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserHomeState();
}

class _UserHomeState extends ConsumerState<UserHome> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var workoutList = [
      {"name": "Push Day", "img": "url", "timeRequired": "45 min"},
      {"name": "Leg Day", "img": "url", "timeRequired": "45 min"},
      {"name": "Pull Day", "img": "url", "timeRequired": "45 min"},
      {"name": "Warm up", "img": "url", "timeRequired": "10 min"},
      {"name": "Push Day", "img": "url", "timeRequired": "60 min"},
    ];
    print(3);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text("GymPact")
                  .text
                  .color(Pallete.primaryColor)
                  .size(24)
                  .make(),
              Container(
                margin: EdgeInsets.only(top: height * 0.03),
                width: width * 0.85,
                child: Row(
                  children: [
                    "Hello ".text.color(Pallete.secondaryColor).size(26).make(),
                    // '${user.name},'
                    'Aman'
                        .text
                        .color(Pallete.secondaryColor)
                        .fontWeight(FontWeight.w700)
                        .size(26)
                        .make()
                  ],
                ),
              ),
              "Good Morning"
                  .richText
                  .color(Pallete.secondaryColor)
                  .size(16)
                  .make()
                  .box
                  .alignCenterLeft
                  .padding(
                      EdgeInsets.only(top: height * 0.01, left: width * 0.055))
                  .make(),
              Container(
                margin: EdgeInsets.only(top: height * 0.03),
                width: width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    14
                        .toString()
                        .text
                        .color(Pallete.orange)
                        .color(Pallete.secondaryColor)
                        .fontWeight(FontWeight.w700)
                        .size(16)
                        .make(),
                    ' days Streak! 🔥'
                        .text
                        .color(Pallete.secondaryColor)
                        .fontWeight(FontWeight.w700)
                        .size(16)
                        .make()
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              "You're doing great! Make your Attendace and Complete your today's workout."
                  .text
                  .lineHeight(1.7)
                  .center
                  .make()
                  .box
                  .border(
                      style: BorderStyle.solid,
                      color: Pallete.primaryFade,
                      width: 1.5)
                  .rounded
                  .color(Pallete.surfaceColor)
                  .padding(EdgeInsets.all(12))
                  .height(height * 0.15)
                  .width(width * 0.85)
                  .makeCentered(),
              HStack(
                [
                  "Make Attendance"
                      .text
                      .color(Pallete.backgroundColor)
                      .size(16)
                      .semiBold
                      .make()
                      .box
                      .margin(EdgeInsets.only(left: width * 0.1))
                      .make(),
                  const Icon(
                    Icons.arrow_right_alt_sharp,
                    color: Pallete.backgroundColor,
                    size: 42,
                  )
                ],
                alignment: MainAxisAlignment.spaceAround,
              )
                  .box
                  .customRounded(BorderRadius.circular(height * 0.025))
                  .rounded
                  .color(Pallete.primaryColor)
                  .margin(EdgeInsets.only(top: height * 0.030))
                  .height(height * 0.07)
                  .width(width * 0.75)
                  .makeCentered()
                  .onTap(() {
                // VxToast.show(context, msg: "Hello from vx");
                // print(DateTime.now().day);
              }),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                // padding: EdgeInsets.only(top: height * 0.03),
                width: width * 0.85,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Pallete.primaryFade,
                    width: 1.5,
                  ),
                  color: Pallete.surfaceColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Workout Plan".text.size(18).make(),
                          "Past Workout"
                              .text
                              .color(Pallete.primaryColor)
                              .size(12)
                              .makeCentered()
                              .box
                              .padding(const EdgeInsets.all(8))
                              .rounded
                              .border(
                                color: Pallete.surfaceColor4,
                                width: 0.8,
                              )
                              .make()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    "Last you did Push Day workout on 15th May"
                        .text
                        .size(12)
                        .makeCentered(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    ...workoutList.map((e) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Pallete.backgroundColor,
                            borderRadius: BorderRadius.circular(15)),
                        margin: const EdgeInsets.only(bottom: 3),
                        padding: const EdgeInsets.all(12),
                        height: height * 0.1,
                        width: width * 0.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: (e["name"] ?? "").text.size(14).make(),
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
                                child: (e["timeRequired"] ?? "")
                                    .text
                                    .color(Pallete.whiteDarkColor)
                                    .size(12)
                                    .make()),
                          ],
                        ),
                      );
                    }).toList(),
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
                          color: Pallete.primaryDarkFade,
                          // border: Border.all(
                          //   style: BorderStyle.solid,
                          //   color: Pallete.primaryFade,
                          //   width: 1.5,
                          // ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                          child: "Add New Workout"
                              .text
                              .color(Pallete.primaryFade2)
                              .makeCentered()),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
