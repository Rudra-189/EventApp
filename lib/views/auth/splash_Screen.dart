import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Organizer/organizerDashBord/organizerDashBord_Screen.dart';
import '../User/bottomNavbar_Screen.dart';
import 'login_Screen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Image.asset("assets/images/BG Event Era.png")),
    );
  }

  void checkLogin()async{
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("user").doc(user.uid).get();

      if (userDoc.exists) {
        String role = userDoc.get("role");
        if (role == "Organizer") {
          Timer(Duration(seconds: 3),
                ()=>Get.offAllNamed(appRoutesName.organizerDashBordScreen)
          );
        } else if(role == "User"){
          Timer(Duration(seconds: 3),
                ()=>Get.offAllNamed(appRoutesName.bottomNavbarScreen)
          );
        }
      }else{
        Timer(Duration(seconds: 3),
              ()=>Get.offAllNamed(appRoutesName.loginScreen)
        );
      }
    }else{
      Timer(Duration(seconds: 3),
            ()=>Get.offAllNamed(appRoutesName.loginScreen)
      );
    }
  }
}
