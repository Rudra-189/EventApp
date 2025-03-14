import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/eventmodel.dart';

class calenderControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var calender = RxList<eventDataModel>();

  void getEvent()async{
    try{
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('event').orderBy('date', descending: false).get();

      if(snapshot.docs.isNotEmpty){
        calender.value = snapshot.docs.map((doc) {
          return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      }
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }
}