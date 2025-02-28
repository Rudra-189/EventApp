import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../App_Resources/App_Color.dart';
import '../../App_Resources/App_Icon.dart';
import '../../App_Resources/App_Screen_Size.dart';
import '../../App_Resources/widgets/button.dart';

class forgotPasswordScreen extends StatefulWidget {
  const forgotPasswordScreen({super.key});

  @override
  State<forgotPasswordScreen> createState() => _forgotPasswordScreenState();
}

class _forgotPasswordScreenState extends State<forgotPasswordScreen> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,color: Colors.green.shade600,size: 20,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Reset Password",style: TextStyle(color: Colors.white,fontSize: 18),),
            SizedBox(height: height * 0.02,),
            Text("Please enter your email address to",style: TextStyle(color: Colors.white,fontSize: 14,letterSpacing: 1),),
            Text("request a password reset",style: TextStyle(color: Colors.white,fontSize: 14,letterSpacing: 1),),
            SizedBox(height: height * 0.05,),
            TextFormField(
              controller: emailController,
              cursorColor: AppColor.textColor,
              style: TextStyle(color:AppColor.textColor),
              decoration: InputDecoration(
                hintText: ' abc@gmail.com',
                filled: true,
                fillColor: AppColor.textFiledBgColor,
                contentPadding: EdgeInsets.symmetric(vertical: height *0.021),
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
                      color: AppColor.secondaryColour,
                      width: 0.5,
                    )
                ),
                prefixIcon: AppIcon.mailIcon,
              ),
            ),
            SizedBox(height: height * 0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: custom_Button(valu: "SIGN IN"),
                  onTap: (){
                    if(emailController.text.isEmpty){
                      showSnackBar.error_message(context, "Please Email.");
                    }else if(!_isValidEmail(emailController.text.toString())){
                      showSnackBar.error_message(context,"Please Enter the Valid Email");
                    }else{
                      resetPassword(emailController.text.toString());
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  bool _isValidEmail(String email) {
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  Future resetPassword(String email)async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      // Navigator.of(context).pop();
      showSnackBar.message(context, "Password Reset Email Sent");
    },).onError((error, stackTrace) {
      showSnackBar.error_message(context, error.toString());
    },);
  }
}
