import 'package:flutter/material.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/diet.dart';
import 'package:velocity_x/velocity_x.dart';

class DietPlan extends StatefulWidget {
  static const dietPlanRoute = "/diet-plan";
  const DietPlan({super.key});

  @override
  State<DietPlan> createState() => _DietPlanState();
}

class _DietPlanState extends State<DietPlan> {
  Diet diet = Diet(
      id: 1,
      name: "Normal",
      note:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      protine: 100,
      waterIntake: "4",
      calToBurn: "1500");

  int userWeight = 65;

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.only(top: 0),
                  width: width * 0.85,
                  child: "Diet Plan"
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Pallete.surfaceColor2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Protine".text.size(16).lineHeight(1.4).make(),
                      Container(
                        height: height * 0.055,
                        width: width * 0.3,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // color: Pallete.surfaceColor4,
                          border: Border.all(color: Pallete.whiteColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ("${diet.protine} gm")
                            .text
                            .size(14)
                            .color(Pallete.primaryColor)
                            .makeCentered(),
                      )
                    ],
                  ),
                ),
                if (diet.calIntake != null)
                  Container(
                    width: width * 0.85,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Calorie Intake".text.size(16).lineHeight(1.4).make(),
                        Container(
                          height: height * 0.055,
                          width: width * 0.3,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // color: Pallete.surfaceColor4,
                            border: Border.all(color: Pallete.whiteColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ("${diet.calIntake ?? "-"} cal")
                              .text
                              .size(14)
                              .color(Pallete.primaryColor)
                              .makeCentered(),
                        )
                      ],
                    ),
                  ),
                if (diet.waterIntake != null)
                  Container(
                    width: width * 0.85,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Water Intake".text.size(16).lineHeight(1.4).make(),
                        Container(
                          height: height * 0.055,
                          width: width * 0.3,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // color: Pallete.surfaceColor4,
                            border: Border.all(color: Pallete.whiteColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ("${diet.waterIntake ?? "-"} L")
                              .text
                              .size(14)
                              .color(Pallete.primaryColor)
                              .makeCentered(),
                        )
                      ],
                    ),
                  ),
                if (diet.calToBurn != null)
                  Container(
                    width: width * 0.85,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor2,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Calorie Burn".text.size(16).lineHeight(1.4).make(),
                        Container(
                          height: height * 0.055,
                          width: width * 0.3,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // color: Pallete.surfaceColor4,
                            border: Border.all(color: Pallete.whiteColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ("${diet.calToBurn ?? "-"} cal")
                              .text
                              .size(14)
                              .color(Pallete.primaryColor)
                              .makeCentered(),
                        )
                      ],
                    ),
                  ),
                Container(
                  width: width * 0.85,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Pallete.surfaceColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Note".text.size(20).make(),
                      diet.note.text
                          .make()
                          .box
                          .margin(const EdgeInsets.only(top: 8, bottom: 8))
                          // .padding(EdgeInsets.only(top: 8))
                          .make()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
