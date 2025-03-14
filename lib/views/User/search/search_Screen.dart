
import 'package:event_project_01/views/User/search/searchControler.dart';
import 'package:event_project_01/views/User/search/searchFilter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../App_Resources/App_Screen_Size.dart';
import '../../../routes/appRoutesName.dart';


class searchScreen extends StatefulWidget {
  const searchScreen({super.key});

  @override
  State<searchScreen> createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {

  TextEditingController searchController = TextEditingController();

  final searchControler controler = Get.put(searchControler());


  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

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
        title: Text("SEARCH",style: TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: TextFormField(
                      controller: searchController,
                      cursorColor: Colors.white,
                      style: TextStyle(color:Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search",
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.09),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 0.25
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              color: Colors.green.shade600,
                              width: 0.5,
                            )
                        ),
                        prefixIcon: Icon(Icons.search,color: Colors.green.shade600,size: 20,),
                      ),
                      onChanged: (value) => controler.searchEvent(searchController.text.toString()),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      showFilterSheet(context);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(11)
                      ),
                      child: Icon(Icons.filter_list,color: Colors.green.shade600,size: 20,),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Obx(() {
              if(controler.isLoading.value){
                return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
              }else{
                if(controler.filteredList.isEmpty){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No Data Found",style: TextStyle(color: Colors.green.shade600,fontSize: 14),),
                    ],
                  );
                }else{
                  return ListView.builder(itemBuilder: (context, index) {
                    final data = controler.filteredList[index];
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed(
                          appRoutesName.eventDetailScreen,
                          arguments: {
                            'id': data.id,
                            'category':data.category
                          },
                        );
                      },
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.09),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(data.img,height: 75,width: 75,fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.title,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.white,fontSize: 16,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold,),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: width * 0.55,
                                    child: Row(
                                      children: [
                                        Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                                        Text(DateFormat('MM/dd/yyyy').format(data.date),style: TextStyle(color: Colors.white,fontSize: 10),),
                                        SizedBox(width: 5,),
                                        Icon(Icons.location_on,color: Colors.green.shade600,size: 16,),
                                        Expanded(
                                          child: Text(data.location,style: TextStyle(color: Colors.white,fontSize: 10,overflow: TextOverflow.ellipsis),),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                    itemCount: controler.filteredList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  );
                }
              }
            },)
          ],
        ),
      )
    );
  }
}
