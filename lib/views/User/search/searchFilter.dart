import 'package:event_project_01/views/User/search/searchControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../App_Resources/App_Screen_Size.dart';


void showFilterBottomSheet(BuildContext context) {
  final searchControler controler = Get.find<searchControler>();

  List category = [
    {
      "name" : "Sports",
      "icon": Icon(Icons.sports_baseball,color: Colors.white,),
    },
    {
      "name" : "Music",
      "icon": Icon(Icons.music_note,color: Colors.white,),
    },
    {
      "name" : "Art",
      "icon": Icon(Icons.sports_martial_arts,color: Colors.white,),
    },
    {
      "name" : "Food",
      "icon": Icon(Icons.food_bank_outlined,color: Colors.white,),
    },
    {
      "name" : "Business",
      "icon": Icon(Icons.business,color: Colors.white,),
    },
    {
      "name" : "Design",
      "icon": Icon(Icons.design_services,color: Colors.white,),
    },
  ];

  List<String> timeFilters = ["Today", "Tomorrow", "This Week"];

  final height = AppScreenSize.height(context);
  final width = AppScreenSize.width(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: height * 0.6,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 75,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(3)
              ),
            ),
            SizedBox(height: height * 0.025,),
            Obx(() {
              return SizedBox(
                height: height * 0.1,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    bool isSelected = controler.selectedCategories.contains(category[index]["name"]);
                    return GestureDetector(
                      onTap: (){
                        if (isSelected) {
                          controler.selectedCategories.remove(category[index]["name"]);
                        } else {
                          controler.selectedCategories.add(category[index]["name"]);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: controler.selectedCategories.contains(category[index]["name"]) ? Colors.green.shade600 :Colors.black.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: category[index]["icon"],
                              ),
                            ),
                            Text(category[index]["name"],style: TextStyle(color: Colors.black,fontSize: 12),)
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: category.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                ),
              );
            },),
            SizedBox(height: height * 0.025,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text("Time & Date",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SizedBox(height: height * 0.02,),
            Obx(() {
              return ListView.builder(itemBuilder: (context, index) {
                String time = timeFilters[index];
                bool isSelected = controler.selectedTimeFilter.value == time;
                return GestureDetector(
                  onTap: (){
                    controler.selectedTimeFilter.value = isSelected ? "" : time;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: isSelected ? Colors.green.shade600:null,
                        border: isSelected ? null : Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          left: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          right: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                        )
                    ),
                    child: Center(
                      child: Text(timeFilters[index],style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 1),),
                    ),
                  ),
                );
              },
                scrollDirection: Axis.horizontal,
                itemCount: timeFilters.length,
                shrinkWrap: true,
              );
            },),
          ],
        ),
      );
    },
  );
}
