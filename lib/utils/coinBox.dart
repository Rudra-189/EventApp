import 'package:event_project_01/views/User/Explore/exploreControler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

void showRewardDialog(String title,int coin){

  final exploreControler controler = Get.put(exploreControler());

  Get.dialog(
    AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), // Change the shape here
        ),
        title: Row(
          children: [
            Icon(Icons.card_giftcard,color: Colors.green.shade600,),
            SizedBox(width: 10,),
            Text('reward coins',style: TextStyle(fontSize: 16),),
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/images/coinAnimation.json',height: 100,width: 100),
                Text("+${coin}",style: TextStyle(color: Colors.black,fontSize: 20),),
                SizedBox(width: 20,)
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap:(){
              controler.getCoins();
              Get.back();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(child: Text("Collect coins",style: TextStyle(color: Colors.white),)),
                ),
              ],
            ),
          )
        ],

      ),
  );
}