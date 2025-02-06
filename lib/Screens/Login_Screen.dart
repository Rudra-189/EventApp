import 'package:event_project_01/App_Resources/App_Color.dart';
import 'package:event_project_01/App_Resources/App_Images.dart';
import 'package:event_project_01/App_Resources/App_Screen_Size.dart';
import 'package:event_project_01/App_Resources/widgets/Auth_Button.dart';
import 'package:event_project_01/App_Resources/widgets/button.dart';
import 'package:event_project_01/App_Resources/widgets/textFromFiled.dart';
import 'package:event_project_01/Screens/Bouttom_Navbar.dart';
import 'package:event_project_01/Screens/Signup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../App_Resources/App_Icon.dart';
import '../App_Resources/widgets/Password_TextFromFiled.dart';
import '../utils/showSnackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isOn=false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            height: height * 0.25,
            //color: Colors.green,
          ),
          Container(
            height: height * 0.3,
            width: width,
            //color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Sing in",style: TextStyle(color: AppColor.textColor,fontSize: 22,fontWeight: FontWeight.w900),)
                  ],
                ),
                SizedBox(height: height * 0.015,),
                custom_Textfromfiled(controller:emailController, hint: ' abc@gmail.com', prefixIcon: AppIcon.mailIcon),
                SizedBox(height: height * 0.015,),
                custom_PasswordTextFromFiled(controller:passwordController, hint: ' Your password', prefixIcon: AppIcon.passwordIcon),
                SizedBox(height: height * 0.015,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FlutterSwitch(
                          value: isOn,
                          onToggle: (value) {
                            setState(() {
                              isOn ? isOn = false : isOn = true;
                            });
                          },
                          height: 25,
                          width: 46,
                          padding: 1.5,
                        ),
                        SizedBox(width: 5,),
                        Text("Remember Me",style: TextStyle(color: AppColor.textColor,fontWeight: FontWeight.w500,fontSize: 15),)
                      ],
                    ),
                    Text("Forgot Password? ",style: TextStyle(color: AppColor.textColor,fontWeight: FontWeight.w500,fontSize: 15))
                  ],
                )
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
                  child: custom_Button(valu: "SIGN IN"),
                  onTap: (){
                    Showsnackbar();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BouttomNavbar(),));
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
                      child: Text("Sign up",style: TextStyle(color: AppColor.secondaryColour,fontSize: 16,fontWeight: FontWeight.w500),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
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
