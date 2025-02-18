import 'package:event_project_01/App_Resources/App_Color.dart';
import 'package:event_project_01/App_Resources/App_Style.dart';
import 'package:flutter/cupertino.dart';

import '../App_Screen_Size.dart';

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
