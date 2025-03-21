import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/views/Organizer/myEvent/myEventControler.dart';
import 'package:event_project_01/views/Organizer/editEvent/editEvent_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class myEventScreen extends StatefulWidget {
  const myEventScreen({super.key});

  @override
  State<myEventScreen> createState() => _myEventScreenState();
}

class _myEventScreenState extends State<myEventScreen> {

  myEventControler controler = Get.put(myEventControler());

  @override
  void initState() {
    super.initState();
    controler.getMyEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),
        ),
        title: Text("MY EVENT",style: TextStyle(color: Colors.white,fontSize: 18),),
        backgroundColor: Colors.green.shade600,
        centerTitle: true,
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final data = controler.myEvent;
          if(data.isEmpty){
            return Center(child: Text("No Event Found.",style: TextStyle(color: Colors.white,fontSize: 12),));
          }else{
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
                      trailing: PopupMenuButton(
                        color: Colors.white,
                        itemBuilder: (context) =>[
                          PopupMenuItem(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.publish,color: Colors.green.shade600,size: 20,),
                                SizedBox(width: 10,),
                                Text("Publish",style: TextStyle(fontSize: 14),),
                              ],
                            ),
                            onTap: (){
                            },
                          ),
                          PopupMenuItem(
                            onTap: (){
                              Get.toNamed(appRoutesName.editEventScreen,arguments: data[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.edit,color: Colors.green.shade600,size: 20,),
                                SizedBox(width: 10,),
                                Text("update",style: TextStyle(fontSize: 14),),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: (){
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
                                        Icon(Icons.warning_amber_rounded,color: Colors.green.shade600,),
                                        SizedBox(width: 10,),
                                        Text('Delete Event',style: TextStyle(fontSize: 16),),
                                      ],
                                    ),
                                    content: Text('Do You Want Delete Event?'),
                                    actions: [
                                      GestureDetector(
                                        onTap:(){
                                          Get.back();
                                        },
                                        child: Text("Cancel",style: TextStyle(color: Colors.green.shade600),),
                                      ),
                                      SizedBox(width: 5,),
                                      GestureDetector(
                                        onTap:(){
                                          controler.deleteEvent(context,data[index].id);
                                          Get.back();
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(color: Colors.green.shade600),
                                          child: Center(child: Text("Ok",style: TextStyle(color: Colors.white),)),
                                        ),
                                      )
                                    ],

                                  );
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.delete_outline,color: Colors.green.shade600,size: 20,),
                                SizedBox(width: 10,),
                                Text("delete",style: TextStyle(fontSize: 14),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                  itemCount: data.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),

              ],
            );
          }
        }
      },),
    );
  }

}
