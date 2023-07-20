import 'package:flutter/material.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/models/diet.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminDiets extends StatefulWidget {
  static const adminDietsRoute = "/admin-diets";
  const AdminDiets({super.key});

  @override
  State<AdminDiets> createState() => _AdminDietsState();
}

class _AdminDietsState extends State<AdminDiets> {
  bool isViewDiet = false;
  // int viewDietIndex = 0;
  int dietDetailsIndex = -1;
  bool addNewDiet = false;

  List<Diet> diets = [
    Diet(
        id: 1,
        name: "level1",
        note:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        protine: 65,
        waterIntake: "4"),
    Diet(
        id: 1,
        name: "level2",
        note:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        protine: 105,
        waterIntake: "3",
        calToBurn: "3000",
        calIntake: '2500'),
    Diet(
        id: 1,
        name: "level3",
        note:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        protine: 125,
        calToBurn: "3500",
        calIntake: '3000'),
    Diet(
        id: 1,
        name: "level4",
        note:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        protine: 125,
        calToBurn: "4000",
        calIntake: "3000"),
  ];

  _onExit() {
    if (addNewDiet == true) {
      setState(() {
        addNewDiet = false;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  TextEditingController dietNameController = TextEditingController();
  TextEditingController protienController = TextEditingController();
  TextEditingController calorieIntakeController = TextEditingController();
  TextEditingController waterIntakeController = TextEditingController();
  TextEditingController calorieToBurnController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  var error = "";

  @override
  void dispose() {
    dietNameController.dispose();
    protienController.dispose();
    calorieIntakeController.dispose();
    waterIntakeController.dispose();
    calorieToBurnController.dispose();
    noteController.dispose();
    super.dispose();
  }

  _addNewDiet(BuildContext contect) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.85,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(),
            width: width * 0.85,
            child: "Add New Diet"
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
              hint: "eg Fat Loss L1",
              type: TextInputType.name,
              controller: dietNameController,
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
                  label: "Protine",
                  hint: "eg: (in gram)",
                  type: TextInputType.number,
                  controller: protienController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                // padding: EdgeInsets.symmetric(horizontal: 12),
                width: width * 0.4,
                child: InputTextField(
                  label: "Calorie",
                  hint: "eg: (in cal)",
                  type: TextInputType.number,
                  controller: calorieIntakeController,
                ),
              ),
            ],
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
                  label: "Water Intake",
                  hint: "eg: (in Liters)",
                  type: TextInputType.number,
                  controller: waterIntakeController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                // padding: EdgeInsets.symmetric(horizontal: 12),
                width: width * 0.4,
                child: InputTextField(
                  label: "Calorie to Burn",
                  hint: "eg: (in cal)",
                  type: TextInputType.number,
                  controller: calorieToBurnController,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            // padding: EdgeInsets.symmetric(horizontal: 12),
            width: width * 0.85,
            child: InputTextField(
              height: 0,
              label: "Note",
              hint: "eg: eat high carb food in morning...",
              type: TextInputType.multiline,
              controller: noteController,
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
          child: Center(
            child: Column(
              children: [
                if (!addNewDiet) ...[
                  Container(
                    margin: const EdgeInsets.only(),
                    width: width * 0.85,
                    child: "Diets"
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
                    margin: const EdgeInsets.only(bottom: 6),
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
                      child: "Add New Diet"
                          .text
                          .color(Pallete.primaryFade2)
                          .makeCentered(),
                    ).onTap(() {
                      setState(() {
                        addNewDiet = true;
                      });
                    }),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ...diets.mapIndexed((diet, i) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Pallete.surfaceColor,
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      // height: height * 0.1,
                      width: width * 0.85,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: (diet.name).text.size(14).make(),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              Container(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 20),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                          width: 2,
                                          color: Pallete.primaryColor),
                                    ),
                                  ),
                                  child: ("${diet.protine} g")
                                      .text
                                      .color(Pallete.whiteDarkColor)
                                      .size(12)
                                      .make()),
                              if (diet.waterIntake != null)
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 20),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            width: 2,
                                            color: Pallete.primaryColor),
                                      ),
                                    ),
                                    child: ("${diet.waterIntake} L")
                                        .text
                                        .color(Pallete.whiteDarkColor)
                                        .size(12)
                                        .make()),
                              if (diet.calIntake != null)
                                Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 20),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            width: 2,
                                            color: Pallete.primaryColor),
                                      ),
                                    ),
                                    child: ("${diet.calIntake} cal")
                                        .text
                                        .color(Pallete.whiteDarkColor)
                                        .size(12)
                                        .make()),
                            ],
                          ),
                          if (dietDetailsIndex == i)
                            Container(
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 12),
                              child: diet.note.text.make(),
                            )
                        ],
                      ),
                    ).onInkTap(() {
                      setState(() {
                        // isViewDiet = !isViewDiet;
                        if (dietDetailsIndex == i) {
                          dietDetailsIndex = -1;
                        } else {
                          dietDetailsIndex = i;
                        }
                      });
                    });
                  }),
                ],
                if (addNewDiet) _addNewDiet(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onTapSave(BuildContext context) {
    var newErrorMessage = "";
    if (dietNameController.text.isEmpty) {
      newErrorMessage = "Set Diet Name";
    } else if (protienController.text.isEmpty) {
      newErrorMessage = "Set Diet Protine";
    } else if (noteController.text.isEmpty) {
      newErrorMessage = "Set Diet Note";
    }
    setState(() {
      error = newErrorMessage;
    });
    if (error.isEmpty) {
      //
      //save package;
      //
      _onExit();
    }
  }
}
