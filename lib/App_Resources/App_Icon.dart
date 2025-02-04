import 'package:event_project_01/App_Resources/App_Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppIcon{
  static Icon personIcon = Icon(Icons.person,color: AppColor.iconColor,size: 22,);
  static Icon mailIcon = Icon(Icons.email_outlined,color: AppColor.iconColor,size: 22,);
  static Icon passwordIcon = Icon(Icons.lock,color: AppColor.iconColor,size: 22,);
  static Icon visibilityOnIcon = Icon(Icons.visibility,color: AppColor.iconColor,size: 22,);
  static Icon visibilityOffIcon = Icon(Icons.visibility_off,color: AppColor.iconColor,size: 22,);
  static Icon sportsIcon = Icon(Icons.sports_baseball,color: AppColor.iconColor,size: 22,);
  static Icon musicIcon = Icon(Icons.music_note,color: AppColor.iconColor,size: 22,);
  static Icon foodIcon = Icon(Icons.food_bank,color: AppColor.iconColor,size: 22,);
  static Icon phoneIcon = Icon(Icons.phone_android,color: AppColor.iconColor,size: 22,);
}