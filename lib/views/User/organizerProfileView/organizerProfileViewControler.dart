import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/eventmodel.dart';

class organizerProfileViewControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var organizerEvent =<eventDataModel>[].obs;

  void getMyEvent(String id)async{
    try{
      isLoading(true);
      organizerEvent.clear();
      QuerySnapshot snapshot = await _firestore.collection('event').where('organizer_id', isEqualTo: id).get();

      if(snapshot.docs.isNotEmpty){
        organizerEvent.assignAll(snapshot.docs.map((doc) {
          return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList());
      }
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }
}