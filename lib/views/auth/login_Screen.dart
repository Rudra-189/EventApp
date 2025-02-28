import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/routes/appRoutes.dart';
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/views/auth/forgotPassword_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../App_Resources/App_Color.dart';
import '../../App_Resources/App_Icon.dart';
import '../../App_Resources/App_Images.dart';
import '../../App_Resources/App_Screen_Size.dart';
import '../../App_Resources/App_Style.dart';
import '../../App_Resources/widgets/Auth_Button.dart';
import '../../App_Resources/widgets/button.dart';
import '../../utils/showSnackbar.dart';
import '../Organizer/organizerDashBord/organizerDashBord_Screen.dart';
import '../User/bottomNavbar_Screen.dart';
import 'signup_Screen.dart';


class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  bool isOn=false;
  bool _isvisibel = true;

  final form_key=GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }

  var _role;

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
            height: height * 0.3,
            //color: Colors.green,
          ),
          Container(
            height: height * 0.35,
            //color: Colors.red,
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: form_key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text("Sing in",style: AppStyle.headerTextStyle,)
                    ],
                  ),
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
                  SizedBox(height: height * 0.02,),
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
                            height: height * 0.0315,
                            width: width * 0.125,
                            padding: 1.5,
                            activeColor: AppColor.secondaryColour,
                          ),
                          SizedBox(width: 5,),
                          Text("Remember Me",style: AppStyle.commonTextStyle,)
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(appRoutesName.forgotPasswordScreen);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => forgotPasswordScreen(),));
                        },
                        child: Text("Forgot Password? ",style: AppStyle.secondaryCommonTextStyle),
                      )
                    ],
                  ),
                  SizedBox(height: height * 0.02,),
                ],
              ),
            ),
          ),
          Container(
            height: height * 0.35,
            //color: Colors.amber,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: height * 0.03,),
                InkWell(
                  child: custom_Button(valu: "SIGN IN"),
                  onTap: (){
                    print(_role);
                    if(emailController.text.isEmpty){
                      showSnackBar.error_message(context,"Email is require");
                    }else if(passwordController.text.isEmpty){
                      showSnackBar.error_message(context,"Password is require");
                    }else if(!_isValidEmail(emailController.text.toString())){
                      showSnackBar.error_message(context,"Please Enter the Valid Email");
                    }else if(passwordController.text.toString().length < 6){
                      showSnackBar.error_message(context,"Please Enter 6 latter in Password");
                    }else{
                      loginUser(emailController.text.toString(),passwordController.text.toString());
                    }
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => BouttomNavbar(),));
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account?  ",style: AppStyle.commonTextStyle),
                    InkWell(
                      child: Text("Sign up",style: AppStyle.secondaryCommonTextStyle),
                      onTap: (){
                        Get.toNamed(appRoutesName.signupScreen);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => signupScreen(),));
                      },
                    )
                  ],
                ),
                SizedBox(height: height * 0.01,),
              ],
            ),
          )
        ],
      ),
    );
  }

  void loginUser(String email,password)async{
    print(email);
    print(password);
    try {
      UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("user").doc(result.user!.uid).get();

      if (userDoc.exists) {
        String role = userDoc.get("role");
        if (role == "Organizer") {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => organizerDashBordScreen(),));
          showSnackBar.message(context, "account Login success ");
        } else if(role == "User"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => bottomNavbarScreen(),));
          showSnackBar.message(context, "account Login success ");
        }
      }else{
        showSnackBar.error_message(context, "User not found!");
      }
    } on FirebaseAuthException {
      showSnackBar.error_message(context, "Email and Password are Wrong");
    }
  }
  bool _isValidEmail(String email) {
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }
}
