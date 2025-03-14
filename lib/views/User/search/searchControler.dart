import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/eventmodel.dart';


class searchControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  RxList<eventDataModel> originalList  = <eventDataModel>[].obs;
  RxList<eventDataModel> filteredList = <eventDataModel>[].obs;
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

  void searchEvent(String query){
    searchText.value = query;
    if (query.isEmpty) {
      getFilterData();
    } else {
      filteredList.assignAll(originalList.where((event) => event.title.toLowerCase().contains(query.toLowerCase())).toList());
    }
  }


  // Filter states

  RxList<String> selectedCategories = <String>[].obs;
  // var selectedTime = ''.obs;
  // var selectedDate = Rxn<DateTime>();
  // TextEditingController textController = TextEditingController();
  var priceRange = const RangeValues(100, 2000).obs;

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  // Future<void> pickDate(BuildContext context) async{
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2025),
  //     lastDate: DateTime(2026),
  //   );
  //   selectedDate.value = pickedDate;
  //   textController.text = DateFormat('yyyy-MM-dd').format(pickedDate!);
  // }

  void resetFilters() {
    selectedCategories.clear();
    // selectedTime.value = '';
    // selectedDate.value = null;
    // textController.text = '';
    priceRange.value = const RangeValues(100, 2000);
  }

  void applyFilters() {
    print('Selected Categories: ${selectedCategories.join(', ')}');
    // print('Selected Time: ${selectedTime.value}');
    // print('Selected Date: ${selectedDate.value}');
    print('Price Range: \$${priceRange.value.start} - \$${priceRange.value.end}');
    getFilterData();
    resetFilters();
  }

  void getFilterData()async{
    if(selectedCategories.isEmpty && priceRange.value.start == 100 && priceRange.value.end == 2000){
      filteredList.assignAll(originalList);
      print("all");
    }else if(selectedCategories.isNotEmpty){
      if(priceRange.value.start != 100 || priceRange.value.end != 2000){
        filteredList.assignAll(originalList.where((data) => selectedCategories.toString().toLowerCase().contains(data.category)).toList());
        filteredList.assignAll(filteredList.where((data) => data.price.Economy >= priceRange.value.start && data.price.Economy <= priceRange.value.end).toList());
        print("category");
        print("price");
      }else{
        filteredList.assignAll(originalList.where((data) => selectedCategories.toString().toLowerCase().contains(data.category)).toList());
        print("category");
      }
    }else if(priceRange.value.start != 100 || priceRange.value.end != 2000){
      filteredList.assignAll(originalList.where((data) => data.price.Economy >= priceRange.value.start && data.price.Economy <= priceRange.value.end).toList());
      print("price");
    }
  }

}
