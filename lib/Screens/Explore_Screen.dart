import 'package:event_project_01/App_Resources/App_Color.dart';
import 'package:event_project_01/App_Resources/App_Icon.dart';
import 'package:flutter/material.dart';

import '../App_Resources/App_Screen_Size.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {

    List<Map<String,dynamic>>cat = [
      {
        "img" : AppIcon.sportsIcon,
        "name" : "Sports",
        "color" : Colors.red
      },
      {
        "img" : AppIcon.musicIcon,
        "name" : "Music",
        "color" : Colors.orange
      },
      {
        "img" : AppIcon.foodIcon,
        "name" : "Food",
        "color" : Colors.green
      },
      {
        "img" : AppIcon.phoneIcon,
        "name" : "Phone",
        "color" : Colors.lightBlueAccent
      }
    ];

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: AppColor.primaryColour,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: height * 0.03,),
            Container(
              height: height * 0.065,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColor.secondaryColour.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.search,),
                title: Text("Search"),
              ),
            ),
            SizedBox(height: height * 0.03,),
            Container(
              height: height * 0.05,
              width: width,
              child:ListView.builder(itemBuilder: (context, index) {
                return Container(
                  height: height * 0.05,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: cat[index]["color"],
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cat[index]['img'],
                      SizedBox(width: 5,),
                      Text(cat[index]['name'].toString()),
                    ],
                  ),
                );
              },
                scrollDirection: Axis.horizontal,
                itemCount: cat.length,
              ),
            ),
            SizedBox(height: height * 0.04,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Upcoming Events",style: TextStyle(fontSize: 16),),
                  Text("See All",style: TextStyle(color: AppColor.secondaryColour,fontSize: 15),),
                ],
              ),
            ),
            Container(
              height: height * 0.32,
              child: ListView.builder(itemBuilder: (context, index) {
                return Container(
                  height: height * 0.32,
                  width: width * 0.7,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColour.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: height * 0.175,
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      Text("International Band Mu...",style: TextStyle(fontSize: 18),)
                      
                    ],
                  ),
                );
              },
                scrollDirection: Axis.horizontal,
              itemCount: 3,
              ),
            )
          ],
        ),
      )
    );
  }
}
