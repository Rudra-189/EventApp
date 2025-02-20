import 'dart:async';

import 'package:event_project_01/Screens/Bouttom_Navbar.dart';
import 'package:event_project_01/Screens/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class splash_Screen extends StatefulWidget {
  const splash_Screen({super.key});

  @override
  State<splash_Screen> createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Text("Event Era",style: TextStyle(color: Colors.green.shade600,fontSize: 20),)),
    );
  }

  void checkLogin(){
    Timer(Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BouttomNavbar(),),),
    );
    // final user = FirebaseAuth.instance.currentUser;
    // if(user != null){
    //   Timer(Duration(seconds: 3),
    //         ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BouttomNavbar(),),),
    //   );
    // }else{
    //   Timer(Duration(seconds: 3),
    //         ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),),),
    //   );
    // }
  }
}
