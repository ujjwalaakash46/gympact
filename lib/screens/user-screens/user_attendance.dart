import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/attendance.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/provider/user_state.dart';
import 'package:gympact/service/user_service.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class UserAttendance extends ConsumerStatefulWidget {
  static const userAttendanceRoute = "/user-attendance";

  const UserAttendance({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserAttendanceState();
}

class _UserAttendanceState extends ConsumerState<UserAttendance> {
  String scannedCode = "";
  String gymId = "1212";
  bool qrFound = false;
  bool attendanceMarked = true;
  bool packageEnded = false;

  @override
  void initState() {
    final gym = ref.read(gymProvider)!;
    gymId = gym.id.toString();
    checkUserAttendance();
    super.initState();
  }

  void _onDetect(BarcodeCapture capture) async {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (gymId == barcode.rawValue) {
        final userId = ref.read(userProvider)!.id;
        final response = await UserService().markAttendance(userId!);
        if (response.statusCode == 200) {
          attendanceMarked = true;
        } else if (response.statusCode == 406) {
          attendanceMarked = false;
          packageEnded = true;
        }
        setState(() {
          attendanceMarked = attendanceMarked;
          packageEnded = packageEnded;
          qrFound = true;
        });
      }
    }
  }

  checkUserAttendance() async {
    final userId = ref.read(userProvider)!.id;
    final response = await UserService().checkTodaysAttendance(userId!);
    if (response.statusCode == 200) {
      attendanceMarked = true;
    } else if (response.statusCode == 406) {
      attendanceMarked = false;
      packageEnded = true;
    }
    setState(() {
      attendanceMarked = attendanceMarked;
      packageEnded = packageEnded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
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
                child: Column(children: [
                  if (!(attendanceMarked || packageEnded)) ...[
                    "Scan GYM QR".text.size(24).makeCentered(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Pallete.blackColor,
                          borderRadius: BorderRadius.circular(25)),
                      height: width * 0.75,
                      width: width * 0.75,
                      child: MobileScanner(
                        controller: MobileScannerController(
                          detectionSpeed: DetectionSpeed.noDuplicates,
                          facing: CameraFacing.back,
                          torchEnabled: false,
                        ),
                        onDetect: _onDetect,
                        // scanWindow: Rect.fromCenter(
                        //     center: Offset(5, 5),
                        //     width: width * 0.5,
                        //     height: width * 0.5),
                      ),
                    )
                        .box
                        .border(
                            style: BorderStyle.solid,
                            color: Pallete.primaryFade,
                            width: 5)
                        .make(),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    if (!qrFound) const CircularProgressIndicator(),
                    "Scanning"
                        .text
                        .make()
                        .box
                        .margin(const EdgeInsets.all(8))
                        .make(),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    "or".text.make(),
                    "Contact Admin to Mark Attendance".text.make(),
                  ],
                  if (packageEnded) ...[
                    const Icon(
                      Icons.report_gmailerrorred_rounded,
                      color: Pallete.errorColor,
                      size: 144,
                    )
                        .box
                        .margin(EdgeInsets.only(
                            top: height * 0.1, bottom: height * 0.03))
                        .height(width * 0.6)
                        .width(width * 0.6)
                        .make(),
                    // "Attendance Marked"
                    "Package Expired"
                        .text
                        .align(TextAlign.center)
                        .size(32)
                        .makeCentered()
                        .box
                        .margin(EdgeInsets.only(bottom: height * 0.06))
                        .width(width * 0.6)
                        .make(),
                    // "Marked".text.size(24).makeCentered(),
                    // "Now, Go and push past your limits, Champion!"
                    "Package expired on ${user.currentPackage!.endDate.day}/${user.currentPackage!.endDate.month}/${user.currentPackage!.endDate.year}\n Contact Admin for more information"
                        .text
                        .size(16)
                        .align(TextAlign.center)
                        .make()
                        .box
                        .width(width * 0.75)
                        .make()
                  ],
                  if (attendanceMarked) ...[
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Pallete.successColor,
                      size: 144,
                    )
                        .box
                        .margin(EdgeInsets.only(
                            top: height * 0.1, bottom: height * 0.03))
                        .height(width * 0.6)
                        .width(width * 0.6)
                        .make(),
                    "Attendance Marked"
                        .text
                        .align(TextAlign.center)
                        .size(32)
                        .makeCentered()
                        .box
                        .margin(EdgeInsets.only(bottom: height * 0.06))
                        .width(width * 0.6)
                        .make(),
                    // "Marked".text.size(24).makeCentered(),
                    // "Package expired on ${user.currentPackage!.endDate.day}/${user.currentPackage!.endDate.month}/${user.currentPackage!.endDate.year}\n Contact Admin for more information"
                    "Now, Go and push past your limits, Champion!"
                        .text
                        .size(16)
                        .align(TextAlign.center)
                        .make()
                        .box
                        .width(width * 0.75)
                        .make()
                  ]
                ]),
              ),
            ),
          ),
        ));
  }
}
