import 'package:event_project_01/App_Resources/App_Category.dart';
import 'package:event_project_01/views/User/search/searchControler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../App_Resources/App_Color.dart';
import '../../../App_Resources/App_Screen_Size.dart';


List time = ['Today', 'Tomorrow', 'This week'];

void showFilterSheet(BuildContext context){

  searchControler controler = Get.put(searchControler());

  final height = AppScreenSize.height(context);
  final width = AppScreenSize.width(context);

  showModalBottomSheet(context: context, builder: (context) {

    return Container(
      height: height * 0.45,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Column(

        children: [
          SizedBox(height: height * 0.01,),
          Container(
            height: 5,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.75),
              borderRadius: BorderRadius.circular(3)
            ),
          ),
          SizedBox(height: height * 0.02,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text("Category",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,letterSpacing: 1),),
              ],
            ),
          ),
          SizedBox(height: height * 0.02,),
          SizedBox(
            height: 100,
            child: ListView.builder(itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: (){
                          controler.toggleCategory(AppCategory.category[index]['name']);
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: controler.selectedCategories.contains(AppCategory.category[index]['name']) ? Colors.green.shade600 : Colors.black.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: Center(
                            child: AppCategory.category[index]['img'],
                          ),
                        ),
                      );
                    },),
                    Text(AppCategory.category[index]['name'],style: TextStyle(fontSize: 12),)
                  ],
                ),
              );
            },
              scrollDirection: Axis.horizontal,
              itemCount: AppCategory.category.length,
              shrinkWrap: true,
            ),
          ),
          SizedBox(height: height * 0.02,),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Row(
          //     children: [
          //       Text("Time & Date",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,letterSpacing: 1),),
          //     ],
          //   ),
          // ),
          // SizedBox(height: height * 0.02,),
          // Row(
          //   children: [
          //     SizedBox(
          //       height: 50,
          //       child: ListView.builder(itemBuilder: (context, index) {
          //         return Obx(() {
          //           return GestureDetector(
          //             onTap: (){
          //               controler.selectedTime.value = time[index];
          //             },
          //             child: Container(
          //               margin: EdgeInsets.only(left: 10),
          //               padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          //               decoration: BoxDecoration(
          //                   color: controler.selectedTime.contains(time[index]) ? Colors.green.shade600 : Colors.black.withOpacity(0.25),
          //                   borderRadius: BorderRadius.circular(15)
          //               ),
          //               child: Center(
          //                 child: Text(time[index],style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
          //               ),
          //             ),
          //           );
          //         },);
          //       },
          //         itemCount: time.length,
          //         scrollDirection: Axis.horizontal,
          //         shrinkWrap: true,
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(height: height * 0.015,),
          // Padding(
          //   padding: EdgeInsets.only(right: width * 0.3,left: 10),
          //   child: TextFormField(
          //     cursorColor: Colors.black,
          //     style: TextStyle(color:Colors.black),
          //     readOnly: true,
          //     decoration: InputDecoration(
          //       hintText: ' Choose from calender',
          //       filled: true,
          //       fillColor: AppColor.textFiledBgColor,
          //       contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
          //       hintStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 14),
          //       enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(15),
          //           borderSide: BorderSide(
          //               color: Colors.black,
          //               width: 0.25
          //           )
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(15),
          //           borderSide: BorderSide(
          //             color: AppColor.secondaryColour,
          //             width: 0.5,
          //           )
          //       ),
          //       prefixIcon: Icon(Icons.date_range,color: Colors.green.shade600,size: 20,),
          //       suffixIcon: Icon(Icons.keyboard_arrow_right,color: Colors.green.shade600,size: 20,)
          //     ),
          //     controller: controler.textController,
          //     onTap: (){
          //       controler.pickDate(context);
          //     },
          //   ),
          // ),
          // SizedBox(height: height * 0.025,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select price range",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,letterSpacing: 1),),
                Obx(() {
                  return Text('₹${controler.priceRange.value.start.toStringAsFixed(2)} - ₹${controler.priceRange.value.end.toStringAsFixed(2)}',style: TextStyle(color: Colors.green.shade600,fontSize: 14),);
                },)
              ],
            ),
          ),
          SizedBox(height: height * 0.015,),
          Obx(() => RangeSlider(
            activeColor: Colors.green.shade600,
            inactiveColor: Colors.black.withOpacity(0.25),
            values: controler.priceRange.value,
            min: 100,
            max: 2000,
            divisions: 19,
            labels: RangeLabels(
              '\$${controler.priceRange.value.start.round()}',
              '\$${controler.priceRange.value.end.round()}',
            ),
            onChanged: (RangeValues values) {
              controler.priceRange.value = values;
            },
          )),
          SizedBox(height: height * 0.025,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  controler.resetFilters();
                  Get.back();
                },
                child: Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          left: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          right: BorderSide(color: Colors.black.withOpacity(0.1),width: 1)
                      ),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text("RESET",style: TextStyle(color: Colors.black,fontSize: 14,letterSpacing: 1,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  controler.applyFilters();
                  Get.back();
                },
                child: Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade600,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text("Apply",style: TextStyle(color: Colors.white,fontSize: 14,letterSpacing: 1,fontWeight: FontWeight.bold),),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: height * 0.01,),
        ],
      ),
    );
  },
      isScrollControlled: true
  );
}