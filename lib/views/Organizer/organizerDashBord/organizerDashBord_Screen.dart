
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/views/Organizer/myEvent/myEvent_Screen.dart';
import 'package:event_project_01/views/Organizer/organizerDashBord/organizerDashBordControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../../App_Resources/App_Color.dart';
import '../../../../App_Resources/App_Screen_Size.dart';
import '../organizerProfile_Screen.dart';
import '../addEvent/addEvent_Screen.dart';
import '../ticketBooked/ticketBooked_Screen.dart';

class organizerDashBordScreen extends StatefulWidget {
  const organizerDashBordScreen({super.key});

  @override
  State<organizerDashBordScreen> createState() => _organizerDashBordScreenState();
}

class _organizerDashBordScreenState extends State<organizerDashBordScreen> {

  organizerDashBordControler controler = Get.put(organizerDashBordControler());

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: AppColor.primaryColour,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(appRoutesName.addEventScreen);
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => addEventScreen(),));
                  },
                  child: Container(
                    height: 125,
                    width: 125,
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
                    height: 125,
                    width: 125,
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
                    showBottomSheet(context);
                  },
                  child: Container(
                    height: 125,
                    width: 125,
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
                Container(
                  height: 125,
                  width: 125,
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
                ),
              ],
            ),
            SizedBox(height: height * 0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(appRoutesName.organizerProfileScreen);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => organizerProfileScreen(),));
                  },
                  child: Container(
                    height: 125,
                    width: 125,
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
                Container(
                  height: 125,
                  width: 125,
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
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
  void showBottomSheet(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: height * 0.65,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.01,),
                Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(3)
                  ),
                ),
                SizedBox(height: height * 0.02,),
                Text("SELECT EVENT",style: TextStyle(color: Colors.black,fontSize: 14,letterSpacing: 1),),
                SizedBox(height: height * 0.02,),
                Obx(() {
                  final data = controler.myEvent;
                  return ListView.builder(itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
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
                        title: Text(data[index].title,style: TextStyle(color: Colors.black,fontSize: 16,overflow:TextOverflow.ellipsis),) ,
                        subtitle: Row(
                          children: [
                            Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                            Text(DateFormat('MM/dd/yyyy').format(data[index].date),style: TextStyle(color: Colors.black,fontSize: 10),),
                            SizedBox(width: 5,),
                            Icon(Icons.timer_outlined,color: Colors.green.shade600,size: 16,),
                            Text( DateFormat('hh:mm a').format(data[index].date),style: TextStyle(color: Colors.black,fontSize: 10),),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            VerticalDivider(
                              color: Colors.white,
                            ),
                            Text("BOOKING",style: TextStyle(color: Colors.green.shade600,fontSize: 10),),
                          ],
                        ),
                        onTap: (){
                          Get.back();
                          // Navigator.of(context).pop();
                          Get.toNamed(appRoutesName.ticketBookedScreen,arguments: data[index].id);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => ticketBookedScreen(id: data[index].id,),));
                        },
                      ),
                    );
                  },
                    itemCount: data.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  );
                },)
              ],
            ),
          ),
        );
      },
    );
  }
}
