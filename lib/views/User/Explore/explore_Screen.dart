import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../App_Resources/App_Color.dart';
import '../../../App_Resources/App_Icon.dart';
import '../../../App_Resources/App_Screen_Size.dart';
import '../../../App_Resources/App_Style.dart';
import '../eventDetail/eventDetail_Screen.dart';
import '../search/search_Screen.dart';
import 'exploreControler.dart';

class exploreScreen extends StatefulWidget {
  const exploreScreen({super.key});

  @override
  State<exploreScreen> createState() => _exploreScreenState();
}

class _exploreScreenState extends State<exploreScreen> {
  List<Map<String,dynamic>>cat = [
    {
      "img" : AppIcon.sportsIcon,
      "name" : "Sport",
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
      "color" : Colors.blue
    },
    {
      "img" : Icon(Icons.format_paint,color: Colors.white,size: 22,),
      "name" : "Art",
      "color" : Colors.teal
    },
    {
      "img" : Icon(Icons.design_services,color: Colors.white,size: 22,),
      "name" : "Design",
      "color" : Colors.teal
    },
    {
      "img" : Icon(Icons.business,color: Colors.white,size: 22,),
      "name" : "Business",
      "color" : Colors.teal
    }
  ];

  var selectedCategory = 0;

  final exploreControler controler = Get.put(exploreControler());

  @override
  void initState() {
    super.initState();
    controler.fetchCategoryEvent(cat[selectedCategory]["name"]);
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: AppColor.primaryColour,
      appBar: AppBar(
        backgroundColor: AppColor.secondaryColour,
        leading: Icon(Icons.menu,color: Colors.white,),
        title: Text("Hi! Rudra",style: AppStyle.commonTextStyle,),
        centerTitle: true,
        elevation: 0,
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(Icons.notifications_none,color: Colors.white,),
            ),
          ),
          SizedBox(
            width: width * 0.05,
          )
        ],
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final upcomingData = controler.event;
          final categoryData = controler.categoryEvent;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.02,),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(appRoutesName.searchScreen);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => searchScreen(),));
                  },
                  child: Container(
                    height: height * 0.06,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.09),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: width * 0.05,),
                        Icon(Icons.search,color: Colors.white,),
                        SizedBox(width: width * 0.025,),
                        Text("Search",style: AppStyle.commonTextStyle,)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.035,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Upcoming Events",style: AppStyle.commonTextStyle,),
                      Text("See More",style: AppStyle.secondaryCommonTextStyle,)
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02 ,),
                SizedBox(
                    height: height * 0.345,
                    child: ListView.builder(itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed(
                            appRoutesName.eventDetailScreen,
                            arguments: {
                              'id': upcomingData[index].id,
                              'category':upcomingData[index].category
                            },
                          );
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => eventDetailScreen(id: upcomingData[index].id, category: upcomingData[index].category,),));
                        },
                        child: Container(
                          //height: height * 0.345,
                          width: width * 0.7,
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: height * 0.2,
                                width: width * 0.65,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  //color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(image: NetworkImage(upcomingData[index].img,),fit: BoxFit.cover),
                                ),
                              ),
                              SizedBox(height: height * 0.01,),
                              Text(upcomingData[index].title,style: AppStyle.overFlowTextStyle,),
                              SizedBox(height: height * 0.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.date_range,color: AppColor.secondaryColour,size: 18,),
                                              Text(DateFormat('MM/dd/yyyy').format(upcomingData[index].date),style:TextStyle(fontSize: 11,color: AppColor.textColor),)
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: height * 0.01,),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.location_pin,color: AppColor.secondaryColour,size: 18,),
                                            SizedBox(
                                              width: width * 0.3,
                                              child:Text(upcomingData[index].location,style:TextStyle(fontSize: 11,color: AppColor.textColor,overflow: TextOverflow.ellipsis),),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade600,
                                        borderRadius: BorderRadius.circular(11)
                                    ),
                                    child: Center(child: Text("JOIN NOW",style: TextStyle(color: Colors.white,fontSize: 12),)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                      itemCount: upcomingData.length,
                      scrollDirection: Axis.horizontal,
                    )
                ),
                SizedBox(height: height * 0.035,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Choose By Category",style: AppStyle.commonTextStyle,),
                      //Text("See More",style: AppStyle.secondaryCommonTextStyle,)
                    ],
                  ),
                ),
                SizedBox(height: height * 0.015,),
                SizedBox(
                  height: 45,
                  child: ListView.builder(itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedCategory = index;
                          controler.fetchCategoryEvent(cat[selectedCategory]["name"]);
                        });
                      },
                      child: Container(
                        height: 45,
                        margin: EdgeInsets.only(left: width*0.025),
                        padding: EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 20),
                        decoration: BoxDecoration(
                            color: selectedCategory == index ? Colors.green.shade600:Colors.white.withOpacity(0.09),
                            borderRadius: BorderRadius.circular(35)
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: cat[index]["img"],
                            ),
                            SizedBox(width: 10,),
                            Text(cat[index]["name"],style: selectedCategory == index ?AppStyle.commonTextStyle:AppStyle.secondaryCommonTextStyle,),
                          ],
                        ),
                      ),
                    );
                  },
                    itemCount: cat.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(height: height * 0.03,),
                ListView.builder(itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(
                        appRoutesName.eventDetailScreen,
                        arguments: {
                          'id': categoryData[index].id,
                          'category':categoryData[index].category
                        },
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => eventDetailScreen(id: categoryData[index].id, category: categoryData[index].category,),));
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
                            child: Image.network(categoryData[index].img,height: 75,width: 75,fit: BoxFit.cover,),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(categoryData[index].title,
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
                                      Text(DateFormat('MM/dd/yyyy').format(categoryData[index].date),style: TextStyle(color: Colors.white,fontSize: 10),),
                                      SizedBox(width: 5,),
                                      Icon(Icons.location_on,color: Colors.green.shade600,size: 16,),
                                      Expanded(child: Text(categoryData[index].location,style: TextStyle(color: Colors.white,fontSize: 10,overflow: TextOverflow.ellipsis),))
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
                  itemCount: categoryData.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                )
              ],
            ),
          );
        }
      },),
    );
  }
}

//Future showDrawer()async{
//     return Drawer(
//       child: ListView(
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(
//                 color: Colors.green.shade600
//             ),
//             child: UserAccountsDrawerHeader(
//               accountName: Text("Mohan"),
//               accountEmail: Text("mohan@gmail.com"),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//Container(
//               height: height * 0.125,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: height * 0.1,
//                     decoration: BoxDecoration(
//                         color: Colors.green.shade600,
//                         borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(70, 40),bottomLeft: Radius.elliptical(70, 40))
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: height * 0.06,
//                           margin: EdgeInsets.symmetric(horizontal: 10),
//                           decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.09),
//                               borderRadius: BorderRadius.circular(15)
//                           ),
//                           child: Row(
//                             children: [
//                               SizedBox(width: width * 0.05,),
//                               Icon(Icons.search,color: Colors.white,),
//                               SizedBox(width: width * 0.025,),
//                               Text("Search",style: AppStyle.commonTextStyle,)
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: height * 0.05,
//                       child: ListView.builder(itemBuilder: (context, index) {
//                         return Container(
//                           height: height * 0.05,
//                           width:width * 0.3,
//                           margin: EdgeInsets.only(left: width*0.025),
//                           decoration: BoxDecoration(
//                               color: cat[index]["color"],
//                               borderRadius: BorderRadius.circular(20)
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               cat[index]['img'],
//                               Text(cat[index]["name"],style: AppStyle.commonTextStyle,)
//                             ],
//                           ),
//                         );
//                       },
//                         itemCount: cat.length,
//                         scrollDirection: Axis.horizontal,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),



//CarouselSlider(
//                 items: Eventphoto.map((e) => Container(
//                   height: height * 0.375,
//                   width: width * 0.75,
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.09),
//                       //color: Colors.white,
//                       borderRadius: BorderRadius.circular(15)
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: height * 0.250,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(15),
//                           image: DecorationImage(
//                             image: NetworkImage(e.toString()),
//                             fit: BoxFit.cover
//                           )
//                         ),
//                       ),
//                       SizedBox(height: 10,),
//                       Expanded(child: Text("This Event is Orgenize by Rudra and i am orgenaizer of this event",style: TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis,fontSize: 16),)),
//                       Row(
//                         children: [
//                           Column(
//                             children: [
//                               SizedBox(
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.date_range,color: Colors.green.shade600,size: 18,),
//                                     Text("12-15 october,25",style: TextStyle(color: Colors.white,fontSize: 12),)
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.location_on,color: Colors.green.shade600,size: 18,),
//                                     Text("12-15 october,25",style: TextStyle(color: Colors.white,fontSize: 12),)
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),).toList(),
//                 options: CarouselOptions(
//                   height: height * 0.375,
//                   aspectRatio: 1,
//                   viewportFraction: 0.75,
//                   initialPage: 0,
//                   enableInfiniteScroll: true,
//                   reverse: false,
//                   autoPlay: true,
//                   autoPlayInterval: Duration(seconds: 3),
//                   autoPlayAnimationDuration: Duration(milliseconds: 800),
//                   autoPlayCurve: Curves.fastOutSlowIn,
//                   enlargeCenterPage: true,
//                   enlargeFactor: 0.3,
//                   // onPageChanged: callbackFunction,
//                   scrollDirection: Axis.horizontal,
//                 )
//             ),