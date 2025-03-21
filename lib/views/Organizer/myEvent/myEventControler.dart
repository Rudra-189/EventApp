import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/eventmodel.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class myEventControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var myEvent =<eventDataModel>[].obs;

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

  void deleteEvent(BuildContext context,String id)async{
    try{
      FirebaseFirestore.instance.collection("event").doc(id)..delete().then((value) {
        showSnackBar.message(context,'Event deleted successfully');
      },);
    }catch(e){
      print("///////////${e.toString()}/////////");
    }finally{

    }
  }
}