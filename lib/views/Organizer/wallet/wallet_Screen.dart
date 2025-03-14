import 'package:event_project_01/views/Organizer/wallet/walletControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class walletScreen extends StatefulWidget {
  const walletScreen({super.key});

  @override
  State<walletScreen> createState() => _walletScreenState();
}

class _walletScreenState extends State<walletScreen> {

  walletControler controler = Get.put(walletControler());

  @override
  void initState() {
    super.initState();
    controler.getEventPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Get.back();
            // Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),),
        title: Text("MY WALLET",style: TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2),),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final data = controler.payments;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Revenue",style: TextStyle(color: Colors.white,fontSize: 14),),
                      Text("₹ ${controler.Revenue}",style: TextStyle(color: Colors.green.shade600,fontSize: 14),)
                    ],
                  ),
                ),
                ListView.builder(itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.09),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:  Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        iconColor: Colors.green.shade600,
                        childrenPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                        leading: Text((index+1).toString(),style: TextStyle(color: Colors.green.shade600,fontSize: 14),),
                        title: Text(data[index].id,style: TextStyle(color: Colors.green.shade600,fontSize: 14),),
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Amount : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text("UserId : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text("ticketId : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text("eventId : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text("status : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text("Date : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text("Time : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                ],
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("₹ ${data[index].amount}",style: TextStyle(color: Colors.green.shade600,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text(data[index].userId,style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text(data[index].ticketId,style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text(data[index].eventId,style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text(data[index].status,style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text(DateFormat('MM/dd/yyyy').format(data[index].timestamp),style: TextStyle(color: Colors.white,fontSize: 14),),
                                  SizedBox(height: 5,),
                                  Text(DateFormat('hh:mm a').format(data[index].timestamp),style: TextStyle(color: Colors.white,fontSize: 14),),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                  itemCount: data.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                )
              ],
            ),
          );
        }
      },),
    );
  }
}
