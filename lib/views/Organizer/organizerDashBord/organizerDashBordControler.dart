import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/eventmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class organizerDashBordControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var myEvent =<eventDataModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyEvent();
  }

  void getMyEvent()async{
    try{
      isLoading(true);
      myEvent.clear();
      QuerySnapshot snapshot = await _firestore.collection('event').where('organizer_id', isEqualTo: uid).get();

      if(snapshot.docs.isNotEmpty){
        myEvent.assignAll(snapshot.docs.map((doc) {
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