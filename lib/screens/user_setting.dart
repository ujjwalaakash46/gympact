import 'package:flutter/material.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class UserSetting extends StatefulWidget {
  static const userSettingRoute = "/user-setting";
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  // late TextEditingController dobController;

  @override
  Widget build(BuildContext context) {
    emailController.text = "sdf";
    passwordController.text = "ssdfdf";
    weightController.text = "222";
    heightController.text = "33";

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
          title: "Edit Profile"
              .text
              .size(24)
              .color(Pallete.whiteColor)
              .fontFamily("Montserrat")
              .fontWeight(FontWeight.w900)
              .make(),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Center(
              child: Container(
                width: width * 0.85,
                child: Column(
                  children: [
                    InputTextField(
                      label: "Email",
                      hint: "email",
                      hide: false,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InputTextField(
                      label: "Password",
                      hint: "Password",
                      hide: false,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InputTextField(
                      label: "Weight",
                      hint: "Weight",
                      hide: false,
                      controller: weightController,
                      type: TextInputType.number,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InputTextField(
                      label: "Height",
                      hint: "Height",
                      hide: false,
                      controller: heightController,
                      type: TextInputType.number,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      height: height * 0.05,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          color: Pallete.primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Pallete.primaryColor, width: 1.5)),
                      child: "Save"
                          .text
                          .color(Pallete.surfaceColor)
                          .size(14)
                          .makeCentered(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
