import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/service/gym_service.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminPackageList extends ConsumerStatefulWidget {
  static const adminPackageListRoute = "/admin-package-list";
  const AdminPackageList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminPackageListState();
}

class _AdminPackageListState extends ConsumerState<AdminPackageList> {
  var packageList = [
    Package(
        id: 1,
        price: 600,
        durationInMonths: 3,
        name: "3 Month Power Plan",
        benefits: ["rt", "as", "asd"]),
    Package(
        id: 1,
        price: 3600,
        durationInMonths: 3,
        name: "Power Plan",
        benefits: ["rt", "as", "asd"]),
    Package(
        id: 1,
        price: 2500,
        durationInMonths: 2,
        name: "3 Month",
        benefits: ["rt", "as", "asd"]),
    Package(
        id: 1,
        price: 5600,
        durationInMonths: 1,
        name: "3 Power Plan",
        benefits: ["rt", "as", "asd"])
  ];

  List<TextEditingController> benefitList = [];

  bool isAddNewPackage = false;
  String error = "";

  TextEditingController packageNameController = TextEditingController();
  TextEditingController durationInMonthController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  _onExit() {
    if (isAddNewPackage == true) {
      setState(() {
        isAddNewPackage = false;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  _onTapSave(BuildContext context) async {
    var newErrorMessage = "";
    if (packageNameController.text.isEmpty) {
      newErrorMessage = "Set Package name";
    } else if (durationInMonthController.text.isEmpty) {
      newErrorMessage = "Set Package Duration";
    } else if (priceController.text.isEmpty) {
      newErrorMessage = "Set Package Price";
    }
    setState(() {
      error = newErrorMessage;
    });
    if (error.isEmpty) {
      List<String> finalBenefitList = benefitList
          .filter((e) => e.text.isNotEmpty)
          .map(
            (e) => e.text.toString(),
          )
          .toList();

      //
      //save package;
      //

      final newPackage = Package(
          price: double.parse(priceController.text),
          durationInMonths: int.parse(durationInMonthController.text),
          name: packageNameController.text,
          benefits: finalBenefitList);

      final gymId = ref.read(gymProvider)!.id;
      final response = await GymService().savePackage(gymId, newPackage);
      // final response = await WorkoutService().saveWorkout(user.id, newWorkout);
      if (response.statusCode == 200) {
        ref.read(gymProvider.notifier).fetchGymDetail();
        setState(() {
          packageNameController.text = '';
          durationInMonthController.text = '';
          priceController.text = '';
          finalBenefitList = [];
        });
        _onExit();
      } else {
        var body = json.decode(response.body) as Map<dynamic, dynamic>;
        setState(() {
          error = "Error while save";
        });
      }
    }
  }

  _onAddNewPackage(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // margin: const EdgeInsets.only(top: 0),
            width: width * 0.85,
            child: "Add New Package"
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
            margin: EdgeInsets.only(top: 12),
            // padding: EdgeInsets.symmetric(horizontal: 12),
            width: width * 0.85,
            child: InputTextField(
              label: "Package Name",
              hint: "eg Gold Power Package",
              type: TextInputType.name,
              controller: packageNameController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                // padding: EdgeInsets.symmetric(horizontal: 12),
                width: width * 0.4,
                child: InputTextField(
                  height: 0,
                  label: "Duration",
                  hint: "eg: (in month)",
                  type: TextInputType.number,
                  controller: durationInMonthController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                // padding: EdgeInsets.symmetric(horizontal: 12),
                width: width * 0.4,
                child: InputTextField(
                  label: "Price",
                  hint: "eg 3500",
                  type: TextInputType.number,
                  controller: priceController,
                ),
              ),
            ],
          ),
          Container(
            // width: width * 0.85,
            margin: EdgeInsets.only(top: height * 0.015),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Pallete.surfaceColor,
                //  border: Border.all()
                borderRadius: BorderRadius.circular(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Facilities".text.size(16).color(Pallete.whiteColor).make(),
                SizedBox(
                  height: height * 0.01,
                ),
                Wrap(
                  children: [
                    ...benefitList.mapIndexed((value, index) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.62,
                                child: InputTextField(
                                  label: "$index",
                                  controller: value,
                                  type: TextInputType.text,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      benefitList.remove(value);
                                    });
                                  },
                                  icon: const Icon(
                                    fill: 0.4,
                                    Icons.close_rounded,
                                    size: 18,
                                    color: Pallete.errorColor,
                                  ))
                            ],
                          ),
                        )),
                    Container(
                      decoration: BoxDecoration(
                          color: Pallete.surfaceColor3,
                          //  border: Border.all()
                          borderRadius: BorderRadius.circular(24)),
                      width: width * 0.35,
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_circle_outline_rounded),
                          "Add Facility"
                              .text
                              .make()
                              .box
                              .margin(EdgeInsets.only(left: 4))
                              .make()
                        ],
                      ),
                    ).onInkTap(() {
                      _onAddFacility();
                    })
                  ],
                ),
              ],
            ),
          ),
          if (error != "") "${error}".text.color(Pallete.primaryColor).make(),
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
            _onTapSave(context);
          }))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final gymState = ref.watch(gymProvider);
    packageList = gymState?.packages ?? [];
    // packageList = [];

    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: (() {
            _onExit();
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
                  if (!isAddNewPackage) ...[
                    SizedBox(
                      // margin: const EdgeInsets.only(),
                      width: width * 0.85,
                      child: "Package List"
                          .text
                          .size(24)
                          .fontFamily("Montserrat")
                          .fontWeight(FontWeight.w900)
                          .make(),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    if (packageList.isEmpty)
                      "No Package Added"
                          .text
                          .color(Pallete.whiteDarkColor)
                          .make()
                          .box
                          .margin(EdgeInsets.symmetric(vertical: height * 0.02))
                          .make(),
                    ...packageList.mapIndexed((value, index) {
                      return Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: value.name.text
                                      .size(16)
                                      .color(Pallete.primaryColor)
                                      .make()
                                      .box
                                      .margin(EdgeInsets.only(bottom: 4))
                                      .make(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                "${value.durationInMonths} Month"
                                    .text
                                    .size(16)
                                    .make()
                                    .box
                                    .margin(EdgeInsets.only(bottom: 4))
                                    .make(),
                                "₹ ${value.price}"
                                    .text
                                    .size(16)
                                    .make()
                                    .box
                                    .margin(EdgeInsets.only(bottom: 4))
                                    .make(),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            if (value.benefits.isNotEmpty)
                              "Facilities "
                                  .text
                                  .color(Pallete.whiteDarkColor)
                                  .make(),
                            Wrap(
                              children: [
                                ...value.benefits.map((e) => Container(
                                      margin: const EdgeInsets.all(8),
                                      child: " • $e".text.make(),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
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
                          color: Pallete.surfaceColor,
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Pallete.primaryFade,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: "Add New Package"
                            .text
                            .color(Pallete.primaryFade2)
                            .makeCentered()
                            .box
                            .make()
                            .onInkTap(
                          () {
                            setState(() {
                              isAddNewPackage = !isAddNewPackage;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                  if (isAddNewPackage) _onAddNewPackage(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onAddFacility() {
    setState(() {
      benefitList.add(TextEditingController());
    });
  }
}
