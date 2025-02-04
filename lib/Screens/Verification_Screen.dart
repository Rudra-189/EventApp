import 'package:event_project_01/App_Resources/App_Color.dart';
import 'package:event_project_01/App_Resources/widgets/otp_TextFromFiled.dart';
import 'package:flutter/material.dart';

import '../App_Resources/widgets/button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColour,
      body: Column(
        children: [
          SizedBox(height: 50,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Verification",style: TextStyle(color: AppColor.textColor,fontWeight:FontWeight.w900,fontSize: 22),),
                SizedBox(height: 10,),
                Text("We've send you the verification",style: TextStyle(color: AppColor.textColor,fontSize: 15),),
                Text("code on +1 2620 0323 7631",style: TextStyle(color: AppColor.textColor,fontSize: 15),),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    custom_otpTextfromfiled(controller: _controller1),
                    custom_otpTextfromfiled(controller: _controller2),
                    custom_otpTextfromfiled(controller: _controller3),
                    custom_otpTextfromfiled(controller: _controller4),
                  ],
                ),
                SizedBox(height: 30,),
                custom_Button(valu: "SIGN UP"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Re-send code in  ",style: TextStyle(color: AppColor.textColor,fontSize: 16),),
                    Text("0:20",style: TextStyle(color: AppColor.secondaryColour,fontSize: 16),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


