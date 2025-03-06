import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import '../../../App_Resources/App_Color.dart';
import '../../../App_Resources/App_Screen_Size.dart';
import '../../../App_Resources/App_Style.dart';
import '../../../routes/appRoutesName.dart';
import '../ticketBooking/ticketBooking_Scereen.dart';
import 'eventDetailControler.dart';

class eventDetailScreen extends StatefulWidget {
  eventDetailScreen({super.key});

  @override
  State<eventDetailScreen> createState() => _eventDetailScreenState();
}

class _eventDetailScreenState extends State<eventDetailScreen> {

  List Eventphoto = [
    'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGV2ZW50fGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1475721027785-f74eccf877e2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGV2ZW50fGVufDB8fDB8fHww',
    'https://media.istockphoto.com/id/471906412/photo/beautiful-table-setting-for-an-wedding-reception-or-an-event.jpg?s=612x612&w=0&k=20&c=knlIBspy-ZKuQV7bUVr_eclJmyC24ShNAva_Jh9Rwfc=',
    'https://media.istockphoto.com/id/1352398824/photo/birthday-cake-on-a-background-balloons-party-decor-copy-space-trendy-cake-delicious-wedding.jpg?s=612x612&w=0&k=20&c=T4wlEs_JmC2XOMsCBSzTCBmp7bKRHbCkwjs4RlZpPjU=',
    'https://media.istockphoto.com/id/2045556384/video/the-waiter-places-the-finished-sandwiches-on-the-table-with-treats-catering.jpg?s=640x640&k=20&c=_D__UWIFNJuTcJ7CJXTy-94q3qPNYOXefcI3uaDEA8w=',
  ];

  final eventDetailControler controler = Get.put(eventDetailControler());

  @override
  void initState() {
    super.initState();
    controler.fetchEventById(Get.arguments['id'],Get.arguments['category']);
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {

        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final data = controler.selectedEvent.value;
          if(data == null){
            return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
          }else{
            final categoryData = controler.categoryRelatedEvent;
            final organizerData = controler.OrganizerData.value;
            if(organizerData == null){
              return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
            }else{
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: Colors.green.shade600,
                        expandedHeight: 350,
                        leading: GestureDetector(
                          onTap: (){
                            Get.back();
                            // Navigator.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back,color: Colors.white,size: 18,),
                        ),
                        actions: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Icon(Icons.favorite,color: Colors.green.shade600,size: 18,),
                          ),
                          SizedBox(width: 10,)
                        ],
                        centerTitle: true,
                        title: Text("EVENT DETAIL",style: TextStyle(color: Colors.white,fontSize: 20,letterSpacing: 2),),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(data.img??'noImage'),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Text(data.title ?? 'no Title',style: TextStyle(color: Colors.white,fontSize: 23),),
                              SizedBox(height: 10,),
                              Divider(color: Colors.white.withOpacity(0.25),),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Icon(Icons.date_range,color: Colors.green.shade600,size: 20,),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(DateFormat('MM/dd/yyyy').format(data.date)?? 'no date',style: TextStyle(color: Colors.white,fontSize: 14),),
                                      Text(DateFormat('hh:mm a').format(data.date)?? 'no time',style: TextStyle(color: Colors.white,fontSize: 12),),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Icon(Icons.location_pin,color: Colors.green.shade600,size: 20,),
                                  ),
                                  SizedBox(width: 10,),
                                  SizedBox(
                                    width: width * 0.7,
                                    child: Text(data.location ?? 'no location',style: TextStyle(color: Colors.white,fontSize: 14),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Icon(Icons.person,color: Colors.green.shade600,size: 20,),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(organizerData.name ?? 'no organizer',style: TextStyle(color: Colors.white,fontSize: 14),),
                                      Text("Organizer",style: TextStyle(color: Colors.white,fontSize: 12),),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                              Divider(color: Colors.white.withOpacity(0.25),),
                              SizedBox(height: 10,),
                              Text("About Event",style: TextStyle(color: Colors.green.shade600,fontSize: 16),),
                              ReadMoreText(
                                data.description ?? 'no description',
                                trimLines: 2,
                                style: TextStyle(color: Colors.white,fontSize: 12),
                              ),
                              SizedBox(height: 10,),
                              Divider(color: Colors.white.withOpacity(0.25),),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Related Events",style: AppStyle.commonTextStyle,),
                                  Text("See More",style: AppStyle.secondaryCommonTextStyle,)
                                ],
                              ),
                              SizedBox(height: 10,),
                              SizedBox(
                                height: height * 0.345,
                                child: ListView.builder(itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: (){
                                      Get.toNamed(
                                        appRoutesName.eventDetailScreen,
                                        arguments: {
                                          'id': categoryData[index].id,
                                          'category':categoryData[index].category
                                        },
                                      );
                                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => eventDetailScreen(id: categoryData[index].id, category: categoryData[index].category,),));
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
                                              image: DecorationImage(image: NetworkImage(categoryData[index].img,),fit: BoxFit.cover),
                                            ),
                                          ),
                                          SizedBox(height: height * 0.01,),
                                          Text(categoryData[index].title,style: AppStyle.overFlowTextStyle,),
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
                                                        Text(DateFormat('MM/dd/yyyy').format(categoryData[index].date),style:TextStyle(fontSize: 11,color: AppColor.textColor),)
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
                                                          child: Text(categoryData[index].location,style:TextStyle(fontSize: 11,color: AppColor.textColor,overflow: TextOverflow.ellipsis),),
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
                                  itemCount: categoryData.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              data.isPreBookingEnabled ? SizedBox(height: 125,) : SizedBox(height: 20,)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  data.isPreBookingEnabled ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: height * 0.095,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0XFFF7F9F2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border(
                                  top: BorderSide(color: Colors.black.withOpacity(0.2),width: 1),
                                  bottom: BorderSide(color: Colors.black.withOpacity(0.2),width: 1),
                                  left: BorderSide(color: Colors.black.withOpacity(0.2),width: 1),
                                  right: BorderSide(color: Colors.black.withOpacity(0.2),width: 1),
                                )
                            ),
                            child: Icon(Icons.favorite_border,color: Colors.black,size: 20,),
                          ),
                          controler.checkSeats() ? GestureDetector(
                            child: Container(
                              height: 55,
                              padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                              decoration: BoxDecoration(
                                  color: Colors.green.shade600,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("BUY A TICKET",
                                    style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 1),
                                  ),
                                ],
                              ),
                            ),
                            onTap: ()async{
                              Get.toNamed(appRoutesName.ticketBookingScreen,arguments: {
                                'price': data.price.toDouble(),
                                'data' : data
                              });
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => ticketBookingScreen(price: data.price.toDouble(),data: data,)));
                            },
                          ) : GestureDetector(
                            child: Container(
                              height: 55,
                              padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                              decoration: BoxDecoration(
                                  color: Colors.green.shade600,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("FULL",
                                    style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 1),
                                  ),
                                ],
                              ),
                            ),
                            onTap: ()async{
                              showSnackBar.error_message(context, "Sorry Seats are Full");
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => ticketBookingScreen(price: data.price.toDouble(),data: data,)));
                            },
                          ),
                        ],
                      ),
                    ),
                  ): SizedBox()
                ],
              );
            }
          }
        }
      },),
    );
  }
}
