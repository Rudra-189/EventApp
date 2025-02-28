import 'package:flutter/cupertino.dart';

import '../App_Color.dart';
import '../App_Screen_Size.dart';
import '../App_Style.dart';

class custom_Button extends StatelessWidget {
  String valu;
  custom_Button({super.key,required this.valu});

  @override
  Widget build(BuildContext context) {
    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);
    return Container(
      height: height * 0.075,
      width: width * 0.75,
      decoration: BoxDecoration(
        color: AppColor.secondaryColour,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Center(child: Text(valu,style: AppStyle.ButtonTextStyle,)),
    );
  }
}
