import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../App_Resources/App_Screen_Size.dart';
import '../Screens/search/searchControler.dart';

class searchFilter extends StatefulWidget {
  const searchFilter({super.key});

  @override
  State<searchFilter> createState() => _searchFilterState();
}

class _searchFilterState extends State<searchFilter> {

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

  List selectedCategory = [];

  List selectedTimeDate = [];

  var Date;

  RangeValues _priceRange = const RangeValues(100, 1000);

  final searchControler controler = Get.put(searchControler());

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

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
          Container(
            height: height * 0.1,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      if(selectedCategory.contains(category[index]["name"])){
                        selectedCategory.remove(category[index]["name"]);
                      }else{
                        selectedCategory.add(category[index]["name"]);
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: selectedCategory.contains(category[index]["name"]) ? Colors.green.shade600 :Colors.black.withOpacity(0.25),
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
          ),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(selectedTimeDate.contains("Today")){
                        selectedTimeDate.remove("Today");
                      }else{
                        selectedTimeDate.add("Today");
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selectedTimeDate.contains("Today") ? Colors.green.shade600:null,
                        border: selectedTimeDate.contains("Today") ? null : Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          left: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          right: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                        )
                    ),
                    child: Center(
                      child: Text("Today",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 1),),
                    ),
                  ),
                ),
                SizedBox(width: width* 0.02,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(selectedTimeDate.contains("Tomorrow")){
                        selectedTimeDate.remove("Tomorrow");
                      }else{
                        selectedTimeDate.add("Tomorrow");
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selectedTimeDate.contains("Tomorrow") ? Colors.green.shade600:null,
                        border: selectedTimeDate.contains("Tomorrow") ? null : Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          left: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          right: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                        )
                    ),
                    child: Center(
                      child: Text("Tomorrow",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 1),),
                    ),
                  ),
                ),
                SizedBox(width: width* 0.02,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(selectedTimeDate.contains("This week")){
                        selectedTimeDate.remove("This week");
                      }else{
                        selectedTimeDate.add("This week");
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selectedTimeDate.contains("This week") ? Colors.green.shade600:null,
                        border: selectedTimeDate.contains("This week") ? null : Border(
                          top: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          left: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          right: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                        )
                    ),
                    child: Center(
                      child: Text("This week",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 1),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.025,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    selectDate();
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                            top: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                            bottom: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                            left: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                            right: BorderSide(color: Colors.black.withOpacity(0.1),width: 1),
                          )
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.date_range,color: Colors.green.shade600,size: 18,),
                          SizedBox(width: width * 0.02,),
                          Text("Choose from calender",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 1),)
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height * 0.025,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select price range",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                Text("₹${_priceRange.start.round()} - ₹${_priceRange.end.round()}",style: TextStyle(color: Colors.green.shade600,fontSize: 14,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          SizedBox(height: height * 0.025,),
          RangeSlider(
            values: _priceRange,
            labels: RangeLabels(_priceRange.start.round().toString(), _priceRange.end.round().toString()),
            divisions: 9,
            activeColor: Colors.green.shade600,
            inactiveColor: Colors.black.withOpacity(0.25),
            onChanged: (value) {
              setState(() {
                _priceRange = value;
              });
            },
            min: 100,
            max: 1000,
          ),
          Expanded(child: SizedBox()),
          Container(
            height: height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedCategory.clear();
                      selectedTimeDate.clear();
                      Date=null;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border(
                        top: BorderSide(color: Colors.black.withOpacity(0.25),width: 1),
                        bottom: BorderSide(color: Colors.black.withOpacity(0.25),width: 1),
                        left: BorderSide(color: Colors.black.withOpacity(0.25),width: 1),
                        right: BorderSide(color: Colors.black.withOpacity(0.25),width: 1),
                      )
                    ),
                    child: Center(
                      child: Text("RESET",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 1),),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                    print(selectedCategory);
                    print(selectedTimeDate);
                    print(Date);
                    print(_priceRange);

                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green.shade600
                    ),
                    child: Center(
                      child: Text("APPLY",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 1),),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Future selectDate()async{
    DateTime? pic = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2027),
    );
    setState(() {
      if(pic != null){
        Date = pic.toString().split(" ")[0];
      }
    });
  }
}
