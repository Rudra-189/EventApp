import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/utils/coinSystem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../App_Resources/App_Screen_Size.dart';
import '../../App_Resources/widgets/Auth_Button.dart';
import '../../App_Resources/widgets/button.dart';

class welcomeCoinScreen extends StatefulWidget {
  const welcomeCoinScreen({super.key});

  @override
  State<welcomeCoinScreen> createState() => _welcomeCoinScreenState();
}

class _welcomeCoinScreenState extends State<welcomeCoinScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coinSystem.addCoin(50, "Welcome Bonus!", "reward");
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.1,),
              Text("Thank you for joining us! 🎊 Get started with 50 complimentary coins!",style: TextStyle(color: Colors.white),),
              SizedBox(height: height * 0.05,),
              Text("🎉 Welcome Bonus!",style: TextStyle(color: Colors.green.shade600,letterSpacing: 1,fontSize: 25),),
              Lottie.asset("assets/images/coinAnimation.json",height: 300,width: 300),
              Text("+50",style: TextStyle(color: Colors.white,fontSize: 25,letterSpacing: 1),),
              Expanded(child: SizedBox()),
              InkWell(
                onTap: (){
                  Get.offAllNamed(appRoutesName.bottomNavbarScreen);
                },
                child: custom_Button(valu: "Continue"),
              ),
              SizedBox(height: height * 0.025,)
            ],
          ),
        ),
      ),
    );
  }
}
