import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/eventmodel.dart';

class searchControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var originalList  = RxList<eventDataModel>();
  var filteredList = RxList<eventDataModel>();
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getEvent();
  }

  void getEvent()async{
    try{
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('event').get();
      originalList.value = snapshot.docs.map((doc) {
        return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      filteredList.assignAll(originalList);
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

  void searchEvent(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredList.assignAll(originalList);
    } else {
      filteredList.assignAll(originalList.where((event) => event.title.toLowerCase().contains(query.toLowerCase())).toList());
    }
  }

}