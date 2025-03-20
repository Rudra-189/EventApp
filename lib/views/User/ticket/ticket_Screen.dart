import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:event_project_01/views/User/ticket/ticketControler.dart';
import 'package:event_project_01/views/loaderControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../../../App_Resources/App_Screen_Size.dart';
import '../../../models/ticketModel.dart';


class ticketScreen extends StatefulWidget {
  const ticketScreen({super.key});

  @override
  State<ticketScreen> createState() => _ticketScreenState();
}

class _ticketScreenState extends State<ticketScreen> {

  final loaderControler loader = Get.put(loaderControler());

  final ticketControler controler = Get.put(ticketControler());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controler.getTicket();
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade600,
        title: Text("TICKET",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final ticketData = controler.tickets;
          if(ticketData.isEmpty){
            return Center(child: Text("No Ticket Found",style: TextStyle(color: Colors.white,fontSize: 12),));
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(itemBuilder: (context, index) {
                    if(ticketData[index].status == "booked"){
                      return Container(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:  ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: Image.network(
                                ticketData[index].eventData.img,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(ticketData[index].eventData.title,style: TextStyle(color: Colors.white,fontSize: 16,overflow:TextOverflow.ellipsis),) ,
                          subtitle: Row(
                            children: [
                              Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                              Text(DateFormat('MM/dd/yyyy').format(ticketData[index].eventData.date),style: TextStyle(color: Colors.white,fontSize: 10),),
                              SizedBox(width: 5,),
                              Icon(Icons.timer_outlined,color: Colors.green.shade600,size: 16,),
                              Text( DateFormat('hh:mm a').format(ticketData[index].eventData.date),style: TextStyle(color: Colors.white,fontSize: 10),),
                            ],
                          ),
                          trailing: PopupMenuButton(
                            color: Colors.white,
                            iconColor: Colors.white,
                            itemBuilder: (context) =>[
                              PopupMenuItem(
                                child: ListTile(
                                  leading: Icon(Icons.download,color: Colors.green.shade600,size: 20,),
                                  title:  Text("Download",style: TextStyle(fontSize: 14),),
                                ),
                                onTap: (){
                                  controler.generateAndDownloadPdf(controler.tickets[index],false);
                                },
                              ),
                              PopupMenuItem(
                                onTap: (){
                                  controler.generateAndDownloadPdf(controler.tickets[index],true );
                                },
                                child: ListTile(
                                  leading:  Icon(Icons.share_outlined,color: Colors.green.shade600,size: 20,),
                                  title: Text("Share",style: TextStyle(fontSize: 14),),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: (){
                                  showCancelDialog(context,ticketData[index]);
                                },
                                child: ListTile(
                                  leading:  Icon(Icons.cancel,color: Colors.green.shade600,size: 20,),
                                  title: Text("Cancel",style: TextStyle(fontSize: 14),),
                                ),
                              ),
                            ],
                          ),
                          onTap: (){
                            _showTicketDialog(ticketData[index]);
                          },
                        ),
                      );
                    }else if(ticketData[index].status == "pending"){
                      return Container(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:  ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5), // Adjust darkness (0.0 to 1.0)
                                  BlendMode.darken, // Darken effect
                                ),
                                child: Image.network(
                                  ticketData[index].eventData.img,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          title: Text(ticketData[index].eventData.title,style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 16,overflow:TextOverflow.ellipsis),) ,
                          subtitle: Row(
                            children: [
                              Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                              Text(DateFormat('MM/dd/yyyy').format(ticketData[index].eventData.date),style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 10),),
                              SizedBox(width: 5,),
                              Icon(Icons.timer_outlined,color: Colors.green.shade600,size: 16,),
                              Text(DateFormat('hh:mm a').format(ticketData[index].eventData.date),style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 10),),
                            ],
                          ),
                          trailing: Text("pending",style: TextStyle(color: Colors.green.shade600),),
                          onTap: (){
                            showSnackBar.message(context, "cancellation request is in process");
                          },
                        ),
                      );
                    }else if(ticketData[index].status == "cancel"){
                      return Container(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:  ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5), // Adjust darkness (0.0 to 1.0)
                                  BlendMode.darken, // Darken effect
                                ),
                                child: Image.network(
                                  ticketData[index].eventData.img,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          title: Text(ticketData[index].eventData.title,style: TextStyle(color: Colors.white.withOpacity(0.25),fontSize: 16,overflow:TextOverflow.ellipsis),) ,
                          subtitle: Row(
                            children: [
                              Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                              Text(DateFormat('MM/dd/yyyy').format(ticketData[index].eventData.date),style: TextStyle(color: Colors.white.withOpacity(0.25),fontSize: 10),),
                              SizedBox(width: 5,),
                              Icon(Icons.timer_outlined,color: Colors.green.shade600,size: 16,),
                              Text( DateFormat('hh:mm a').format(ticketData[index].eventData.date),style: TextStyle(color: Colors.white.withOpacity(0.25),fontSize: 10),),
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: (){

                            },
                            child: Icon(Icons.cancel_outlined,color: Colors.red,size: 20,),
                          ),
                        ),
                      );
                    }
                  },
                    itemCount: ticketData.length,
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
  void _showTicketDialog(ticketDataModel data) {
    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: TicketWidget(
            width: width * 0.75,
            height: height * 0.65,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.3,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.225,
                          decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(data.eventData.img),
                                    fit: BoxFit.cover
                                )
                            ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: SizedBox(
                            height: height * 0.075,
                            child: Text(data.eventData.title,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  DottedLine(dashColor: Colors.black.withOpacity(0.25),),
                  Expanded(child: SizedBox()),
                  SizedBox(
                    height: height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("Date",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                                SizedBox(height: 2,),
                                Text(DateFormat('MM/dd/yyyy').format(data.eventData.date),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text("Venue",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                                SizedBox(height: 2,),
                                Text(data.eventData.date.day.toString(),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(width: width * 0.15,),
                            Column(
                              children: [
                                Text("Time",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                                SizedBox(height: 2,),
                                Text(DateFormat('hh:mm a').format(data.eventData.date),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text("Seat",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                                SizedBox(height: 2,),
                                Text(data.seat.toString(),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02,),
                        SizedBox(
                          height: height * 0.15,
                          child: SfBarcodeGenerator(
                            value: data.qrCode,
                            barColor: data.type == 'vip' ? Colors.amber.shade700 : Colors.black,
                            symbology: QRCode(),
                          ),
                        )
                      ],
                    )
                  ),
                ],
              ),
            )
          ),
        );
      },
    );
  }

  void showCancelDialog(BuildContext context,ticketDataModel ticket) {
    List<String> reasons = [
      "Change of plans",
      "Event timing issue",
      "Found a better event",
      "Personal reasons",
      "Other"
    ];

    String selectedReason = reasons[0]; // Default reason

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0)
              ),
              title: Text("Cancel Ticket"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Please select a reason for cancellation:"),
                  SizedBox(height: 10),
                  Column(
                    children: reasons.map((reason) {
                      return RadioListTile(
                        title: Text(reason,style: TextStyle(fontSize: 14),),
                        value: reason,
                        groupValue: selectedReason,
                        onChanged: (value) {
                          setState(() {
                            selectedReason = value.toString();
                          });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Note: Refund will be processed within 7 days.",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("No"),
                ),
                GestureDetector(
                  onTap: (){
                    requestCancelTicket(ticket, selectedReason);
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade600,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7.5),
                    child:  Text("Yes, Cancel",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void requestCancelTicket(ticketDataModel ticket,reason)async{
    try{
      loader.startLoading();
      FirebaseFirestore.instance.collection('ticket').doc(ticket.id).update({
        "status" : "pending",
      });
      String id = FirebaseFirestore.instance.collection('cancel').doc().id;
      FirebaseFirestore.instance.collection('cancel').doc(id).set({
        "id" : id,
        "userId" : ticket.userId,
        "eventId" : ticket.eventId,
        "ticketId" : ticket.id,
        "paymentId" : ticket.payment_id,
        "cancel_reason": reason,
        "organizer_approval": false,
      });
    }catch(e){
      print(e.toString());
    }finally{
      loader.stopLoading();
      controler.getTicket();
    }
  }
  
}
