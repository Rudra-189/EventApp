import 'package:event_project_01/views/User/seeMore/seeMoreControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../App_Resources/App_Screen_Size.dart';
import '../../../routes/appRoutesName.dart';

class seeMoreScreen extends StatefulWidget {
  const seeMoreScreen({super.key});

  @override
  State<seeMoreScreen> createState() => _seeMoreScreenState();
}

class _seeMoreScreenState extends State<seeMoreScreen> {

  final seeMoreControler controler = Get.put(seeMoreControler());

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),
        ),
        title: Text("EVENTS",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final data = controler.event;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  ListView.builder(itemBuilder:(context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(
                          appRoutesName.eventDetailScreen,
                          arguments: {
                            'id': data[index].id,
                            'category':data[index].category
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 20),
                        height: height * 0.360,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.09),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.09),
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(image: NetworkImage(data[index].img,),fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(data[index].title,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: width * 0.5,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                                          Text(DateFormat(' MM/dd/yyyy').format(data[index].date),style: TextStyle(color: Colors.white,fontSize: 10),),
                                          SizedBox(width: 5,),
                                          Icon(Icons.timer_outlined,color: Colors.green.shade600,size: 16,),
                                          Text(" "+DateFormat('hh:mm a').format(data[index].date),style: TextStyle(color: Colors.white,fontSize: 10))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,color: Colors.green.shade600,size: 16,),
                                          Expanded(child: Text(" "+data[index].location,style: TextStyle(color: Colors.white,fontSize: 10,overflow: TextOverflow.ellipsis))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border(
                                          top: BorderSide(color: Colors.white.withOpacity(0.2),width: 1),
                                          bottom: BorderSide(color: Colors.white.withOpacity(0.2),width: 1),
                                          left: BorderSide(color: Colors.white.withOpacity(0.2),width: 1),
                                          right: BorderSide(color: Colors.white.withOpacity(0.2),width: 1),
                                        ),
                                      ),
                                      child: Center(
                                        child:Icon(Icons.bookmark_border,color: Colors.white.withOpacity(0.5),size: 18,),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(
                                      height: 30,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade600,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(child: Text("JOIN NOW",style: TextStyle(color: Colors.white,fontSize: 12),)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  )
                ],
              ),
            ),
          );
        }
      },),
    );
  }
}
