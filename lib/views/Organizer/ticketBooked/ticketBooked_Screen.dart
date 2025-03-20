import 'package:event_project_01/views/Organizer/ticketBooked/ticketBookingControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../App_Resources/App_Screen_Size.dart';

class ticketBookedScreen extends StatefulWidget {
  ticketBookedScreen({super.key});

  @override
  State<ticketBookedScreen> createState() => _ticketBookedScreenState();
}

class _ticketBookedScreenState extends State<ticketBookedScreen> {

  ticketBookedControler controler = Get.put(ticketBookedControler());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.back();
            // Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),
        ),
        backgroundColor: Colors.green.shade600,
        title: Text("TICKET BOOKING",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 1),),
        centerTitle: true,
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final data = controler.myEventTickets;
          if(data.isEmpty){
            return Center(child: Text("No Ticket Found.",style: TextStyle(color: Colors.white,fontSize: 12),));
          }else {
            return SingleChildScrollView(
              child: ListView.builder(itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors
                        .transparent),
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      leading: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(15)),
                          child: Image.network(
                            data[index].eventData.img,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(data[index].eventData.title, style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),),
                      subtitle: Text(data[index].id, style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 12),),
                      iconColor: Colors.green.shade600,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("UserId : ", style: TextStyle(
                                    color: Colors.white, fontSize: 14),),
                                SizedBox(height: 5,),
                                Text("seats : ", style: TextStyle(
                                    color: Colors.white, fontSize: 14),),
                                SizedBox(height: 5,),
                                Text("type : ", style: TextStyle(
                                    color: Colors.white, fontSize: 14),),
                                SizedBox(height: 5,),
                                Text("status : ", style: TextStyle(
                                    color: Colors.white, fontSize: 14),),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index].userId, style: TextStyle(
                                    color: Colors.white, fontSize: 14),),
                                SizedBox(height: 5,),
                                Text(data[index].seat.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),),
                                SizedBox(height: 5,),
                                Text(data[index].type, style: TextStyle(
                                    color: Colors.white, fontSize: 14),),
                                SizedBox(height: 5,),
                                Text(data[index].status, style: TextStyle(
                                    color: Colors.white, fontSize: 14),),
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
              ),
            );
          }
        }
      },)
    );
  }
}
