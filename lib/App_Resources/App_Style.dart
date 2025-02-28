import 'package:flutter/material.dart';

import 'App_Color.dart';

abstract class AppStyle{
  static TextStyle? commonTextStyle = TextStyle(color: AppColor.textColor,fontWeight: FontWeight.w500,fontSize: 15);
  static TextStyle? overFlowTextStyle = TextStyle(color: AppColor.textColor,fontWeight: FontWeight.w500,fontSize: 15,overflow: TextOverflow.ellipsis);
  static TextStyle? secondaryCommonTextStyle = TextStyle(color: AppColor.secondaryTextColour,fontWeight: FontWeight.w500,fontSize: 15);
  static TextStyle? headerTextStyle = TextStyle(color: AppColor.secondaryTextColour,fontWeight: FontWeight.w900,fontSize: 22);
  static TextStyle? ButtonTextStyle = TextStyle(color: AppColor.textColor,fontWeight: FontWeight.w700,fontSize:16);
}