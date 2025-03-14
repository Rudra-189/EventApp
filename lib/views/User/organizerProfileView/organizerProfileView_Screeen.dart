import 'package:event_project_01/models/userModel.dart';
import 'package:event_project_01/views/User/organizerProfileView/organizerProfileViewControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class organizerProfileViewScreen extends StatefulWidget {
  const organizerProfileViewScreen({super.key});

  @override
  State<organizerProfileViewScreen> createState() => _organizerProfileViewScreenState();
}

class _organizerProfileViewScreenState extends State<organizerProfileViewScreen> {

  final organizerProfileViewControler controler = Get.put(organizerProfileViewControler());

  userDataModel? organizer;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    organizer = Get.arguments['data'];
    controler.getMyEvent(organizer!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),
        ),
        backgroundColor: Colors.transparent,
        title: Text("ORGANIZER",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          return Column(
            children: [
              SizedBox(height: 20,),
              // Profile Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      organizer!.photo.isEmpty ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ) : Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: NetworkImage(organizer!.photo),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text(organizer!.name,style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 1),),
                      Text(organizer!.email,style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 14),),
                    ],
                  )
                ],
              ),
              SizedBox(height: 75,),
              // Tab Bar
              DefaultTabController(
                length: 3,
                child: Expanded(
                  child: Column(
                    children: [
                      TabBar(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        labelColor: Colors.green.shade600,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.green.shade600,
                        tabs: [
                          Tab(text: "About"),
                          Tab(text: "Events"),
                          // Tab(text: "Reviews"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            aboutTab(),
                            eventsTab(),
                            // reviewsTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      },),
    );
  }
  // Widget profileStat(String value, String label) {
  //   return Column(
  //     children: [
  //       Text(
  //         value,
  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //       ),
  //       Text(label, style: TextStyle(color: Colors.grey)),
  //     ],
  //   );
  // }
  //
  // Widget verticalDivider() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //     child: Container(width: 1, height: 30, color: Colors.grey.shade300),
  //   );
  // }
  //
  // Widget followButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       // Handle Follow action
  //     },
  //     style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
  //     child: Text("Follow"),
  //   );
  // }
  //
  // Widget messageButton() {
  //   return OutlinedButton(
  //     onPressed: () {
  //       // Handle Messages
  //     },
  //     child: Text("Messages"),
  //   );
  // }

  Widget aboutTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        "Ultricies arcu venenatis in lorem faucibus lobortis at. East odio varius nisl congue aliquam nunc est sit...Ultricies arcu venenatis in lorem faucibus lobortis at. East odio varius nisl congue aliquam nunc est sit...",
        style: TextStyle(fontSize: 14,color: Colors.white),
      ),
    );
  }

  Widget eventsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(itemBuilder: (context, index) {
            final event = controler.organizerEvent;
            return Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.09),
                borderRadius: BorderRadius.circular(15),
              ),
              child:  ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Image.network(
                      event[index].img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(event[index].title,style: TextStyle(color: Colors.white,fontSize: 16,overflow:TextOverflow.ellipsis),) ,
                subtitle: Row(
                  children: [
                    Icon(Icons.date_range,color: Colors.green.shade600,size: 16,),
                    Text(DateFormat('MM/dd/yyyy').format(event[index].date),style: TextStyle(color: Colors.white,fontSize: 10),),
                    SizedBox(width: 5,),
                    Icon(Icons.timer_outlined,color: Colors.green.shade600,size: 16,),
                    Text( DateFormat('hh:mm a').format(event[index].date),style: TextStyle(color: Colors.white,fontSize: 10),),
                  ],
                ),

              ),
            );
          },
            itemCount: controler.organizerEvent.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          )
        ],
      ),
    );
  }

  // Widget reviewsTab() {
  //   return Center(child: Text("Reviews about the Organizer."));
  // }
}
