import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/provider/user_state.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/user.dart';
import '../../provider/gym_state.dart';
import '../../service/user_service.dart';

class UserSetting extends ConsumerStatefulWidget {
  static const userSettingRoute = "/user-setting";
  const UserSetting({super.key});

  @override
  ConsumerState<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends ConsumerState<UserSetting> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String error = "";

  saveData() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        weightController.text.isEmpty ||
        heightController.text.isEmpty) {
      setState(() {
        error = "Please fill all";
      });
      return;
    }
    final gymId = ref.read(gymProvider)!.id;
    User user = ref.read(userProvider)!;

    user = user.copyWith(
        email: emailController.text,
        password: passwordController.text,
        weight: double.parse(weightController.text),
        heigth: double.parse(heightController.text));

    final response = await UserService().updateUserData(gymId, user);
    if (response.statusCode == 200) {
      ref.read(progressDetailsProvider.notifier).fetchProgress(user.id!);
      if (context.mounted) Navigator.of(context).pop();
    } else {
      setState(() {
        error = "Error while saving";
      });
    }
  }

  @override
  void initState() {
    final user = ref.read(userProvider);
    emailController.text = user!.email ?? "";
    passwordController.text = user.password ?? "";
    weightController.text = user.weight.toString();
    heightController.text = user.heigth.toString();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // emailController.text = "sdf";
    // passwordController.text = "ssdfdf";
    // weightController.text = "222";
    // heightController.text = "33";

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
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
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
                        height: height * 0.02,
                      ),
                      if (error != "")
                        "${error}".text.color(Pallete.primaryColor).make(),
                      if (error != "")
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
                      ).onTap(() {
                        saveData();
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
