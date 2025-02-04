import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/Visiblity_Provider.dart';
import '../App_Color.dart';
import '../App_Icon.dart';
import '../App_Screen_Size.dart';

class custom_PasswordTextFromFiled extends StatefulWidget {
  TextEditingController controller;
  String hint;
  final Icon? prefixIcon;
  custom_PasswordTextFromFiled({
    super.key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
  });

  @override
  State<custom_PasswordTextFromFiled> createState() => _custom_PasswordTextFromFiledState();
}

class _custom_PasswordTextFromFiledState extends State<custom_PasswordTextFromFiled> {

  bool _isvisibel = true;

  @override
  Widget build(BuildContext context) {
    final height = AppScreenSize.height(context);
    return Consumer<visiblityProvider>(builder: (context, value, child) {
      return TextFormField(
        obscureText: _isvisibel,
        controller: widget.controller,
        cursorColor: AppColor.textColor,
        style: TextStyle(color:AppColor.textColor),
        decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: EdgeInsets.symmetric(vertical: height *0.023),
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
                  color: AppColor.border,
                  width: 0.5,
                )
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: _isvisibel ? InkWell(child: AppIcon.visibilityOffIcon,onTap: (){
              value.setvisibel(false);
            },) : InkWell(child: AppIcon.visibilityOnIcon,onTap: (){
              value.setvisibel(true);
            },)
        ),
      );
    },);
  }
}
