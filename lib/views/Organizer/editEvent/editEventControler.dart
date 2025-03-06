import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/eventmodel.dart';
import '../../../utils/showSnackbar.dart';

class editEventControlet extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var selectedEvent = Rxn<eventDataModel>();

  var imgPath = Rx<File?>(null);
  var imageUrl = ''.obs;
  var titleController = TextEditingController();
  var type = ''.obs;
  var dateTimeController = TextEditingController();
  var finalDateTime = Rxn<DateTime>();
  var locationController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var vipSeatsController = TextEditingController();
  var economySeatsController = TextEditingController();

  var isPreBooking = false.obs;

  void getEventData(String id)async{
    try{
      isLoading(true);
      DocumentSnapshot doc = await _firestore.collection('event').doc(id).get();
      if(doc.exists){
        selectedEvent.value = eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);

        imageUrl.value = selectedEvent.value!.img;
        print(imageUrl.value);
        titleController.text = selectedEvent.value!.title;
        print(titleController.text);
        type.value = selectedEvent.value!.category;
        print(type);
        dateTimeController.text = selectedEvent.value!.date.toString();
        finalDateTime.value = selectedEvent.value!.date;
        print(finalDateTime);
        locationController.text = selectedEvent.value!.location;
        print(locationController.text);
        descriptionController.text = selectedEvent.value!.description;
        print(descriptionController.text);
        priceController.text = selectedEvent.value!.price.toString();
        print(priceController.text);
        vipSeatsController.text = selectedEvent.value!.availableSeats.VIP.toString();
        print(vipSeatsController.text);
        economySeatsController.text = selectedEvent.value!.availableSeats.Economy.toString();
        print(economySeatsController.text);
        isPreBooking.value = selectedEvent.value!.isPreBookingEnabled;
        print(isPreBooking);

      }
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

  Future<void> pickImage() async{
    try{
      isLoading(true);
      ImagePicker imagePicker=ImagePicker();
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if(file!=null){
        imgPath.value = File(file.path);
        deleteImage().then((value) {
          uploadImage();
        },);
      }
    }catch(e){
      print("//////////${e.toString()}///////////");
    }finally{
      isLoading(false);
    }
  }

  Future<void>uploadImage()async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    if(imgPath != null){
      try{
        Reference ref = FirebaseStorage.instance.ref().child('images/$uid/event photos/${DateTime.now().toString()}');
        UploadTask uploadTask = ref.putFile(imgPath.value as File);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        imageUrl.value = downloadURL;

        print("Image Url : $downloadURL");
      }catch(e){
        print("/////////////////${e.toString()}/////////////////");
      }
    }
  }

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
        DateTime date = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        finalDateTime.value = date;
        dateTimeController.text = date.toString();
      }

    }
  }

  Future<void> deleteImage()async{
    try{
      Reference storageRef = FirebaseStorage.instance.refFromURL(imageUrl.value);
      await storageRef.delete();
    }catch(e){
      print("///////////${e.toString()}///////////");
    }
  }

  Future<void> updateEvent() async {

    //final uid = FirebaseAuth.instance.currentUser!.uid;
    print(selectedEvent.value!.id);
    print(selectedEvent.value!.organizer_id);
    print(titleController.text);
    print(imageUrl);
    print(type.value);
    print(locationController.text);
    print(finalDateTime);
    print(descriptionController.text);
    print(int.parse(priceController.text));
    print(isPreBooking.value);
    print(int.parse(vipSeatsController.text));
    print(int.parse(economySeatsController.text));


    await FirebaseFirestore.instance.collection('event').doc(selectedEvent.value!.id).update({
      "id": selectedEvent.value!.id,
      "organizer_id" : selectedEvent.value!.organizer_id,
      "title" : titleController.text,
      "image" : imageUrl.value,
      "category" : type.value,
      "location" : locationController.text,
      "date" : finalDateTime.value,
      "description" : descriptionController.text,
      "price" : int.parse(priceController.text),
      "isPreBookingEnabled" : isPreBooking.value,
      "availableSeats" : {
        "VIP" : int.parse(vipSeatsController.text),
        "Economy" : int.parse(economySeatsController.text)
      }
    });
  }

}