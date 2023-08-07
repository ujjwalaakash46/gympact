// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gympact/constants/colors.dart';

class InputTextField extends StatelessWidget {
  const InputTextField(
      {Key? key,
      required this.label,
      this.hint = "",
      this.hide = false,
      this.textInputAction,
      this.boardRadius = 25.7,
      this.fillColor = Pallete.surfaceColor2,
      required this.controller,
      required this.type,
      this.height = 50})
      : super(key: key);

  final String label;
  final String hint;
  final bool hide;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType type;
  final double height;
  final double boardRadius;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
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
        textInputAction: null,
        maxLines: type == TextInputType.multiline ? null : 1,
        obscureText: hide ? true : false,
        enableSuggestions: hide ? false : true,
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          label: Text(label),
          hintText: hint,
          filled: true,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.only(
              left: 14.0, bottom: 8.0, top: 8.0, right: 3),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: fillColor),
            borderRadius: BorderRadius.circular(boardRadius),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: fillColor),
            borderRadius: BorderRadius.circular(boardRadius),
          ),
          // labelStyle: TextStyle(color: Colors.amberAccent),
          // fillColor: AppColor().onBackground,
        ),
      )
    ]);
  }
}
