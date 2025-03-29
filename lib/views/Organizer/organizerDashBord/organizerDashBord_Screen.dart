
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/views/Organizer/organizerDashBord/organizerDashBordControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../../../App_Resources/App_Color.dart';
import '../../../../App_Resources/App_Screen_Size.dart';

class organizerDashBordScreen extends StatefulWidget {
  const organizerDashBordScreen({super.key});

  @override
  State<organizerDashBordScreen> createState() => _organizerDashBordScreenState();
}

class _organizerDashBordScreenState extends State<organizerDashBordScreen> {

  organizerDashBordControler controler = Get.put(organizerDashBordControler());

  @override
  void initState() {
    super.initState();
    controler.getMyEvent();
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: AppColor.primaryColour,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green.shade600,
          title: Text("ORGANIZER",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: ()async{
                _showBottomSheet(context);
              },
              child: Icon(Icons.qr_code_scanner,color: Colors.white,size: 18,),
            ),
            SizedBox(width: 15,)
          ],
        ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: height * 0.15,
                      padding: EdgeInsets.symmetric(horizontal: height * 0.05),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.airplane_ticket,color: Colors.green.shade600,size: 18,),
                                Text("Total Tickets",style: TextStyle(color: Colors.white,fontSize: 12),),
                                SizedBox(height: 10,),
                                Text("${controler.ticketCount.value}",style: TextStyle(color: Colors.white,fontSize: 10),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cancel,color: Colors.red.shade600,size: 18,),
                                Text("Canceled Tickets",style: TextStyle(color: Colors.white,fontSize: 12),),
                                SizedBox(height: 10,),
                                Text("${controler.canceledTicketCount.value}",style: TextStyle(color: Colors.white,fontSize: 10),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.currency_rupee,color: Colors.green.shade600,size: 16,),
                                Text("Total Earnings",style: TextStyle(color: Colors.white,fontSize: 12),),
                                SizedBox(height: 10,),
                                Text("${controler.earningCount.value} Rs",style: TextStyle(color: Colors.green.shade600,fontSize: 10),),
                              ],
                            ),
                          ],
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
                        Get.toNamed(appRoutesName.addEventScreen);
                        // Navigator.push(context,MaterialPageRoute(builder: (context) => addEventScreen(),));
                      },
                      child: Container(
                        height: height * 0.145,
                        width: height * 0.145,
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
                        height: height * 0.145,
                        width: height * 0.145,
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
                        height: height * 0.145,
                        width: height * 0.145,
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
                        height: height * 0.145,
                        width: height * 0.145,
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
                        height: height * 0.145,
                        width: height * 0.145,
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
                        height: height * 0.145,
                        width: height * 0.145,
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
          );
        }
      },)
    );
  }
  void _showBottomSheet(BuildContext context) {
    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
            ),
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 5,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(3)
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("SELECT EVENT",style: TextStyle(color: Colors.black,fontSize: 14),),
                  ListView.builder(
                    itemBuilder: (context, index) {
                      final data = controler.myEvent;
                    return GestureDetector(
                      onTap: (){
                        controler.scanBarcode(context,data[index].id);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child:  ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: Image.network(
                                data[index].img,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(data[index].title,style: TextStyle(color: Colors.white,fontSize: 16,overflow:TextOverflow.ellipsis),) ,
                          subtitle: Row(
                            children: [
                              Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                              Text(DateFormat('MM/dd/yyyy').format(data[index].date),style: TextStyle(color: Colors.white,fontSize: 10),),
                              SizedBox(width: 5,),
                              Icon(Icons.timer_outlined,color: Colors.green.shade600,size: 16,),
                              Text( DateFormat('hh:mm a').format(data[index].date),style: TextStyle(color: Colors.white,fontSize: 10),),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                    itemCount: controler.myEvent.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
