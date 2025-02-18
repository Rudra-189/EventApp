import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../App_Color.dart';
import '../App_Screen_Size.dart';

class custom_otpTextfromfiled extends StatelessWidget {
  TextEditingController controller;
  custom_otpTextfromfiled({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);
    return SizedBox(
      width: width * 0.15,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
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
        ),
      ),
    );
  }
}
