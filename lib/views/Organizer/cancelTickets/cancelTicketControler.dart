import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/cancelModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/eventmodel.dart';

class cancelTicketControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var canceledTickets = <cancelDataModel>[].obs;

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
          _listenForCanceledTickets(eventIds);
        }
      }
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

  void _listenForCanceledTickets(List<String> eventIds)async{
    try{
      isLoading(true);
      print(eventIds.toString());
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('cancel').where('eventId', whereIn: eventIds).get();
      if(snapshot.docs.isNotEmpty){
        canceledTickets.assignAll(snapshot.docs.map((doc) {
          return cancelDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList());
        print(canceledTickets.toString());
      }
    }catch(e){
      print("//////${e.toString()}/////");
    }finally{
      isLoading(false);
    }

  }
}