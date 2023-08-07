import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/gym.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/screens/admin-screens/admin_birthday.dart';
import 'package:gympact/screens/admin-screens/admin_diets.dart';
import 'package:gympact/screens/admin-screens/admin_packages.dart';
import 'package:gympact/screens/admin-screens/admin_workouts.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminHome extends ConsumerStatefulWidget {
  const AdminHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminHomeState();
}

class _AdminHomeState extends ConsumerState<AdminHome> {
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

  Gym gymInit = Gym(
    id: 1,
    name: "The Power Gym",
    admins: [],
    trainers: [],
    workouts: [],
    diets: [],
    packages: [],
    groups: [],
  );

  Map<String, int> attendanceMapInit = {
    "todayMorning": 0,
    "todayEvening": 0,
    "yesterdayMorning": 0,
    "yesterdayEvening": 0,
  };
  int todayMorning = 0;
  int todayEvening = 0;

  int packageEnded = 0;
  int packageEndsIn = 0;

  fetchDetails() async {
    Gym gym = ref.read(gymProvider.notifier).get()!;
    final attendState = ref.read(attendanceProvider.notifier);
    attendanceMapInit =
        await attendState.fetchAttendance(gym.id) ?? attendanceMapInit;

    final packageEndState = ref.read(packageEndsProvider.notifier);
    await packageEndState.fetchPackageEnded(gym.id);
  }

  @override
  void initState() {
    // fetchDetails();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    gym = ref.watch(gymProvider) ?? gymInit;
    final attendanceMap = ref.watch(attendanceProvider);
    todayMorning = attendanceMap?["todayMorning"] ?? 0;
    todayEvening = attendanceMap?["todayEvening"] ?? 0;

    final packageEndState = ref.watch(packageEndsProvider);
    packageEnded = (packageEndState.packageEnded ?? []).length;
    packageEndsIn = (packageEndState.packageEndsIn ?? []).length;
    // print(packageEndState.packageEnded);
    // print(packageEnded);

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
                        .make()
                        .onTap(() {
                      // fetchGym();
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Morning".text.make(),
                        todayMorning
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
                        todayEvening
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
                        (todayMorning + todayEvening)
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
