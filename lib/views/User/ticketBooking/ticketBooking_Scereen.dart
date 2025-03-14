import 'package:event_project_01/views/User/ticketBooking/ticketBookingControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../App_Resources/App_Screen_Size.dart';
import '../../../models/eventmodel.dart';
import '../../../utils/showSnackbar.dart';

class ticketBookingScreen extends StatefulWidget {
  ticketBookingScreen({super.key});

  @override
  State<ticketBookingScreen> createState() => _ticketBookingScreenState();
}

class _ticketBookingScreenState extends State<ticketBookingScreen> {

  final ticketBookingControler controler = Get.put(ticketBookingControler());

  double? Vprice;
  double? Eprice;
  eventDataModel? event;

  @override
  void initState() {
    event = Get.arguments['data'];
    Vprice = Get.arguments['Vprice'];
    Eprice = Get.arguments['Eprice'];
    super.initState();
    vPrice = Vprice!;
    vTotal = Vprice!;
    ePrice = Eprice!;
    eTotal = Eprice!;

    if(event!.availableSeats.VIP >0 && event!.availableSeats.Economy == 0){
      ticketType = true;
    }

    if(event!.availableSeats.VIP == 0 && event!.availableSeats.Economy > 0){
      ticketType = false;
    }

  }

  int counter = 1;
  double vPrice=0;
  double ePrice=0;
  double vTotal = 0;
  double eTotal = 0;
  bool ticketType = false;
  final int personTicketLimit = 5;

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
                    checkVipSeats() ? setState(() {
                      ticketType = true;
                      counter = 1;
                      vTotal = Vprice!;
                    }) : showSnackBar.message(context, "Vip Seats are not");
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
                    checkEconomySeats() ? setState(() {
                      ticketType = false;
                      counter = 1;
                      eTotal = Eprice!;
                    }) : showSnackBar.message(context, "Economy Seats are Not");
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
                          if(counter < event!.availableSeats.Economy){
                            if(counter < personTicketLimit){
                              counter++;
                              eTotal = ePrice *counter;
                            }else{
                              showSnackBar.error_message(context, "You can Only by 5 Ticket At Time");
                            }
                          }else{
                            showSnackBar.error_message(context, "Only ${event!.availableSeats.Economy.toString()} Seats Available of Economy");
                          }
                        }else{
                          if(counter < event!.availableSeats.VIP){
                            if(counter < personTicketLimit){
                              counter++;
                              vTotal = vPrice *counter;
                            }else{
                              showSnackBar.error_message(context, "You can Only by 5 Ticket At Time");
                            }
                          }else{
                            showSnackBar.error_message(context, "Only ${event!.availableSeats.VIP.toString()} Seats Available of Vip");
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
                  controler.getData(counter, "economy", event!);
                }else{
                  controler.getData(counter, "vip", event!);
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

  bool checkVipSeats(){
    if(event!.availableSeats.VIP > 0){
      return true;
    }else{
      return false;
    }
  }
  bool checkEconomySeats(){
    if(event!.availableSeats.Economy > 0){
      return true;
    }else{
      return false;
    }
  }
}
