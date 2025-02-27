import 'package:flutter/material.dart';

import '../App_Color.dart';
import '../App_Screen_Size.dart';

class custom_Textfromfiled extends StatelessWidget {
  TextEditingController controller;
  String hint;
  final Icon? prefixIcon;
  custom_Textfromfiled({
    super.key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final height = AppScreenSize.height(context);
    return TextFormField(
      controller: controller,
      cursorColor: AppColor.textColor,
      style: TextStyle(color:AppColor.textColor),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColor.textFiledBgColor,
        contentPadding: EdgeInsets.symmetric(vertical: height *0.021),
        hintStyle: TextStyle(color: AppColor.hintColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColor.borderColor,
            width: 0.25
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColor.secondaryColour,
              width: 0.5,
            )
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
