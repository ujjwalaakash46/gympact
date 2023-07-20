import 'package:flutter/material.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/gym.dart';
import 'package:gympact/screens/admin-screens/admin_birthday.dart';
import 'package:gympact/screens/admin-screens/admin_diets.dart';
import 'package:gympact/screens/admin-screens/admin_packages.dart';
import 'package:gympact/screens/admin-screens/admin_workouts.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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

  int morningAttendance = 73;
  int eveningAttendance = 93;

  int packageEnded = 12;
  int packageEndsIn = 23;

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
                height: height * 0.03,
              ),
              Container(
                width: width * 0.85,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                margin: const EdgeInsets.symmetric(vertical: 4),
                // decoration: BoxDecoration(
                //   color: Pallete.surfaceColor2,
                //   borderRadius: BorderRadius.circular(15),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Today's Attendance"
                        .text
                        .size(20)
                        .make()
                        .box
                        .margin(EdgeInsets.only(bottom: 16))
                        .make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Morning".text.make(),
                        morningAttendance
                            .toString()
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                        // .box
                        // .margin(EdgeInsets.only(right: width * 0.03))
                        // .make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Evening".text.make(),
                        eveningAttendance
                            .toString()
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                        // .box
                        // .margin(EdgeInsets.only(right: width * 0.03))
                        // .make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "".text.make(),
                        (morningAttendance + eveningAttendance)
                            .toString()
                            .text
                            // .color(Pallete.primaryColor)
                            .make()
                        // .box
                        // .margin(EdgeInsets.only(right: width * 0.03))
                        // .make()
                      ],
                    ),
                  ],
                ),
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
                        "Packages".text.size(18).make(),
                        const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Pallete.whiteColor,
                          size: 32,
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.017,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Package Ended".text.size(16).make(),
                        packageEnded
                            .toString()
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Package Ends in 3 days".text.size(16).make(),
                        packageEndsIn
                            .toString()
                            .text
                            .color(Pallete.primaryColor)
                            .make()
                      ],
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                  ],
                ),
              ).onInkTap(() {
                Navigator.of(context)
                    .pushNamed(AdminPackages.adminPackagesRoute);
              }),
              SizedBox(
                height: height * 0.005,
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
                        "Workouts".text.size(18).make(),
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
                Navigator.of(context)
                    .pushNamed(AdminWorkouts.adminWorkoutsRoute);
              }),
              SizedBox(
                height: height * 0.005,
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
                        "Diets".text.size(18).make(),
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
                Navigator.of(context).pushNamed(AdminDiets.adminDietsRoute);
              }),
              SizedBox(
                height: height * 0.005,
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
                        "Birthdays".text.size(18).make(),
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
                Navigator.of(context)
                    .pushNamed(AdminBirthday.adminBirthdayRoute);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
