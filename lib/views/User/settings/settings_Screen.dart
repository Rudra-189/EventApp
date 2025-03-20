import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../App_Resources/App_Screen_Size.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({super.key});

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,size: 18,color: Colors.white,),
        ),
        title: Text("SETTINGS",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: height * 0.065,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.095),
                borderRadius: BorderRadius.circular(15)
            ),
            child: ListTile(
              leading: Icon(Icons.settings,color: Colors.green.shade600,size: 20,),
              title: Text("Settings",style: TextStyle(color: Colors.white,fontSize: 14),),
              trailing: Icon(Icons.arrow_right,color: Colors.green.shade600,size: 20,),
            ),
          )
        ],
      )
    );
  }
}
