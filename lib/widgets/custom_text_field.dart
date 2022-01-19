import 'package:flutter/material.dart';
import 'package:smartfoodappwithadminpanel/appColors/colors.dart';

class CostomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labText;
  final TextInputType keyboardType;
  CostomTextField(
      {required this.keyboardType,
      required this.labText,
      required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: textColor,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
          labelText: labText,
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor))),
    );
  }
}
