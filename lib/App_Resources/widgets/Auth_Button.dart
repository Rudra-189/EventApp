import 'package:event_project_01/App_Resources/App_Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../App_Screen_Size.dart';

class custom_AuthButton extends StatelessWidget {
  String path;
  String valu;
  custom_AuthButton({super.key,required this.valu,required this.path});

  @override
  Widget build(BuildContext context) {
    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);
    return Container(
      height: height * 0.075,
      width: width * 0.75,
      decoration: BoxDecoration(
          color: AppColor.authButtonColor,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(path,width: 25,height: 25,),
          SizedBox(width: 20,),
          Text(valu,style: TextStyle(color: AppColor.textColor,fontSize: 16,fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}
