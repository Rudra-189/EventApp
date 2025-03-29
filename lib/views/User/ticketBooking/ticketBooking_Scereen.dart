import 'package:event_project_01/views/User/ticketBooking/ticketBookingControler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 1),() {
        if(controler.user.value!.coin > 100){
          askUserToUseCoin(controler.user.value!.coin);
        }
      },);
    });
    event = Get.arguments['data'];
    Vprice = Get.arguments['Vprice'];
    Eprice = Get.arguments['Eprice'];
    super.initState();

    controler.getBookedTicket(event!.id);
    vPrice = Vprice!;
    vTotal = Vprice!;
    ePrice = Eprice!;
    eTotal = Eprice!;

    eFinalPrice = eTotal - (eTotal*(10/100));
    vFinalPrice = vTotal - (vTotal *(10/100));

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

  //coin
  bool isUsingCoins = false;
  int coinsUsed = 0;
  int discount = 0;
  double eFinalPrice = 0;
  double vFinalPrice = 0;

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
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          return Padding(
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
                          vFinalPrice = vTotal - (vTotal*(discount/100));
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
                          eFinalPrice = eTotal - (eTotal*(discount/100));
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
                SizedBox(height: height * 0.04,),
                Row(
                  children: [
                    Text("Seat",style: TextStyle(color: Colors.white,fontSize: 16),)
                  ],
                ),
                SizedBox(height: height * 0.02,),
                Container(
                  height: height * 0.075,
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
                                eFinalPrice = eTotal - (eTotal*(discount/100));
                              }else{
                                counter--;
                                eTotal = ePrice * counter;
                                eFinalPrice = eTotal - (eTotal*(discount/100));
                              }
                            }else{
                              if(counter <= 1){
                                vTotal = vPrice;
                                vFinalPrice = vTotal - (vTotal*(discount/100));
                              }else{
                                counter--;
                                vTotal = vPrice * counter;
                                vFinalPrice = vTotal - (vTotal*(discount/100));
                              }
                            }
                          });
                        },
                        child: Container(
                          height: height * 0.06,
                          width: height * 0.06,
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
                                  if(counter < (5-controler.bookedTicket)){
                                    counter++;
                                    eTotal = ePrice *counter;
                                    eFinalPrice = eTotal - (eTotal*(discount/100));
                                  }else if((5-controler.bookedTicket) == 0 ){
                                    showSnackBar.error_message(context, "you already booked 5 ticket of this event");
                                  }else{
                                    showSnackBar.error_message(context, "You can Only book ${5-controler.bookedTicket}");
                                  }
                                }else{
                                  showSnackBar.error_message(context, "You can Only by 5 Ticket At Time");
                                }
                              }else{
                                showSnackBar.error_message(context, "Only ${event!.availableSeats.Economy.toString()} Seats Available of Economy");
                              }
                            }else{
                              if(counter < event!.availableSeats.VIP){
                                if(counter < personTicketLimit){
                                  if(counter < (5-controler.bookedTicket)){
                                    counter++;
                                    vTotal = vPrice *counter;
                                    vFinalPrice = vTotal - (vTotal*(discount/100));
                                  }else if((5-controler.bookedTicket) == 0 ){
                                    showSnackBar.error_message(context, "you already booked 5 ticket of this event");
                                  }else{
                                    showSnackBar.error_message(context, "You can Only book ${5-controler.bookedTicket}");
                                  }
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
                          height: height * 0.06,
                          width: height * 0.06,
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
                SizedBox(height: height * 0.04,),
                Row(
                  children: [
                    Text("Ticket Price",style: TextStyle(color: Colors.white,fontSize: 16),)
                  ],
                ),
                SizedBox(height: height * 0.02,),
                SizedBox(
                  height: height * 0.4,
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
                      isUsingCoins ? SizedBox(
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.03,),
                            Row(
                              children: [
                                Text("Available Coins : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                SizedBox(width: 5,),
                                Text("${controler.user.value!.coin}",style: TextStyle(color: Colors.green.shade600,fontSize: 14),),
                                Expanded(child: SizedBox()),
                                GestureDetector(
                                  onTap:(){
                                    if (coinsUsed > 100) {
                                      setState(() {
                                        coinsUsed -= 10;
                                        discount -=1;
                                        if(ticketType == false){
                                          eFinalPrice = eTotal - (eTotal*(discount/100));
                                        }else{
                                          vFinalPrice = vTotal - (vTotal*(discount/100));
                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.25),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.remove, color: Colors.red,size: 16,),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("${coinsUsed}",style: TextStyle(color: Colors.white,fontSize: 14),),
                                SizedBox(width: 20,),
                                GestureDetector(
                                  onTap: (){
                                    if (coinsUsed < 200 && coinsUsed < controler.user.value!.coin) {
                                      setState(() {
                                        coinsUsed += 10;
                                        discount +=1;
                                        if(ticketType == false){
                                          eFinalPrice = eTotal - (eTotal*(discount/100));
                                        }else{
                                          vFinalPrice = vTotal - (vTotal*(discount/100));
                                        }
                                      });
                                    }else{
                                      showSnackBar.error_message(context,"you can get max 20 % discount");
                                    }
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade600.withOpacity(0.25),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.add, color: Colors.green.shade600,size: 16,),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Discount Applied : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                Expanded(child: SizedBox()),
                                Text("${discount}",style: TextStyle(color: Colors.green.shade600,fontSize: 14),),
                                SizedBox(width: 5,),
                                Text("%",style: TextStyle(color: Colors.white,fontSize: 14),)
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
                                Text("Final Price",style: TextStyle(color: Colors.white,fontSize: 14),),
                                Text("₹${ticketType ? vFinalPrice : eFinalPrice}",style: TextStyle(color: Colors.green.shade600,fontSize: 14),),
                              ],
                            ),
                          ],
                        ),
                      ) : SizedBox()
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: (){
                    if(controler.bookedTicket < 5){
                      if(ticketType == false){
                        controler.getData(counter,discount,coinsUsed, "economy", event!);
                      }else{
                        controler.getData(counter,discount,coinsUsed, "vip", event!);
                      }
                    }else{
                      showSnackBar.error_message(context,"you already booked 5 tickets.");
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
          );
        }
      },)
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

  void askUserToUseCoin(int coin){
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Change the shape here
          ),
          title: Row(
            children: [
              Icon(Icons.card_giftcard,color: Colors.green.shade600,),
              SizedBox(width: 10,),
              Text('Use Coins?',style: TextStyle(fontSize: 16),),
              Expanded(child: SizedBox()),
              SvgPicture.asset("assets/images/coin.svg",height: 15,width: 15 ,),
              Text(" ${coin}",style: TextStyle(color: Colors.black,fontSize: 12),),
            ],
          ),
          content: StatefulBuilder(
            builder: (context, setDialogState){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text("Do you want to use coin to get Discount?",style: TextStyle(color: Colors.black,fontSize: 12),),
                    ],
                  ),
                ],
              );
            }
          ),
          actions: [
            GestureDetector(
              onTap:(){
                Get.back();
                setState(() {
                  isUsingCoins = false;
                });
              },
              child: Text("Cancel",style: TextStyle(color: Colors.green.shade600),),
            ),
            SizedBox(width: 5,),
            GestureDetector(
              onTap:(){
                Get.back();
                setState(() {
                  isUsingCoins = true;
                  discount = 10;
                  coinsUsed = 100;
                });
              },
              child: Container(
                height: 30,
                width: 50,
                decoration: BoxDecoration(color: Colors.green.shade600),
                child: Center(child: Text("Use",style: TextStyle(color: Colors.white),)),
              ),
            )
          ],
        );
      },
    );
  }

}
