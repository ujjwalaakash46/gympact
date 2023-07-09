import 'package:flutter/material.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class AddTodaysDetails extends StatefulWidget {
  static const addTodaysDetailsRoute = "/add-todays-details";
  const AddTodaysDetails({super.key});

  @override
  State<AddTodaysDetails> createState() => _AddTodaysDetailsState();
}

class _AddTodaysDetailsState extends State<AddTodaysDetails> {
  TextEditingController weightController = TextEditingController();
  TextEditingController waterInTakeController = TextEditingController();
  TextEditingController calorieIntakeController = TextEditingController();
  TextEditingController calorieBurnController = TextEditingController();

  bool isCompleted = false;
  bool isStarted = false;

  saveAlert(BuildContext context) {
    Widget exitButton = TextButton(
      child: Container(
        width: 100,
        height: 65,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(91, 0, 0, 0),
                offset: Offset(
                  0,
                  4.0,
                ),
                blurRadius: 9.0,
                spreadRadius: 2.0,
              ),
            ],
            color: Pallete.primaryDarkFade,
            border: Border.all(
              style: BorderStyle.solid,
              color: Pallete.primaryFade,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: const Center(
          child: Text(
            "Yup",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onPressed: () {
        //save the progress
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: Container(
          width: 100,
          height: 65,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(91, 0, 0, 0),
                  offset: Offset(
                    0,
                    4.0,
                  ),
                  blurRadius: 9.0,
                  spreadRadius: 2.0,
                ),
              ],
              color: Pallete.primaryColor,
              border: Border.all(
                style: BorderStyle.solid,
                color: Pallete.primaryFade,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: Text(
              "Nope",
              textAlign: TextAlign.center,
              style: TextStyle(color: Pallete.backgroundColor),
            ),
          )),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure?"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              !isStarted
                  ? "You didn't fill anything. Do you wanna exit?"
                  : !isCompleted
                      ? "You didn't complete. Do you wanna save and exit?"
                      : "You Wanna Save the details?",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [exitButton, continueButton],
          )
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void saveOrBack(BuildContext context) {
    if (weightController.text.isEmpty &&
        waterInTakeController.text.isEmpty &&
        calorieBurnController.text.isEmpty &&
        calorieIntakeController.text.isEmpty) {
      isStarted = false;
      isCompleted = false;
    } else if (weightController.text.isEmpty ||
        waterInTakeController.text.isEmpty ||
        calorieBurnController.text.isEmpty ||
        calorieIntakeController.text.isEmpty) {
      isCompleted = false;
      isStarted = true;
    } else {
      isCompleted = true;
      isStarted = true;
    }

    saveAlert(context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        saveOrBack(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        appBar: AppBar(
          backgroundColor: Pallete.backgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: (() {
              saveOrBack(context);
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
                    child: "Today's"
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
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "Note".text.size(20).make(),
                        Expanded(
                          flex: 4,
                          child: "Weigth"
                              .text
                              .make()
                              .box
                              .margin(const EdgeInsets.only(top: 8, bottom: 8))
                              // .padding(EdgeInsets.only(top: 8))
                              .make(),
                        ),
                        SizedBox(
                          width: width * 0.25,
                          height: height * 0.04,
                          child: InputTextField(
                            label: "",
                            boardRadius: 14,
                            fillColor: Pallete.surfaceColor3,
                            hide: false,
                            controller: weightController,
                            type: TextInputType.number,
                          ),
                        ),
                        "kg"
                            .text
                            .make()
                            .box
                            .width(width * 0.06)
                            .margin(EdgeInsets.only(left: 4))
                            .make()
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.85,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "Note".text.size(20).make(),
                        Expanded(
                          flex: 4,
                          child: "Water consumed"
                              .text
                              .make()
                              .box
                              .margin(const EdgeInsets.only(top: 8, bottom: 8))
                              // .padding(EdgeInsets.only(top: 8))
                              .make(),
                        ),
                        SizedBox(
                          width: width * 0.25,
                          height: height * 0.04,
                          child: InputTextField(
                            label: "",
                            boardRadius: 14,
                            fillColor: Pallete.surfaceColor3,
                            hide: false,
                            controller: waterInTakeController,
                            type: TextInputType.number,
                          ),
                        ),
                        "L"
                            .text
                            .make()
                            .box
                            .width(width * 0.06)
                            .margin(EdgeInsets.only(left: 4))
                            .make()
                      ],
                    ),
                  ),
                  //calorieBurnController
                  Container(
                    width: width * 0.85,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "Note".text.size(20).make(),
                        Expanded(
                          flex: 4,
                          child: "Calorie Burned"
                              .text
                              .make()
                              .box
                              .margin(const EdgeInsets.only(top: 8, bottom: 8))
                              // .padding(EdgeInsets.only(top: 8))
                              .make(),
                        ),
                        SizedBox(
                          width: width * 0.25,
                          height: height * 0.04,
                          child: InputTextField(
                            label: "",
                            boardRadius: 14,
                            fillColor: Pallete.surfaceColor3,
                            hide: false,
                            controller: calorieBurnController,
                            type: TextInputType.number,
                          ),
                        ),
                        "cal"
                            .text
                            .make()
                            .box
                            .width(width * 0.06)
                            .margin(EdgeInsets.only(left: 4))
                            .make()
                      ],
                    ),
                  ),
                  //cal consumed
                  Container(
                    width: width * 0.85,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Pallete.surfaceColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "Note".text.size(20).make(),
                        Expanded(
                          flex: 4,
                          child: "calorie consumed"
                              .text
                              .make()
                              .box
                              .margin(const EdgeInsets.only(top: 8, bottom: 8))
                              // .padding(EdgeInsets.only(top: 8))
                              .make(),
                        ),
                        SizedBox(
                          width: width * 0.25,
                          height: height * 0.04,
                          child: InputTextField(
                            label: "",
                            boardRadius: 14,
                            fillColor: Pallete.surfaceColor3,
                            hide: false,
                            controller: calorieIntakeController,
                            type: TextInputType.number,
                          ),
                        ),
                        "cal"
                            .text
                            .make()
                            .box
                            .width(width * 0.06)
                            .margin(EdgeInsets.only(left: 4))
                            .make()
                      ],
                    ),
                  ),
                  Container(
                          child: ("Save")
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
                              .margin(EdgeInsets.only(top: height * 0.030))
                              .height(height * 0.065)
                              .width(width * 0.4)
                              .makeCentered())
                      .onTap(() {
                    saveOrBack(context);
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
