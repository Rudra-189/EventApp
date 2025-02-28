import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/ticketModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ticketBookingControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var myEventTickets =<ticketDataModel>[].obs;

  void getEventTickets(String id)async{
    try{
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('ticket').where('event_id', isEqualTo: id).get();

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