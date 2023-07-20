import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:gympact/screens/admin-screens/admin_bottom_bar_nav.dart';
import 'package:gympact/screens/user-screens/user_bottom_bar_nav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //pick from pref
  //if not found -- login
  //found then role based

  List<Widget> carouselSliderItems = [
    Image.asset(
      'assets/images/prelogin1.jpg',
      height: 200,
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/prelogin3.jpg',
      height: 200,
      fit: BoxFit.cover,
    ),
    Image.asset(
      'assets/images/prelogin5.jpg',
      height: 200,
      fit: BoxFit.cover,
    ),
  ];

  String? usersName = "Aman";
  int screenIndex = 0;
  int carouselIndex = 0;
  bool isPreLogin = true;
  String error = "";
  bool isFirstLogin = false;
  Role userRole = Role.admin;
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  checkPhoneNumber() {
    String newError = "";
    if (phoneController.text.isEmpty) {
      newError = "Please Enter Phone Number";
    } else {
      //check number.
      isPreLogin = true;
    }
    setState(() {
      error = newError;
      if (newError.isEmpty) {
        screenIndex++;
      }
    });
  }

  checkSignUp() {
    String newError = "";
    if (isFirstLogin) {
      if (emailController.text.isEmpty) {
        newError = "Please enter email";
      } else if (passwordController.text.isEmpty) {
        newError = "Please enter password";
      } else if (confirmPasswordController.text.isEmpty) {
        newError = "Please enter confirm password";
      } else if (confirmPasswordController.text != passwordController.text) {
        newError = "Passwords are not matching";
      }
    } else {
      if (passwordController.text.isEmpty) {
        newError = "Please enter password";
      }
    }

    setState(() {
      error = newError;
    });
    if (newError.isEmpty) {
      //go to screen;

      String route = UserBottomBarNav.userMainScreenRoute;
      if (userRole == Role.admin) {
        route = AdminBottomBarNav.adminMainScreenRoute;
      } else if (userRole == Role.member) {
        route = UserBottomBarNav.userMainScreenRoute;
      }
      Navigator.of(context).pushNamed(route);
    }
  }

  // getScreen(BuildContext context, index) {
  //   final height = MediaQuery.of(context).size.height;
  //   final width = MediaQuery.of(context).size.width;

  //   return screenList[index];
  // }

  @override
  Widget build(BuildContext context) {
    isFirstLogin = true;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<Widget> screenList = [
      Column(
        children: [
          Container(
              width: width * 0.9,
              height: height * 0.6,
              child: carouselSliderItems[carouselIndex]
              // CarouselSlider(
              //   options: CarouselOptions(
              //     viewportFraction: 1,
              //     height: height * 0.7,
              //     autoPlay: true,
              //     aspectRatio: 0.5,
              //     enlargeCenterPage: true,
              //     enableInfiniteScroll: false,
              //     clipBehavior: Clip.antiAlias,
              //     onPageChanged: (index, reason) {
              //       setState(() {
              //         carouselIndex = index;
              //       });
              //     },
              //   ),
              //   items: carouselSliderItems,
              // ),
              ),
          SizedBox(
            height: height * 0.03,
          ),
          DotsIndicator(
            dotsCount: carouselSliderItems.length,
            reversed: false,
            position: carouselIndex,
            decorator: DotsDecorator(
              color: Pallete.surfaceColor4,
              activeColor: Pallete.primaryColor,
              size: const Size.square(9.0),
              activeSize: const Size(27.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          ("Next"
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
              .onTap(() {
            setState(() {
              if (carouselIndex == carouselSliderItems.length - 1) {
                setState(() {
                  carouselIndex = carouselSliderItems.length - 1;
                  screenIndex++;
                  // carouselIndex = 0;
                });
              } else {
                setState(() {
                  carouselIndex++;
                });
              }
              isPreLogin = false;
            });
            // _onTapSave(context);
          }))
        ],
      ),
      Column(
        children: [
          Center(
            child: Container(
                height: height * 0.5,
                width: width * 0.85,
                margin: EdgeInsets.only(top: height * 0.1),
                padding: EdgeInsets.only(
                    top: height * 0.035,
                    left: width * 0.05,
                    right: width * 0.05),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(110, 18, 18, 18),
                          blurRadius: 5,
                          spreadRadius: 2),
                    ],
                    color: Pallete.surfaceColor2,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    "Verify Phone Number".text.size(20).make(),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    "(Enter Your Phone Number \nthat you gave to gym)"
                        .text
                        .align(TextAlign.center)
                        .size(12)
                        .color(Pallete.whiteDarkColor)
                        .make(),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    InputTextField(
                        fillColor: Pallete.surfaceColor3,
                        label: "Phone Number",
                        controller: phoneController,
                        type: TextInputType.phone),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    if (error == "")
                      SizedBox(
                        height: height * 0.02,
                      ),
                    if (error != "")
                      "${error}".text.color(Pallete.primaryColor).make(),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    ("Next"
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
                        .onTap(() {
                      setState(() {
                        checkPhoneNumber();
                      });
                      // _onTapSave(context);
                    })),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                )),
          )
        ],
      ),
      Column(
        children: [
          Center(
            child: Container(
                height: height * 0.6,
                width: width * 0.85,
                margin: EdgeInsets.only(top: height * 0.1),
                padding: EdgeInsets.only(
                    top: height * 0.035,
                    left: width * 0.05,
                    right: width * 0.05),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(110, 18, 18, 18),
                          blurRadius: 5,
                          spreadRadius: 2),
                    ],
                    color: Pallete.surfaceColor2,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    (isFirstLogin ? "Sign up" : "Login").text.size(22).make(),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    "Hi ${usersName} 👋".text.size(16).make(),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    InputTextField(
                        fillColor: Pallete.surfaceColor3,
                        label: "Email",
                        controller: emailController,
                        type: TextInputType.emailAddress),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InputTextField(
                        fillColor: Pallete.surfaceColor3,
                        label: "Password",
                        hide: true,
                        controller: passwordController,
                        type: TextInputType.visiblePassword),
                    if (isFirstLogin)
                      SizedBox(
                        height: height * 0.01,
                      ),
                    if (isFirstLogin)
                      InputTextField(
                          hide: true,
                          fillColor: Pallete.surfaceColor3,
                          label: "Confirm Password",
                          controller: confirmPasswordController,
                          type: TextInputType.visiblePassword),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    if (error == "")
                      SizedBox(
                        height: height * 0.02,
                      ),
                    if (error != "")
                      "${error}".text.color(Pallete.primaryColor).make(),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    ((isFirstLogin ? "Sign up" : "Login")
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
                        .onTap(() {
                      setState(() {
                        checkSignUp();
                      });
                      // _onTapSave(context);
                    })),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                )),
          )
        ],
      )
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: screenList[screenIndex],
          ),
        ),
      ),
    );
  }
}
