import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/diet.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/models/workout.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/screens/admin-screens/admin_user_add.dart';
import 'package:gympact/service/user_service.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminUserDetails extends ConsumerStatefulWidget {
  const AdminUserDetails({super.key});

  @override
  ConsumerState<AdminUserDetails> createState() => _AdminUserDetailsState();
}

class _AdminUserDetailsState extends ConsumerState<AdminUserDetails> {
  TextEditingController searchController = TextEditingController();

  List<User> userList = [];
  bool isEmptyList = false;
  searchUser() async {
    if (searchController.text.isEmpty) {
      setState(() {
        userList = [];
      });
    } else {
      int gymId = ref.read(gymProvider)!.id;
      final response =
          await UserService().searchUser(gymId, searchController.text);

      if (response.statusCode == 200) {
        setState(() {
          userList = List<User>.from(
              (json.decode(response.body) as List<dynamic>)
                  .map((e) => User.fromMap(e as Map<String, dynamic>)));
          if (userList.isEmpty) {
            isEmptyList = true;
          } else {
            isEmptyList = false;
          }
        });
        // _onExit();
      } else {
        setState(() {
          isEmptyList = true;
        });
      }
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    // searchController.removeListener(() { })
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: width * 0.85,
                  child: "Members"
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
                          Row(
                            children: [
                              const Icon(
                                Icons.person_add_alt_1_rounded,
                                color: Pallete.whiteColor,
                                size: 28,
                              ),
                              SizedBox(
                                width: width * 0.04,
                              ),
                              "Add Member".text.size(18).make(),
                            ],
                          ),
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
                  Navigator.of(context).pushNamed(
                      AdminUserAdd.adminUserAddRoute,
                      arguments: {"isAddUser": true, "user": null});
                }),
                // SizedBox(
                //   height: height * 0.005,
                // ),
                Container(
                  width: width * 0.85,
                  padding: const EdgeInsets.all(6),
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
                          Row(
                            children: [
                              // const Icon(
                              //   Icons.person_search_rounded,
                              //   color: Pallete.whiteColor,
                              //   size: 30,
                              // ),
                              // SizedBox(
                              //   width: width * 0.04,
                              // ),
                              SizedBox(
                                width: width * 0.67,
                                child: InputTextField(
                                  label: "Search Member",
                                  hint: "Name or Phone number",
                                  boardRadius: 14,
                                  fillColor: Pallete.surfaceColor2,
                                  hide: false,
                                  controller: searchController,
                                  type: TextInputType.text,
                                ),
                              ),
                              InkWell(
                                radius: 8,
                                splashColor: Pallete.blueColor,
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  searchUser();
                                },
                                child: Container(
                                  height: height * 0.055,
                                  width: height * 0.055,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Pallete.primaryFade2,
                                  ),
                                  child: const Icon(
                                    Icons.search_rounded,
                                    color: Pallete.surfaceColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                              // IconButton.outlined(
                              //   color: Pallete.surfaceColor4,
                              //   onPressed: () {
                              //     FocusScope.of(context)
                              //         .requestFocus(FocusNode());
                              //     searchUser();
                              //   },
                              //   icon: const Icon(
                              //     Icons.search_rounded,
                              //     color: Pallete.whiteColor,
                              //     size: 30,
                              //   ),
                              // )
                            ],
                          ),
                          // const Icon(
                          //   Icons.arrow_circle_right_outlined,
                          //   color: Pallete.whiteColor,
                          //   size: 32,
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                // Center(
                //   child: ListView.builder(itemBuilder: (ctx, index) {
                //     return
                //   }),
                // )
                (isEmptyList ? "No Member found" : "").text.make(),
                ...userList.map((e) => Container(
                      width: width * 0.85,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        // color: Pallete.surfaceColor,
                        border: Border.all(color: Pallete.whiteColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: width * 0.03),
                                    decoration: BoxDecoration(
                                      // color: Pallete.surfaceColor,
                                      border:
                                          Border.all(color: Pallete.whiteColor),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    width: width * 0.15,
                                    //change to network
                                    child: e.profileImg != null
                                        ? Image.network(
                                            e.profileImg!,
                                            fit: BoxFit.contain,
                                          )
                                        : Image.asset(
                                            fit: BoxFit.contain,
                                            'assets/images/gym logo.png'),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      e.name.text.size(16).make(),
                                      "last Visited: ${DateFormat('d/MM/yyyy').format(e.lastVisit ?? DateTime.now())}"
                                          .text
                                          .color(Pallete.whiteDarkColor)
                                          .make()
                                    ],
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Pallete.whiteColor,
                                size: 32,
                              ).box.make().onTap(() {
                                Navigator.of(context).pushNamed(
                                    AdminUserAdd.adminUserAddRoute,
                                    arguments: {"isAddUser": false, "user": e});
                              })
                            ],
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  "Package".text.make(),
                                  e.currentPackage!.package.name.text
                                      .color(Pallete.primaryColor)
                                      .make()
                                ],
                              ),
                              Column(
                                children: [
                                  "Join on".text.make(),
                                  "${DateFormat('d/MM/yyyy').format(e.joinOn ?? DateTime.now())}"
                                      .text
                                      .color(Pallete.primaryColor)
                                      .make(),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              "Call"
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
                                  .height(height * 0.05)
                                  .width(width * 0.35)
                                  .makeCentered(),
                              Container(
                                // margin: const EdgeInsets.only(top: 18, bottom: 6),
                                // padding: const EdgeInsets.all(12),
                                height: height * 0.05,
                                width: width * 0.35,
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
                                    color: Pallete.primaryDarkFade,
                                    // border: Border.all(
                                    //   style: BorderStyle.solid,
                                    //   color: Pallete.primaryFade,
                                    //   width: 1.5,
                                    // ),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                    child: "Make Present"
                                        .text
                                        .color(Pallete.primaryFade2)
                                        .makeCentered()
                                        .box
                                        .make()
                                        .onInkTap(() {})),
                              ),
                              // "Make Present".text.make()
                            ],
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
