import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/eventmodel.dart';


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
      QuerySnapshot snapshot = await _firestore.collection('event').orderBy("date", descending: false).get();
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


  // Filter states
  var selectedCategories = <String>[].obs;
  var selectedTimeFilter = "".obs;
  var minPrice = 0.0.obs;
  var maxPrice = 5000.0.obs;

  void filter(){
    print(selectedCategories.value);
    print(selectedTimeFilter.value);
  }

  void resetFilters() {
    selectedCategories.clear();
    selectedTimeFilter.value = "";
    minPrice.value = 0.0;
    maxPrice.value = 5000.0;
    // applyFilters();
  }

}