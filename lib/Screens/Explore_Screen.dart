import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_project_01/App_Resources/App_Color.dart';
import 'package:event_project_01/App_Resources/App_Icon.dart';
import 'package:event_project_01/App_Resources/App_Style.dart';
import 'package:event_project_01/Screens/eventDetail_Screen.dart';
import 'package:event_project_01/Screens/search_Screen.dart';
import 'package:flutter/material.dart';
import '../App_Resources/App_Screen_Size.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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

  List Eventphoto = [
    'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGV2ZW50fGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGV2ZW50fGVufDB8fDB8fHww',
    'https://media.istockphoto.com/id/471906412/photo/beautiful-table-setting-for-an-wedding-reception-or-an-event.jpg?s=612x612&w=0&k=20&c=knlIBspy-ZKuQV7bUVr_eclJmyC24ShNAva_Jh9Rwfc=',
    'https://media.istockphoto.com/id/1352398824/photo/birthday-cake-on-a-background-balloons-party-decor-copy-space-trendy-cake-delicious-wedding.jpg?s=612x612&w=0&k=20&c=T4wlEs_JmC2XOMsCBSzTCBmp7bKRHbCkwjs4RlZpPjU=',
    'https://media.istockphoto.com/id/2045556384/video/the-waiter-places-the-finished-sandwiches-on-the-table-with-treats-catering.jpg?s=640x640&k=20&c=_D__UWIFNJuTcJ7CJXTy-94q3qPNYOXefcI3uaDEA8w=',
  ];

  var selectedCategory = 0;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.02,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => search_Page(),));
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
            Container(
              height: height * 0.345,
              child: ListView.builder(itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => eventDetail_Page(img: Eventphoto[index]),));
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
                            image: DecorationImage(image: NetworkImage(Eventphoto[index],),fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(height: height * 0.01,),
                        Text("This is my Event hello i am rudra this event is",style: AppStyle.overFlowTextStyle,),
                        SizedBox(height: height * 0.01,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.date_range,color: AppColor.secondaryColour,size: 18,),
                                      Text("12-15 october,25",style:TextStyle(fontSize: 11,color: AppColor.textColor),)
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.01,),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_pin,color: AppColor.secondaryColour,size: 18,),
                                      Text("abc,water park,",style:TextStyle(fontSize: 11,color: AppColor.textColor,overflow: TextOverflow.ellipsis),)
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
                itemCount: 5,
                scrollDirection: Axis.horizontal,
              ),
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
            Container(
              height: 45,
              child: ListView.builder(itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedCategory = index;
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
                      child: Image.network(Eventphoto[index],height: 75,width: 75,fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:250,
                          child: Text("Event Name with other info. of organizer",
                            style: TextStyle(
                                color: Colors.white,fontSize: 15,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                            Text("12-15 october,25",style: TextStyle(color: Colors.white,fontSize: 10),),
                            Icon(Icons.location_on,color: Colors.green.shade600,size: 16,),
                            Text("Abc,water park",style: TextStyle(color: Colors.white,fontSize: 10),)
                          ],
                        ),
                        Row(
                          children: [

                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
              itemCount: Eventphoto.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}

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