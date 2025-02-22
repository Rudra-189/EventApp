
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/eventmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class exploreControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var event = RxList<eventDataModel>();
  var categoryEvent = RxList<eventDataModel>();

  @override
  void onInit() {
    super.onInit();
    getEvent();
  }

  void getEvent()async{
    try{
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('event').get();
      event.value = snapshot.docs.map((doc) {
        return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

  void fetchCategoryEvent(String category)async{
    try {
      QuerySnapshot snapshot = await _firestore.collection('event').get();
      event.value = snapshot.docs.map((doc) {
        return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      categoryEvent.clear();
      categoryEvent.assignAll(event.where((event) => event.category == category.toLowerCase()).toList());
    } catch (e) {
      print("Error fetching event: $e");
    }
  }

}