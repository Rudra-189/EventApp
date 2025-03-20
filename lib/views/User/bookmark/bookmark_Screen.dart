import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:event_project_01/views/User/bookmark/bookmarkControler.dart';
import 'package:event_project_01/views/loaderControler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../App_Resources/App_Screen_Size.dart';
import '../../../routes/appRoutesName.dart';

class bookmarkScreen extends StatefulWidget {
  const bookmarkScreen({super.key});

  @override
  State<bookmarkScreen> createState() => _bookmarkScreenState();
}

class _bookmarkScreenState extends State<bookmarkScreen> {

  final bookmarkControler controler = Get.put(bookmarkControler());
  final loaderControler loader = Get.put(loaderControler());

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
          child: Icon(Icons.arrow_back,size: 18,color: Colors.white,),
        ),
        title: Text("BOOKMARK",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final data = controler.bookmarks;
          if(data.isEmpty){
            return Center(child: Text("No Bookmark Found.",style: TextStyle(color: Colors.white,fontSize: 12),));
          }else{
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(
                          appRoutesName.eventDetailScreen,
                          arguments: {
                            'id': data[index].id,
                            'category':data[index].category
                          },
                        );
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => eventDetailScreen(id: categoryData[index].id, category: categoryData[index].category,),));
                      },
                      child: Container(
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
                          trailing: GestureDetector(
                            onTap: (){
                              removebookmark(data[index].id);
                            },
                            child: Icon(Icons.delete_outline,color: Colors.red,size: 18,),
                          ),
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
  void removebookmark(String id)async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseReference databaseRef = FirebaseDatabase.instance.ref("users/$uid/bookmark/$id");
    try {
      loader.startLoading();
      await databaseRef.remove().then((value) {
        showSnackBar.message(context, "Remove from Bookmark");
      },); // Remove the event ID from bookmarks
    } catch (error) {
      print("Error removing bookmark: $error");
    }finally{
      loader.stopLoading();
      controler.fetchBookmarkedEvents();
    }
  }
}
