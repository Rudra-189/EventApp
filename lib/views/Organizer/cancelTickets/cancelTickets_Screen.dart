import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/utils/notification.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:event_project_01/views/Organizer/organizerDashBord/organizerDashBordControler.dart';
import 'package:event_project_01/views/loaderControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'cancelTicketControler.dart';


class cancelTicketScreen extends StatefulWidget {
  const cancelTicketScreen({super.key});

  @override
  State<cancelTicketScreen> createState() => _cancelTicketScreenState();
}

class _cancelTicketScreenState extends State<cancelTicketScreen> {

  final loaderControler loader = Get.put(loaderControler());

  final cancelTicketControler controler = Get.put(cancelTicketControler());

  final organizerDashBordControler ocontroler = Get.put(organizerDashBordControler());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Get.back();
            // Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),),
        title: Text("CANCEL TICKETS",style: TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final data = controler.canceledTickets;
          if(data.isEmpty){
            return Center(child: Text("No Cancel Ticket Found.",style: TextStyle(color: Colors.white,fontSize: 12),));
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10,),
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
                                    Text("eventId : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                    SizedBox(height: 5,),
                                    Text("userId : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                    SizedBox(height: 5,),
                                    Text("reason : ",style: TextStyle(color: Colors.white,fontSize: 14),),
                                    SizedBox(height: 5,),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data[index].eventId,style: TextStyle(color: Colors.white,fontSize: 14),),
                                    SizedBox(height: 5,),
                                    Text(data[index].userId,style: TextStyle(color: Colors.white,fontSize: 14),),
                                    SizedBox(height: 5,),
                                    Text(data[index].cancel_reason,style: TextStyle(color: Colors.white,fontSize: 14),),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            GestureDetector(
                              child: Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.green.shade600,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child:Center(child: Text("APPROVED",style: TextStyle(color: Colors.white,fontSize: 14,),)),
                              ),
                              onTap: (){
                                approvedTicketCancel(data[index].ticketId,data[index].id,data[index].paymentId);
                              },
                            ),
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
        }
      },),
    );
  }

  void approvedTicketCancel(String tId,cId,pId)async{
    try{
      loader.startLoading();
      await FirebaseFirestore.instance.collection('ticket').doc(tId).delete();
      await FirebaseFirestore.instance.collection('cancel').doc(cId).delete();
      await FirebaseFirestore.instance.collection('payments').doc(pId).delete();
    }catch(e){
      print("///////////${e.toString()}////////////");
    }finally{
      loader.stopLoading();
      showSnackBar.message(context, "Ticket Cancel Successfully");
      controler.getMyEvent();
      ocontroler.getMyEvent();
    }
  }
}
