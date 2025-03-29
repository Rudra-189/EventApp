import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/views/Organizer/editEvent/editEventControler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../App_Resources/App_Color.dart';
import '../../../App_Resources/App_Screen_Size.dart';
import '../../../utils/showSnackbar.dart';
import '../organizerDashBord/organizerDashBord_Screen.dart';

class editEventScreen extends StatefulWidget {
  const editEventScreen({super.key});

  @override
  State<editEventScreen> createState() => _editEventScreenState();
}

class _editEventScreenState extends State<editEventScreen> {

  final editEventControlet controlet = Get.put(editEventControlet());

  @override
  void initState() {
    super.initState();
    controlet.getEventData(Get.arguments);
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Get.back();
            // Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),),
        title: Text("EDIT EVENT",style: TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2),),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Obx(() {
        if(controlet.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          final data = controlet.selectedEvent.value;
          if(data == null){
            return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
          }else{
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                child: Column(
                  children: [
                    Obx(() {
                      if(controlet.isLoading.value){
                        return GestureDetector(
                          onTap: (){
                            showBottomSheet(context);
                          },
                          child: Container(
                              height: height * 0.25,
                              width: width * 0.875,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                  border: data.img.isEmpty ? Border(
                                    top: BorderSide(color: Colors.green.shade600,width: 1),
                                    bottom: BorderSide(color: Colors.green.shade600,width: 1),
                                    left: BorderSide(color: Colors.green.shade600,width: 1),
                                    right: BorderSide(color: Colors.green.shade600,width: 1),
                                  ) : null
                              ),
                              child:Center(child: CircularProgressIndicator(color: Colors.green.shade600,)),
                          ),
                        );
                      }else{
                        return GestureDetector(
                          onTap: (){
                            showBottomSheet(context);
                          },
                          child: Container(
                              height: height * 0.25,
                              width: width * 0.875,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                  border: data.img.isEmpty ? Border(
                                    top: BorderSide(color: Colors.green.shade600,width: 1),
                                    bottom: BorderSide(color: Colors.green.shade600,width: 1),
                                    left: BorderSide(color: Colors.green.shade600,width: 1),
                                    right: BorderSide(color: Colors.green.shade600,width: 1),
                                  ) : null
                              ),
                              child:controlet.imgPath.value != null? Image.file(controlet.imgPath.value!,fit: BoxFit.cover,) : Image.network(controlet.imageUrl.value,fit: BoxFit.cover,)
                          ),
                        );
                      }

                    },),
                    SizedBox(height: height * 0.025,),
                    Divider(color: Colors.white.withOpacity(0.25),height: 0.5,),
                    SizedBox(height: height * 0.025,),
                    Row(
                      children: [
                        Text("Event Detail",style: TextStyle(color: Colors.green.shade600,fontSize: 16,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height: height * 0.025,),
                    Row(
                      children: [
                        Text("Event Name",style: TextStyle(color: Colors.white,fontSize: 14),),
                      ],
                    ),
                    SizedBox(height: height * 0.01,),
                    TextFormField(
                      controller: controlet.titleController ,
                      cursorColor: AppColor.textColor,
                      style: TextStyle(color:AppColor.textColor),
                      decoration: InputDecoration(
                        hintText: ' Type Your Event Name',
                        filled: true,
                        fillColor: AppColor.textFiledBgColor,
                        contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                        hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.borderColor,
                                width: 0.25
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColour,
                              width: 0.5,
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025,),
                    Row(
                      children: [
                        Text("Event Type",style: TextStyle(color: Colors.white,fontSize: 14),),
                      ],
                    ),
                    SizedBox(height: height * 0.01,),
                    DropdownButtonFormField(
                      dropdownColor: Colors.green.shade600,
                      value: controlet.type.value,
                      items: [
                        DropdownMenuItem(
                            value: "sport",
                            child: Text("sport")
                        ),
                        DropdownMenuItem(
                            value: "music",
                            child: Text("music")
                        ),
                        DropdownMenuItem(
                            value: "food",
                            child: Text("food")
                        ),
                        DropdownMenuItem(
                            value: "art",
                            child:Text("art")
                        ),
                        DropdownMenuItem(
                            value: "festivals",
                            child:Text("festivals")
                        ),
                        DropdownMenuItem(
                            value: "product launches",
                            child: Text("product launches")
                        ),
                        DropdownMenuItem(
                            value: "conferences",
                            child: Text("conferences")
                        ),
                        DropdownMenuItem(
                            value: "design",
                            child: Text("design")
                        ),
                        DropdownMenuItem(
                            value: "business",
                            child: Text("business")
                        ),
                        DropdownMenuItem(
                            value: "birthday",
                            child: Text("birthday")
                        ),
                      ],
                      onChanged: (value) {
                        controlet.type.value = value!;
                      },
                      hint: Text("Choose Event Type",style: TextStyle(color: Colors.white.withOpacity(0.5))),
                      style: TextStyle(color: Colors.white),
                      icon: Icon(Icons.arrow_drop_down,color: Colors.green.shade600,size: 25,),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.textFiledBgColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.borderColor,
                                width: 0.25
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColour,
                              width: 0.5,
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025,),
                    Row(
                      children: [
                        Text("Select Data & Time",style: TextStyle(color: Colors.white,fontSize: 14),),
                      ],
                    ),
                    SizedBox(height: height * 0.01,),
                    TextFormField(
                      cursorColor: AppColor.textColor,
                      style: TextStyle(color:AppColor.textColor),
                      decoration: InputDecoration(
                          hintText: ' Choose Event Date',
                          filled: true,
                          fillColor: AppColor.textFiledBgColor,
                          contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                          hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                  color: AppColor.borderColor,
                                  width: 0.25
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: AppColor.secondaryColour,
                                width: 0.5,
                              )
                          ),
                          suffixIcon: Icon(Icons.date_range,color: Colors.green.shade600,size: 20,)
                      ),
                      readOnly: true,
                      controller: controlet.dateTimeController,
                      onTap: (){
                        controlet.pickDateTime(context);
                      },
                    ),
                    SizedBox(height: height * 0.025,),
                    Row(
                      children: [
                        Text("Event Location",style: TextStyle(color: Colors.white,fontSize: 14),),
                      ],
                    ),
                    SizedBox(height: height * 0.01,),
                    TextFormField(
                      controller: controlet.locationController,
                      cursorColor: AppColor.textColor,
                      style: TextStyle(color:AppColor.textColor),
                      decoration: InputDecoration(
                        hintText: ' Enter Event Location',
                        filled: true,
                        fillColor: AppColor.textFiledBgColor,
                        contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                        hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.borderColor,
                                width: 0.25
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColour,
                              width: 0.5,
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025,),
                    Row(
                      children: [
                        Text("Event Description",style: TextStyle(color: Colors.white,fontSize: 14),),
                      ],
                    ),
                    SizedBox(height: height * 0.01,),
                    TextFormField(
                      controller: controlet.descriptionController,
                      cursorColor: AppColor.textColor,
                      style: TextStyle(color:AppColor.textColor),
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: ' Type Your Event Description',
                        filled: true,
                        fillColor: AppColor.textFiledBgColor,
                        contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                        hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: AppColor.borderColor,
                                width: 0.25
                            )
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: AppColor.secondaryColour,
                              width: 0.5,
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.025,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.425,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("VipSeats",style: TextStyle(color: Colors.white,fontSize: 14),),
                              SizedBox(height: height * 0.01,),
                              TextFormField(
                                controller: controlet.vipSeatsController,
                                cursorColor: AppColor.textColor,
                                style: TextStyle(color:AppColor.textColor),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: ' Enter Seats',
                                  filled: true,
                                  fillColor: AppColor.textFiledBgColor,
                                  contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                                  hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColor.borderColor,
                                          width: 0.25
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: AppColor.secondaryColour,
                                        width: 0.5,
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.425,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("EconomySeats",style: TextStyle(color: Colors.white,fontSize: 14),),
                              SizedBox(height: height * 0.01,),
                              TextFormField(
                                controller: controlet.economySeatsController,
                                cursorColor: AppColor.textColor,
                                style: TextStyle(color:AppColor.textColor),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: ' Enter Seats',
                                  filled: true,
                                  fillColor: AppColor.textFiledBgColor,
                                  contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                                  hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColor.borderColor,
                                          width: 0.25
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: AppColor.secondaryColour,
                                        width: 0.5,
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.425,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("VipPrice",style: TextStyle(color: Colors.white,fontSize: 14),),
                              SizedBox(height: height * 0.01,),
                              TextFormField(
                                controller: controlet.vPriceController,
                                cursorColor: AppColor.textColor,
                                style: TextStyle(color:AppColor.textColor),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.textFiledBgColor,
                                  contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                                  hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColor.borderColor,
                                          width: 0.25
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: AppColor.secondaryColour,
                                        width: 0.5,
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.425,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("EconomyPrice",style: TextStyle(color: Colors.white,fontSize: 14),),
                              SizedBox(height: height * 0.01,),
                              TextFormField(
                                controller: controlet.ePriceController,
                                cursorColor: AppColor.textColor,
                                style: TextStyle(color:AppColor.textColor),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.textFiledBgColor,
                                  contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                                  hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: AppColor.borderColor,
                                          width: 0.25
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: AppColor.secondaryColour,
                                        width: 0.5,
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.025,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Is PreBooking Enabled",style: TextStyle(color: Colors.white,fontSize: 14),),
                        Switch(
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green.shade600,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.white.withOpacity(0.25),
                          value: controlet.isPreBooking.value,
                          onChanged: (value) {
                            DateTime today = DateTime.now();
                            DateTime twoMonthsLater = today.add(const Duration(days: 45));
                            setState(() {
                              if(controlet.isPreBooking.value == true){
                                controlet.isPreBooking.value = false;
                              }else{
                                controlet.isPreBooking.value = true;
                              }
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.05,),
                    GestureDetector(
                      onTap: (){
                        controlet.updateEvent().then((value) {
                          showSnackBar.message(context, "Event is Updated");
                          Get.back();
                        },);
                      },
                      child: Container(
                        height: height * 0.065,
                        decoration: BoxDecoration(
                            color: Colors.green.shade600,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Text("SAVE CHANGES",style:TextStyle(color: Colors.white,fontSize: 14,letterSpacing: 1),),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02,),
                  ],
                ),
              ),
            );
          }
        }
      },),
    );
  }

  void showBottomSheet(BuildContext context){

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,

      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  controlet.pickImage();
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/Gallery.svg'),
                      Text("From Gallery",style: TextStyle(color: Colors.black,fontSize: 12,letterSpacing: 1),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/camera.svg'),
                      Text("Take Photo",style: TextStyle(color: Colors.black,fontSize: 12,letterSpacing: 1),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


}
