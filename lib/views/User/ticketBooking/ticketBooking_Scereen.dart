import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../App_Resources/App_Screen_Size.dart';
import '../../../models/eventmodel.dart';
import '../../../utils/showSnackbar.dart';
import '../bottomNavbar_Screen.dart';

class ticketBookingScreen extends StatefulWidget {
  ticketBookingScreen({super.key});

  @override
  State<ticketBookingScreen> createState() => _ticketBookingScreenState();
}

class _ticketBookingScreenState extends State<ticketBookingScreen> {

  late double price;

  @override
  void initState() {
    price = Get.arguments['price'];
    super.initState();
    vPrice = price+100;
    vTotal = price+100;
    ePrice = price;
    eTotal = price;
  }

  int counter = 1;
  double vPrice=0;
  double ePrice=0;
  double vTotal = 0;
  double eTotal = 0;

  bool ticketType = false;

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar:AppBar(
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Get.back();
            // Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),),
        title: Text("TICKET",style: TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: height * 0.025,),
            Row(
              children: [
                Text("Ticket Type",style: TextStyle(color: Colors.white,fontSize: 16),)
              ],
            ),
            SizedBox(height: height * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      ticketType = true;
                      counter = 1;
                      vTotal = price+100;
                    });
                  },
                  child: Container(
                    height: height * 0.065,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                        color: ticketType ? Colors.green.shade600 : Colors.green.shade600.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: Text("VIP",style: TextStyle(color: Colors.white,fontSize: 16,),)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      ticketType = false;
                      counter = 1;
                      eTotal = price;
                    });
                  },
                  child: Container(
                    height: height * 0.065,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                        color: ticketType ? Colors.green.shade600.withOpacity(0.5) : Colors.green.shade600,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child: Text("Economy",style: TextStyle(color: Colors.white,fontSize: 16),)),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.06,),
            Row(
              children: [
                Text("Seat",style: TextStyle(color: Colors.white,fontSize: 16),)
              ],
            ),
            SizedBox(height: height * 0.02,),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border(
                    top: BorderSide(color: Colors.white.withOpacity(0.2),width: 1),
                    bottom: BorderSide(color: Colors.white.withOpacity(0.2),width: 1),
                    left: BorderSide(color: Colors.white.withOpacity(0.2),width: 1),
                    right: BorderSide(color: Colors.white.withOpacity(0.2),width: 1),
                  ),
              ),
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  GestureDetector(
                    onTap:(){
                      setState(() {
                        if(ticketType == false){
                          if(counter <= 1){
                            eTotal = ePrice;
                          }else{
                            counter--;
                            eTotal = ePrice * counter;
                          }
                        }else{
                          if(counter <= 1){
                            vTotal = vPrice;
                          }else{
                            counter--;
                            vTotal = vPrice * counter;
                          }
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.green.shade600.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Icon(Icons.remove,color: Colors.white,size: 18,),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Text(counter.toString(),style: TextStyle(color: Colors.white,fontSize: 16),),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        if(ticketType == false){
                          counter++;
                          eTotal = ePrice *counter;
                        }else{
                          counter++;
                          vTotal = vPrice *counter;
                        }
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.green.shade600.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Icon(Icons.add,color: Colors.white,size: 18,),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: height * 0.06,),
            Row(
              children: [
                Text("Ticket Price",style: TextStyle(color: Colors.white,fontSize: 16),)
              ],
            ),
            SizedBox(height: height * 0.02,),
            SizedBox(
              height: height * 0.2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(ticketType ? "VIP Ticket" : "Economy Ticket",style: TextStyle(color: Colors.white,fontSize: 14),),
                      Text("₹ ${ticketType ? vPrice : ePrice}",style: TextStyle(color: Colors.green.shade600,fontSize: 14),),
                    ],
                  ),
                  SizedBox(height: height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Seats",style: TextStyle(color: Colors.white,fontSize: 14),),
                      Text(counter.toString(),style: TextStyle(color: Colors.white,fontSize: 14),),
                    ],
                  ),
                  SizedBox(height: height * 0.01,),
                  Divider(
                    color: Colors.white.withOpacity(0.2),
                  ),
                  SizedBox(height: height * 0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Price",style: TextStyle(color: Colors.white,fontSize: 14),),
                      Text("₹ ${ticketType ? vTotal : eTotal}",style: TextStyle(color: Colors.green.shade600,fontSize: 14),),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            GestureDetector(
              onTap: (){
                if(ticketType == false){
                  ticketBooking(counter, "economy",Get.arguments['data']);
                }else{
                  ticketBooking(counter, "vip",Get.arguments['data']);
                }
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(child: Text("CONTINUE",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 1),),),
              ),
            ),
            SizedBox(height: height * 0.025,)
          ],
        ),
      ),
    );
  }
  void ticketBooking(int sets,String type,eventDataModel data)async{
    final uid = FirebaseAuth.instance.currentUser!.uid;

    var random = Random();
    int randomNumber = random.nextInt(10000000);

    String id ="TICKET$randomNumber";

    String code = randomNumber.toString()+uid;

    print(uid);
    await FirebaseFirestore.instance.collection('ticket').doc(id).set({
      "id": id,
      "user_id": uid,
      "event_id": data.id,
      "type" : type,
      "seat" : sets,
      "qr_code" : code,
      "event_data" : {
        "title" : data.title,
        "date" : data.date,
        "img" : data.img,
        "location" : data.location
      }
    }).then((value) {
      Get.offAllNamed(appRoutesName.bottomNavbarScreen);
      // Navigator.push(context, MaterialPageRoute(builder: (context) => bottomNavbarScreen(),));
      return showSnackBar.message(context, "ticket is Booked");
    },);
    }
}
