import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/App_Resources/App_Category.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import '../../../App_Resources/App_Color.dart';
import '../../../App_Resources/App_Screen_Size.dart';
import '../organizerDashBord/organizerDashBord_Screen.dart';

class addEventScreen extends StatefulWidget {
  const addEventScreen({super.key});

  @override
  State<addEventScreen> createState() => _addEventScreenState();
}

class _addEventScreenState extends State<addEventScreen> {

  TextEditingController titleController = TextEditingController();
  var type;
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController vipSeatsController = TextEditingController();
  TextEditingController economySeatsController = TextEditingController();
  TextEditingController vPriceController = TextEditingController();
  TextEditingController ePriceController = TextEditingController();

  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Get.back();
            // Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),),
        title: Text("Create New Event",style: TextStyle(color: Colors.white,fontSize: 18,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  showBottomSheet(context);
                },
                child: Container(
                  height: height * 0.25,
                  width: width * 0.875,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: _imageFile != null ? null : Border(
                        top: BorderSide(color: Colors.green.shade600,width: 1),
                        bottom: BorderSide(color: Colors.green.shade600,width: 1),
                        left: BorderSide(color: Colors.green.shade600,width: 1),
                        right: BorderSide(color: Colors.green.shade600,width: 1),
                      )
                  ),
                  child: _imageFile != null ? Image.file(_imageFile!,fit: BoxFit.cover,) : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,color: Colors.green.shade600,size: 20,),
                        Text("Add Cover Photo",style: TextStyle(color: Colors.white,fontSize: 12),)
                      ],
                    ),
                  ),
                ),
              ),
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
                controller: titleController,
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
                items: AppCategory.category.map((e) => DropdownMenuItem(
                    value: e['name'],
                    child: Text(e['name'])
                ),).toList(),
                onChanged: (value) {
                  type = value!;
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
                controller: dateTimeController,
                onTap: (){
                  pickDateTime(context);
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
                controller: locationController,
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
                controller: descriptionController,
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
                          controller: vipSeatsController,
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
                          controller: economySeatsController,
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
                          controller: vPriceController,
                          cursorColor: AppColor.textColor,
                          style: TextStyle(color:AppColor.textColor),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: ' Enter Price',
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
                          controller: ePriceController,
                          cursorColor: AppColor.textColor,
                          style: TextStyle(color:AppColor.textColor),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: ' Enter Price',
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
                    value: _isSwitched,
                    onChanged: (value) {
                      setState(() {
                        if(_isSwitched == true){
                          _isSwitched = false;
                        }else{
                          _isSwitched = true;
                        }
                      });
                    },
                  )
                ],
              ),
              SizedBox(height: height * 0.05,),
              GestureDetector(
                onTap: (){

                  if(imageUrl == null){
                    showSnackBar.error_message(context, "please select event image");
                  }else if(titleController.text.isEmpty){
                    showSnackBar.error_message(context, "please enter event title");
                  }else if(type == null){
                    showSnackBar.error_message(context, "please select event type");
                  }else if(dateTimeController.text.isEmpty){
                    showSnackBar.error_message(context, "please select event datetime");
                  }else if(locationController.text.isEmpty){
                    showSnackBar.error_message(context, "please enter event location");
                  }else if(descriptionController.text.isEmpty){
                    showSnackBar.error_message(context, "please enter event description");
                  }else if(vipSeatsController.text.isEmpty){
                    showSnackBar.error_message(context, "please enter Vip Seats");
                  }else if(economySeatsController.text.isEmpty){
                    showSnackBar.error_message(context, "please enter Economy Seats");
                  }else if(vPriceController.text.isEmpty){
                    showSnackBar.error_message(context, "please enter Economy Seats Price");
                  }else if(ePriceController.text.isEmpty){
                    showSnackBar.error_message(context, "please enter Economy Seats Prices");
                  }else{
                    addEvent(imageUrl.toString(),titleController.text.toString(),type,locationController.text.toString(),descriptionController.text.toString(),int.parse(vPriceController.text),int.parse(ePriceController.text),int.parse(vipSeatsController.text),int.parse(economySeatsController.text),finalDateTime,_isSwitched);
                  }
                },
                child: Container(
                  height: height * 0.065,
                  decoration: BoxDecoration(
                      color: Colors.green.shade600,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text("PUBLISH NOW",style:TextStyle(color: Colors.white,fontSize: 14,letterSpacing: 1),),
                  ),
                ),
              ),
              SizedBox(height: height * 0.0225,),
            ],
          ),
        ),
      ),
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
                  pickImage();
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
  
  File? _imageFile;
  String? imageUrl;
  Future<void> pickImage() async{
    ImagePicker imagePicker=ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);

    if(file!=null){
      setState(() {
        _imageFile = File(file.path);
      });
      uploadImage();
    }
  }

  Future<void>uploadImage()async{
    final uid = FirebaseAuth.instance.currentUser!.uid;

    if(_imageFile !=null){
      try{
        Reference ref = FirebaseStorage.instance.ref().child('images/$uid/event photos/${DateTime.now().toString()}');
        UploadTask uploadTask = ref.putFile(_imageFile!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadURL;
        });

        print("Image Url : $downloadURL");
      }catch(e){
        print("/////////////////${e.toString()}/////////////////");
      }
    }
  }

  var finalDateTime;
  Future<void> pickDateTime(BuildContext context) async{
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final date = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          finalDateTime = date;
          dateTimeController.text = date.toString();
        });
      }

    }
  }

  Future<void> addEvent(String imgUrl,title,type,location,description,int vprice,eprice,vipSeats,economySeats,DateTime date,bool preBooking) async {

    final uid = FirebaseAuth.instance.currentUser!.uid;
    print(imgUrl);
    print(title);
    print(type);
    print(location);
    print(date);
    print(description);
    print(vprice);
    print(eprice);

    String docId = FirebaseFirestore.instance.collection('events').doc().id;

    await FirebaseFirestore.instance.collection('event').doc(docId).set({
      "id": docId,
      "organizer_id" : uid,
      "title" : title,
      "image" : imageUrl,
      "category" : type,
      "location" : location,
      "date" : date,
      "description" : description,
      "price" : {
        "VIP" : vprice,
        "Economy" : eprice
      },
      "isPreBookingEnabled" : preBooking,
      "availableSeats" : {
        "VIP" : vipSeats,
        "Economy" : economySeats
      }
    }).then((value) {
      showSnackBar.message(context, "Event is Publish Now");
      Navigator.push(context, MaterialPageRoute(builder: (context) => organizerDashBordScreen(),));
    },);

  }
}
