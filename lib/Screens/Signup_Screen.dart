import 'package:event_project_01/App_Resources/App_Color.dart';
import 'package:event_project_01/App_Resources/App_Images.dart';
import 'package:event_project_01/App_Resources/App_Screen_Size.dart';
import 'package:event_project_01/App_Resources/widgets/Auth_Button.dart';
import 'package:event_project_01/App_Resources/widgets/button.dart';
import 'package:event_project_01/App_Resources/widgets/textFromFiled.dart';
import 'package:event_project_01/Screens/Verification_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../App_Resources/App_Icon.dart';
import '../App_Resources/widgets/Password_TextFromFiled.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool isOn=false;

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primaryColour,
      body:Column(
        children: [
          Container(
            height: height * 0.55,
            width: width,
            //color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text("Sing up",style: TextStyle(color: AppColor.textColor,fontSize: 22,fontWeight: FontWeight.w900),)
                  ],
                ),
                SizedBox(height: height * 0.015,),
                custom_Textfromfiled(controller:userController, hint: ' Full name', prefixIcon: AppIcon.personIcon),
                SizedBox(height: height * 0.015,),
                custom_Textfromfiled(controller:emailController, hint: ' abc@gmail.com', prefixIcon: AppIcon.mailIcon),
                SizedBox(height: height * 0.015,),
                custom_PasswordTextFromFiled(controller:passwordController, hint: ' Your password', prefixIcon: AppIcon.passwordIcon),
                SizedBox(height: height * 0.015,),
                custom_PasswordTextFromFiled(controller:confirmPasswordController, hint: ' Confirm password', prefixIcon: AppIcon.passwordIcon),
                SizedBox(height: height * 0.035,),
              ],
            ),
          ),
          Container(
            height: height * 0.45,
            //color: Colors.amber,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: height * 0.025,),
                InkWell(
                  child: custom_Button(valu: "SIGN UP"),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>VerificationScreen(),));
                  },
                ),
                SizedBox(height: height * 0.025,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OR"),
                  ],
                ),
                SizedBox(height: height * 0.025,),
                custom_AuthButton(valu: "Login with Google", path: AppImage.googleImg),
                SizedBox(height: height * 0.025,),
                custom_AuthButton(valu: "Login with Facebook", path: AppImage.facebookImg),
                SizedBox(height: height * 0.025,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account?  ",style: TextStyle(color: AppColor.textColor,fontWeight: FontWeight.w500,fontSize: 16),),
                    InkWell(
                      child: Text("Sign in",style: TextStyle(color: AppColor.secondaryColour,fontSize: 16,fontWeight: FontWeight.w500),),
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                    )
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
