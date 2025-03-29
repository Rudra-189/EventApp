import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/ticketModel.dart';
import 'package:event_project_01/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ticketBookedControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var myEventTickets =<ticketDataModel>[].obs;
  var users =<userDataModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyEvent();
  }

  void getMyEvent()async{
    try{
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('event').where('organizer_id', isEqualTo: uid).get();

      if(snapshot.docs.isNotEmpty){
        List<String> eventIds = snapshot.docs.map((doc) => doc.id).toList();
        print(eventIds.toString());
        if (eventIds.isNotEmpty) {
          getEventTickets(eventIds);
        }
      }
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

  void getEventTickets(List<String> eventIds)async{
    try{
      isLoading(true);
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('ticket').where('event_id', whereIn: eventIds).get();

      if(snapshot.docs.isNotEmpty){
        myEventTickets.assignAll(snapshot.docs.map((doc) {
          return ticketDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList());
      }

    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }
}