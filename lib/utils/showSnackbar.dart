import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class showSnackBar{
  static void error_message(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 35,
          child: Row(
            children: [
              SvgPicture.asset('assets/images/wrong.svg',),
              SizedBox(width: 20,),
              Expanded(child: Text(message,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),))
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0XFFF4F4F4),
        duration: Duration(seconds: 2),
        margin: EdgeInsets.only(bottom: 25,right: 20,left: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  static void message(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 35,
          child: Row(
            children: [
              SvgPicture.asset('assets/images/right.svg',),
              SizedBox(width: 20,),
              Expanded(child: Text(message,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),))
            ],
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0XFFF4F4F4),
        duration: Duration(seconds: 2),
        margin: EdgeInsets.only(bottom: 25,right: 20,left: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
