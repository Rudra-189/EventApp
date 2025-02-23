import 'package:dotted_line/dotted_line.dart';
import 'package:event_project_01/Screens/ticket/ticketControler.dart';
import 'package:event_project_01/models/ticketModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../../App_Resources/App_Screen_Size.dart';

class ticket_Page extends StatefulWidget {
  const ticket_Page({super.key});

  @override
  State<ticket_Page> createState() => _ticket_PageState();
}

class _ticket_PageState extends State<ticket_Page> {

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
        backgroundColor: Colors.green.shade600,
        title: Text("TICKET",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }else{
          final data = controler.tickets;
          return Column(
            children: [
              ListView.builder(itemBuilder: (context, index) {
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
                            data[index].eventData.img,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Expanded(child: Text(data[index].eventData.title,style: TextStyle(color: Colors.white,fontSize: 16,overflow:TextOverflow.ellipsis),)),
                      subtitle: Row(
                        children: [
                          Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                          Text(data[index].eventData.date,style: TextStyle(color: Colors.white,fontSize: 10),),
                          SizedBox(width: 5,),
                          Icon(Icons.timer_outlined,color: Colors.green.shade600,size: 16,),
                          Text(data[index].eventData.time,style: TextStyle(color: Colors.white,fontSize: 10),),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VerticalDivider(
                            color: Colors.white,
                          ),
                          Text("TICKET",style: TextStyle(color: Colors.green.shade600,fontSize: 10),)
                        ],
                      ),
                      onTap: (){
                        _showTicketDialog(data[index]);
                      },
                    ),
                  );
                  },
                itemCount: data.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
              )
            ],
          );
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
                  Container(
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
                  Container(
                    height: height * 0.3,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("Date",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                                SizedBox(height: 2,),
                                Text(data.eventData.date,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text("Venue",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                                SizedBox(height: 2,),
                                Text(data.eventData.date,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Column(
                              children: [
                                Text("Time",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                                SizedBox(height: 2,),
                                Text(data.eventData.time,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Text("Seat",style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12),),
                                SizedBox(height: 2,),
                                Text(data.seat.toString(),style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.01,),
                        DottedLine(dashColor: Colors.black.withOpacity(0.25), ),
                        SizedBox(height: height * 0.01,),
                        SizedBox(
                          height: height * 0.15,
                          child: SfBarcodeGenerator(
                            value: data.qrCode,
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
}
