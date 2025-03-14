
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/views/Organizer/organizerDashBord/organizerDashBordControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../../App_Resources/App_Color.dart';
import '../../../../App_Resources/App_Screen_Size.dart';
import '../wallet/wallet_Screen.dart';

class organizerDashBordScreen extends StatefulWidget {
  const organizerDashBordScreen({super.key});

  @override
  State<organizerDashBordScreen> createState() => _organizerDashBordScreenState();
}

class _organizerDashBordScreenState extends State<organizerDashBordScreen> {

  organizerDashBordControler controler = Get.put(organizerDashBordControler());

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: AppColor.primaryColour,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(appRoutesName.addEventScreen);
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => addEventScreen(),));
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border(
                        top: BorderSide(color: Colors.green.shade600,width: 0.5),
                        bottom: BorderSide(color: Colors.green.shade600,width: 0.5),
                        left: BorderSide(color: Colors.green.shade600,width: 0.5),
                        right: BorderSide(color: Colors.green.shade600,width: 0.5),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.my_library_add,color: Colors.green.shade600,size: 25,),
                          Text("ADD EVENT",style: TextStyle(color: Colors.white,fontSize: 12,letterSpacing: 1),)
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(appRoutesName.myEventScreen);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => myEventScreen(),));
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                          top: BorderSide(color: Colors.green.shade600,width: 0.5),
                          bottom: BorderSide(color: Colors.green.shade600,width: 0.5),
                          left: BorderSide(color: Colors.green.shade600,width: 0.5),
                          right: BorderSide(color: Colors.green.shade600,width: 0.5),
                        )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.collections,color: Colors.green.shade600,size: 25,),
                          Text("MY EVENT",style: TextStyle(color: Colors.white,fontSize: 12,letterSpacing: 1),)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(appRoutesName.ticketBookedScreen);
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                          top: BorderSide(color: Colors.green.shade600,width: 0.5),
                          bottom: BorderSide(color: Colors.green.shade600,width: 0.5),
                          left: BorderSide(color: Colors.green.shade600,width: 0.5),
                          right: BorderSide(color: Colors.green.shade600,width: 0.5),
                        )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmark,color: Colors.green.shade600,size: 25,),
                          Text("BOOKING",style: TextStyle(color: Colors.white,fontSize: 12,letterSpacing: 1),)
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(appRoutesName.walletScreen);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => walletScreen(),));
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                          top: BorderSide(color: Colors.green.shade600,width: 0.5),
                          bottom: BorderSide(color: Colors.green.shade600,width: 0.5),
                          left: BorderSide(color: Colors.green.shade600,width: 0.5),
                          right: BorderSide(color: Colors.green.shade600,width: 0.5),
                        )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wallet,color: Colors.green.shade600,size: 25,),
                          Text("PAYMENTS",style: TextStyle(color: Colors.white,fontSize: 12,letterSpacing: 1),)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(appRoutesName.cancelTicketsScreen);
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                          top: BorderSide(color: Colors.green.shade600,width: 0.5),
                          bottom: BorderSide(color: Colors.green.shade600,width: 0.5),
                          left: BorderSide(color: Colors.green.shade600,width: 0.5),
                          right: BorderSide(color: Colors.green.shade600,width: 0.5),
                        )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel_outlined,color: Colors.green.shade600,size: 25,),
                          Text("Cancel Tickets",style: TextStyle(color: Colors.white,fontSize: 12,letterSpacing: 1),)
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(appRoutesName.organizerProfileScreen);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => organizerProfileScreen(),));
                  },
                  child: Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                          top: BorderSide(color: Colors.green.shade600,width: 0.5),
                          bottom: BorderSide(color: Colors.green.shade600,width: 0.5),
                          left: BorderSide(color: Colors.green.shade600,width: 0.5),
                          right: BorderSide(color: Colors.green.shade600,width: 0.5),
                        )
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person,color: Colors.green.shade600,size: 25,),
                          Text("Profile",style: TextStyle(color: Colors.white,fontSize: 12,letterSpacing: 1),)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
