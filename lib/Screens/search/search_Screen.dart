import 'package:event_project_01/Screens/search/searchControler.dart';
import 'package:event_project_01/utils/searchFilter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class search_Page extends StatefulWidget {
  const search_Page({super.key});

  @override
  State<search_Page> createState() => _search_PageState();
}

class _search_PageState extends State<search_Page> {

  TextEditingController searchController = TextEditingController();

  final searchControler controler = Get.put(searchControler());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
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
                  Container(
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
                      showFilterBottomSheet();
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
              if(controler.filteredList.isEmpty){
                return Center(child: Text("No Data Found"));
              }else{
                return ListView.builder(itemBuilder: (context, index) {
                  final data = controler.filteredList[index];
                  return Container(
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
                          child: Image.network(data.img,height: 75,width: 75,fit: BoxFit.cover,),
                          borderRadius: BorderRadius.circular(15),
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
                              Row(
                                children: [
                                  Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                                  Text(data.date,style: TextStyle(color: Colors.white,fontSize: 10),),
                                  SizedBox(width: 5,),
                                  Icon(Icons.location_on,color: Colors.green.shade600,size: 16,),
                                  Expanded(
                                    child: Text(data.location,style: TextStyle(color: Colors.white,fontSize: 10,overflow: TextOverflow.ellipsis),),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                  itemCount: controler.filteredList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                );
              }
            },)
          ],
        ),
      )
    );
  }
  Future showFilterBottomSheet(){
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => searchFilter(),
    );
  }
}
