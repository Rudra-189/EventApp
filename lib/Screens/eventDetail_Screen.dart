import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class eventDetail_Page extends StatefulWidget {
  String img;
  eventDetail_Page({super.key,required this.img});

  @override
  State<eventDetail_Page> createState() => _eventDetail_PageState();
}

class _eventDetail_PageState extends State<eventDetail_Page> {

  int itemcount = 1;
  int total = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                leading: Icon(Icons.arrow_back,color: Colors.green.shade600,),
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
                title: Text("Event Detail",style: TextStyle(color: Colors.white,fontSize: 20),),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.img),
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
                      Text("Event of International Band Music Concert",style: TextStyle(color: Colors.white,fontSize: 23),),
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
                              Text("14 December, 2021",style: TextStyle(color: Colors.white,fontSize: 14),),
                              Text("Tuesday, 4:00PM - 9:00PM",style: TextStyle(color: Colors.white,fontSize: 12),),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Gala Convention Center",style: TextStyle(color: Colors.white,fontSize: 14),),
                              Text("36 Guild Street London, UK ",style: TextStyle(color: Colors.white,fontSize: 12),),
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
                            child: Icon(Icons.person,color: Colors.green.shade600,size: 20,),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ashfak Sayem",style: TextStyle(color: Colors.white,fontSize: 14),),
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
                        "hello i am rudra. am organizer of this event. this event is for consert of famouse youtuber witch have 50 Million suscriber. so it come on over consert for my envitation.hello i am rudra. am organizer of this event. this event is for consert of famouse youtuber witch have 50 Million suscriber. so it come on over consert for my envitation.",
                        trimLines: 2,
                        style: TextStyle(color: Colors.white,fontSize: 12),
                      ),
                      SizedBox(height: 300,)
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0XFFF7F9F2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 120,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade600.withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Icon(Icons.remove,
                                      size: 17, color: Colors.green.shade600)),
                            ),
                            onTap: () {
                              setState(() {
                                if (itemcount == 1) {
                                 setState(() {
                                   itemcount = 1;
                                   total = 100;
                                 });
                                } else {
                                  setState(() {
                                    itemcount--;
                                    total = 100 * itemcount;
                                  });
                                }
                              });
                            },
                          ),
                          Text(
                            "${itemcount}",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          ),
                          InkWell(
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Colors.green.shade600,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 17,
                                    color: Colors.white,
                                  )),
                            ),
                            onTap: () {
                              setState(() {
                                setState(() {
                                  itemcount++;
                                  total = 100 * itemcount;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                  ),
                  InkWell(
                    child: Container(
                      height: 50,
                      width: 175,
                      decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("BUY TICKET",
                              style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            "₹ ${total}",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    onTap: ()async{
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
