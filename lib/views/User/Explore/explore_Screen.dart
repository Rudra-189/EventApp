import 'package:event_project_01/App_Resources/App_Category.dart';
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/utils/coinBox.dart';
import 'package:event_project_01/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../App_Resources/App_Color.dart';
import '../../../App_Resources/App_Icon.dart';
import '../../../App_Resources/App_Screen_Size.dart';
import '../../../App_Resources/App_Style.dart';
import '../../../utils/coinSystem.dart';
import '../eventDetail/eventDetail_Screen.dart';
import '../search/search_Screen.dart';
import 'exploreControler.dart';

class exploreScreen extends StatefulWidget {
  const exploreScreen({super.key});

  @override
  State<exploreScreen> createState() => _exploreScreenState();
}

class _exploreScreenState extends State<exploreScreen> {

  var selectedCategory = 0;

  final exploreControler controler = Get.put(exploreControler());

  @override
  void initState() {
    super.initState();
    
    controler.fetchCategoryEvent(AppCategory.category[selectedCategory]["name"]);
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Obx(
      () {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final upcomingData = controler.upcomingEvent;
          final categoryData = controler.categoryEvent;

          if(controler.user.value == null){
           return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
          }else{
            return Scaffold(
                backgroundColor: AppColor.primaryColour,
                appBar: AppBar(
                  backgroundColor: AppColor.secondaryColour,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: controler.user.value!.photo.isEmpty ? Image.asset("assets/images/BG Event Era.png",color: Colors.white) : CircleAvatar(radius: 20,backgroundImage: NetworkImage(controler.user.value!.photo),),
                      )
                    ],
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hi Welcome",style: TextStyle(color: AppColor.textColor,fontWeight: FontWeight.w500,fontSize: 11),),
                      Text(controler.user.value!.name,style: TextStyle(color: AppColor.textColor,fontWeight: FontWeight.w500,fontSize: 15,letterSpacing: 2),),
                    ],
                  ),
                  actions:[
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(appRoutesName.coinHistoryScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        // color: Colors.black,
                        decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.white,width: 0.5),
                              left: BorderSide(color: Colors.white,width: 0.5),
                              right: BorderSide(color: Colors.white,width: 0.5),
                              bottom: BorderSide(color: Colors.white,width: 0.5),
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/images/coin.svg",height: 20,width: 20,),
                            SizedBox(width: 5,),
                            Obx(() {
                              return Text(controler.coins.toString() ?? '0',style: TextStyle(color: Colors.white,fontSize: 14),);
                            },)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10,)
                  ],
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.02,),
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(appRoutesName.searchScreen);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => searchScreen(),));
                        },
                        child: Container(
                          height: height * 0.065,
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
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(appRoutesName.seeMoreScreen);
                              },
                              child: Text("See More",style: AppStyle.secondaryCommonTextStyle,),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02 ,),
                      SizedBox(
                          height: height * 0.3325,
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
                                    Text(upcomingData[index].title,style: TextStyle(color: AppColor.textColor,fontWeight: FontWeight.bold,fontSize: 15,overflow: TextOverflow.ellipsis),),
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
                                                  Text(DateFormat(' MM/dd/yyyy').format(upcomingData[index].date),style:TextStyle(fontSize: 11,color: AppColor.textColor),)
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
                                                    child:Text(" "+upcomingData[index].location,style:TextStyle(fontSize: 11,color: AppColor.textColor,overflow: TextOverflow.ellipsis),),
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
                        height: height * 0.0525,
                        child: ListView.builder(itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              setState(() {
                                selectedCategory = index;
                                controler.fetchCategoryEvent(AppCategory.category[selectedCategory]["name"]);
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: width*0.025),
                              padding: EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 20),
                              decoration: BoxDecoration(
                                  color: selectedCategory == index ? Colors.green.shade600:Colors.white.withOpacity(0.09),
                                  borderRadius: BorderRadius.circular(35)
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: height * 0.04,
                                    width: height * 0.04,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: AppCategory.category[index]["img"],
                                  ),
                                  SizedBox(width: 10,),
                                  Text(AppCategory.category[index]["name"],style: selectedCategory == index ?AppStyle.commonTextStyle:AppStyle.secondaryCommonTextStyle,),
                                ],
                              ),
                            ),
                          );
                        },
                          itemCount: AppCategory.category.length,
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
                            margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.09),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(categoryData[index].img,height: height * 0.085,width: height * 0.085,fit: BoxFit.cover,),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Text(categoryData[index].title,
                                          style: TextStyle(
                                            color: Colors.white,fontSize: 15,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold,),
                                        ),
                                        width: width * 0.75,
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                                          Text(DateFormat(' MM/dd/yyyy').format(categoryData[index].date),style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 10),),
                                          SizedBox(width: 5),
                                          Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                                          Text(DateFormat(' hh:mm a').format(categoryData[index].date),style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 10),),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,color: Colors.green.shade600,size: 16,),
                                          Expanded(child: Text(categoryData[index].location,style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 10,overflow: TextOverflow.ellipsis),))
                                        ],
                                      )
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
                )
            );
          }
        }

      }
    );
  }
}