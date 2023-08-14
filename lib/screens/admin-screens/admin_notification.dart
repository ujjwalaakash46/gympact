import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/common/widgets/text_field.dart';
import 'package:gympact/constants/colors.dart';
import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/diet.dart';
import 'package:gympact/models/exercise.dart';
import 'package:gympact/models/group.dart';
import 'package:gympact/models/gym.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/models/workout.dart';
import 'package:gympact/provider/gym_state.dart';
import 'package:gympact/service/gym_service.dart';
import 'package:gympact/service/user_service.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:search_choices/search_choices.dart';

class AdminNotification extends ConsumerStatefulWidget {
  const AdminNotification({super.key});

  @override
  ConsumerState<AdminNotification> createState() => _AdminNotificationState();
}

class _AdminNotificationState extends ConsumerState<AdminNotification> {
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

  int showMessageIndex = -1;
  int showAddMemberIndex = -1;
  int selectedGroupId = -1;
  bool showCreateNewGroup = false;

  bool messageSent = false;

  TextEditingController messageController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();
  List<Group> groups = [];
  List<User> members = [];
  User? addUser;
  searchMember(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Container(
      // height: height * 0.046,
      decoration: BoxDecoration(
        color: Pallete.surfaceColor2,
        borderRadius: BorderRadius.circular(25.7),
      ),
      child: SearchChoices<User>.single(
        // futureSearchFilterOptions: ,
        underline: Container(),
        hint: Container(
          // height: height * 0.045,
          decoration: BoxDecoration(
              color: Pallete.surfaceColor4,
              borderRadius: BorderRadius.circular(25.7),
              border:
                  Border.all(color: Pallete.primaryFade) ////////////////////
              ),
          width: width * 0.61,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Search Member by Name',
              style: TextStyle(
                  color: Pallete.whiteDarkColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        isExpanded: true,
        style: const TextStyle(
            fontSize: 16,
            // backgroundColor: Colors.white,
            color: Pallete.primaryColor),
        searchInputDecoration: InputDecoration(
          label: const Text('To'),
          labelStyle: const TextStyle(
              color: Pallete.surfaceColor2,
              fontSize: 16,
              fontWeight: FontWeight.w700),
          filled: true,
          contentPadding: const EdgeInsets.only(
            left: 14.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 214, 214, 214)),
            borderRadius: BorderRadius.circular(25.7),
          ),
          floatingLabelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          fillColor: Pallete.surfaceColor,
          enabledBorder: UnderlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 200, 97, 97)),
            borderRadius: BorderRadius.circular(25.7),
          ),
        ),
        searchFn: (String keyword, items) {
          List<int> ret = [];
          if (items != null && keyword.isNotEmpty) {
            keyword.split(" ").forEach((k) {
              int i = 0;
              items.forEach((item) {
                if (!ret.contains(i) &&
                    k.isNotEmpty &&
                    (item.value
                        .toString()
                        .toLowerCase()
                        .contains(k.toLowerCase()))) {
                  ret.add(i);
                }
                i++;
              });
            });
          }
          if (keyword.isEmpty) {
            ret = Iterable<int>.generate(items.length).toList();
          }
          return (ret);
        },
        items: members.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e.name),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            addUser = value;
            showAddMemberIndex = -1;
            addUser = null;
          });
          //Add Member
          addMember(value);
        },
        value: addUser,
      ),
    );
  }

  addMember(User u) async {
    if (selectedGroupId != -1) {
      final response = await GymService().addMember(selectedGroupId, u.id!);
      if (response.statusCode == 200) {
        fetchGroups();
      }
    }
  }

  sendMessage(String message) async {
    if (message.isNotEmpty) {
      Message m = Message(createdOn: DateTime.now(), data: message);
      final response = await GymService().notifyGroup(selectedGroupId, m);
      if (response.statusCode == 200) {
        setState(() {
          messageSent = true;
        });
        print(messageSent);
        Future.delayed(Duration(seconds: 5)).then((value) {
          setState(() {
            messageSent = false;
          });
        });
      }
    }
  }

  createNewGroup(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.025),
      width: width * 0.85,
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Pallete.surfaceColor2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Create New Group".text.size(16).make(),
          SizedBox(
            height: height * 0.03,
          ),
          InputTextField(
              fillColor: Pallete.surfaceColor4,
              label: "Group Name",
              controller: groupNameController,
              type: TextInputType.name),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: width * 0.25,
                height: height * 0.05,
                decoration: BoxDecoration(
                    color: Pallete.primaryDarkFade,
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: Pallete.primaryFade,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                  ),
                ),
              ).onInkTap(() {
                setState(() {
                  groupNameController.text = "";
                  showCreateNewGroup = false;
                });
              }),
              ("Save"
                  .text
                  .color(Pallete.surfaceColor)
                  .makeCentered()
                  .box
                  .rounded
                  .color(Pallete.primaryColor)
                  .width(width * 0.25)
                  .margin(EdgeInsets.only(top: height * 0.005))
                  .height(height * 0.05)
                  .border(color: Pallete.primaryColor)
                  .makeCentered()
                  .onInkTap(() {
                setState(() {
                  showCreateNewGroup = false;
                  saveNewGroup();
                });

                //Creaete new group
              })),
            ],
          )
        ],
      ),
    );
  }

  fetchGroups() async {
    final gymId = ref.read(gymProvider)?.id;
    final response = await GymService().getGroups(gymId!);
    if (response.statusCode == 200) {
      final list = List<Group>.from(
          (json.decode(response.body) as List<dynamic>)
              .map((e) => Group.fromMap(e as Map<String, dynamic>))
              .toList());
      setState(() {
        print(list);
        groups = list;
      });
    }

    final responseUserList = await UserService().searchUser(gymId, "");
    if (response.statusCode == 200) {
      final list = List<User>.from(
          (json.decode(responseUserList.body) as List<dynamic>)
              .map((e) => User.fromMap(e as Map<String, dynamic>))
              .toList());
      setState(() {
        members = list;
      });
    }
  }

  saveNewGroup() async {
    if (groupNameController.text.isNotEmpty) {
      final gymId = ref.read(gymProvider)?.id;
      final response =
          await GymService().createGroup(gymId!, groupNameController.text);
      if (response.statusCode == 200) {
        fetchGroups();
      }
      groupNameController.text = "";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  @override
  void dispose() {
    messageController.dispose();
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
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: width * 0.85,
                  child: "Notify"
                      .text
                      .size(24)
                      .fontFamily("Montserrat")
                      .fontWeight(FontWeight.w900)
                      .make(),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                ...(groups).mapIndexed(
                  (e, index) => Container(
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: e.name.text
                                  .size(18)
                                  .make()
                                  .box
                                  .margin(EdgeInsets.only(bottom: 4))
                                  .make(),
                            ),

                            //Imp! don't delete

                            // "See Members"
                            //     .text
                            //     .color(Pallete.primaryColor)
                            //     .size(12)
                            //     .makeCentered()
                            //     .box
                            //     .padding(const EdgeInsets.all(8))
                            //     .rounded
                            //     .border(
                            //       color: Pallete.surfaceColor4,
                            //       width: 0.8,
                            //     )
                            //     .make()
                            //     .onInkTap(() {})
                          ],
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    "Members  ".text.make(),
                                    "${e.members.length}"
                                        .text
                                        .color(Pallete.primaryColor)
                                        .make(),
                                  ],
                                )),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  selectedGroupId = e.id!;
                                  if (showAddMemberIndex == index) {
                                    showAddMemberIndex = -1;
                                  } else {
                                    showAddMemberIndex = index;
                                  }
                                  showMessageIndex = -1;
                                });
                              },
                              icon: const Icon(
                                Icons.person_add_alt_1_rounded,
                                color: Pallete.whiteColor,
                                size: 28,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (showMessageIndex == index) {
                                    showMessageIndex = -1;
                                  } else {
                                    showMessageIndex = index;
                                  }
                                  showAddMemberIndex = -1;
                                  messageController.text = "";
                                });
                              },
                              icon: const Icon(
                                Icons.message_rounded,
                                color: Pallete.primaryColor,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                        if (index == showMessageIndex)
                          Container(
                            margin: EdgeInsets.only(top: height * 0.005),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: InputTextField(
                                            fillColor: Pallete.surfaceColor,
                                            label: "Message",
                                            controller: messageController,
                                            type: TextInputType.multiline)),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedGroupId = e.id!;
                                        });
                                        print(e.id);
                                        print(selectedGroupId);
                                        print(messageSent);
                                        print(messageSent == true &&
                                            selectedGroupId == e.id!);
                                        //send message!!
                                        sendMessage(messageController.text);
                                        setState(() {
                                          // showMessageIndex = -1;
                                          messageController.text = "";
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.send_rounded,
                                        color: Pallete.whiteColor,
                                        size: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                if (messageSent == true &&
                                    selectedGroupId == e.id!)
                                  "Message Sent".text.make()
                              ],
                            ),
                          ),
                        if (showAddMemberIndex == index) searchMember(context)
                      ],
                    ),
                  ),
                ),
                if (!showCreateNewGroup)
                  Container(
                    margin: const EdgeInsets.only(top: 16),
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
                        color: Pallete.primaryDarkFade2,
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: Pallete.primaryFade,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: "Create New Group"
                            .text
                            .color(Pallete.primaryFade2)
                            .makeCentered()
                            .box
                            .make()
                            .onInkTap(() {
                      setState(() {
                        showCreateNewGroup = true;
                      });
                    })),
                  ),
                if (showCreateNewGroup) createNewGroup(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
