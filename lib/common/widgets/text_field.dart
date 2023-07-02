// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gympact/constants/colors.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.hide,
    required this.controller,
    required this.type,
  }) : super(key: key);

  final String label;
  final String hint;
  final bool hide;
  final TextEditingController controller;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 50,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          // boxShadow: [
          //   BoxShadow(
          //       color: Color.fromARGB(48, 158, 158, 158),
          //       blurRadius: 5,
          //       spreadRadius: 2),
          // ],
        ),
      ),
      TextField(
        obscureText: hide ? true : false,
        enableSuggestions: hide ? false : true,
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          hintText: hint,
          filled: true,
          fillColor: Pallete.surfaceColor,
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Pallete.surfaceColor2),
            borderRadius: BorderRadius.circular(25.7),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Pallete.surfaceColor2),
            borderRadius: BorderRadius.circular(25.7),
          ),
          // labelStyle: TextStyle(color: Colors.amberAccent),
          // fillColor: AppColor().onBackground,
        ),
      )
    ]);
  }
}
