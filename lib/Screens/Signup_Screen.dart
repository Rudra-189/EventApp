import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/App_Resources/App_Color.dart';
import 'package:event_project_01/App_Resources/App_Images.dart';
import 'package:event_project_01/App_Resources/App_Screen_Size.dart';
import 'package:event_project_01/App_Resources/App_Style.dart';
import 'package:event_project_01/App_Resources/widgets/Auth_Button.dart';
import 'package:event_project_01/App_Resources/widgets/button.dart';
import 'package:event_project_01/App_Resources/widgets/textFromFiled.dart';
import 'package:event_project_01/Screens/Verification_Screen.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../App_Resources/App_Icon.dart';
import '../App_Resources/widgets/Password_TextFromFiled.dart';
import 'Bouttom_Navbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool isOn=false;
  bool _isvisibel = true;

  final form_key=GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

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
            child: Form(
              key: form_key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Sing up",style: AppStyle.headerTextStyle)
                    ],
                  ),
                  SizedBox(height: height * 0.025,),
                  TextFormField(
                    controller: nameController,
                    cursorColor: AppColor.textColor,
                    style: TextStyle(color:AppColor.textColor),
                    decoration: InputDecoration(
                      hintText: ' Full name',
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
                      prefixIcon: AppIcon.personIcon,
                    ),
                  ),
                  // custom_Textfromfiled(controller:nameController, hint: ' Full name', prefixIcon: AppIcon.personIcon),
                  SizedBox(height: height * 0.02,),
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
                  // custom_Textfromfiled(controller:emailController, hint: ' abc@gmail.com', prefixIcon: AppIcon.mailIcon),
                  SizedBox(height: height * 0.02,),
                  TextFormField(
                    obscureText: _isvisibel,
                    controller: passwordController,
                    cursorColor: AppColor.textColor,
                    style: TextStyle(color:AppColor.textColor),
                    decoration: InputDecoration(
                        hintText: ' Your password',
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
                        prefixIcon: AppIcon.passwordIcon,
                        suffixIcon: _isvisibel ? GestureDetector(child: AppIcon.visibilityOffIcon,onTap: (){
                          setState(() {
                            _isvisibel = false;
                          });
                        },) : GestureDetector(child: AppIcon.visibilityOnIcon,onTap: (){
                          setState(() {
                            _isvisibel = true;
                          });
                        },)
                    ),
                  ),
                  // custom_PasswordTextFromFiled(controller:passwordController, hint: ' Your password', prefixIcon: AppIcon.passwordIcon),
                  SizedBox(height: height * 0.02,),
                  TextFormField(
                    obscureText: _isvisibel,
                    controller: confirmPasswordController,
                    cursorColor: AppColor.textColor,
                    style: TextStyle(color:AppColor.textColor),
                    decoration: InputDecoration(
                        hintText: ' Confirm password',
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
                        prefixIcon: AppIcon.passwordIcon,
                        suffixIcon: _isvisibel ? GestureDetector(child: AppIcon.visibilityOffIcon,onTap: (){
                          setState(() {
                            _isvisibel = false;
                          });
                        },) : GestureDetector(child: AppIcon.visibilityOnIcon,onTap: (){
                          setState(() {
                            _isvisibel = true;
                          });
                        },)
                    ),
                  ),
                  // custom_PasswordTextFromFiled(controller:confirmPasswordController, hint: ' Confirm password', prefixIcon: AppIcon.passwordIcon),
                  SizedBox(height: height * 0.02,),
                ],
              ),
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
                    if(nameController.text.isEmpty){
                      showSnackBar.error_message(context, "Name is required");
                    }else if(emailController.text.isEmpty){
                      showSnackBar.error_message(context, "Email is required");
                    }else if(passwordController.text.isEmpty){
                      showSnackBar.error_message(context, "Password is required");
                    }else if(confirmPasswordController.text.isEmpty){
                      showSnackBar.error_message(context, "ConfirmPassword is required");
                    }else if(!_isValidEmail(emailController.text.toString())){
                      showSnackBar.error_message(context,"Please Enter the Valid Email");
                    }else if(passwordController.text.toString().length < 6){
                      showSnackBar.error_message(context,"Please Enter 6 latter in Password");
                    }else if(passwordController.text.toString() != confirmPasswordController.text.toString()){
                      showSnackBar.error_message(context,"Password Does't Match");
                    }else{
                      signupUser(nameController.text.toString(),emailController.text.toString(),passwordController.text.toString());
                    }
                  },
                ),
                SizedBox(height: height * 0.025,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("OR",style: AppStyle.commonTextStyle,),
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
                    Text("Don’t have an account?  ",style: AppStyle.commonTextStyle,),
                    InkWell(
                      child: Text("Sign in",style: AppStyle.secondaryCommonTextStyle),
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

  void signupUser(String name,email,password)async{
    print(name);
    print(email);
    print(password);
    try {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BouttomNavbar(),));
      storeUserData(result.user!.uid.toString(),name,email,password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar.error_message(context,"The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar.error_message(context,"The account already exists for that email.");
      }
    }
  }
  bool _isValidEmail(String email) {
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  Future storeUserData(String uid,name,email,password)async{
    await FirebaseFirestore.instance.collection('user').doc(uid).set({
      'id': uid,
      'name': name,
      'email': email,
      'password' : password
    });
  }
}
