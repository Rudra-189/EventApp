import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/ticketModel.dart';


class ticketControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var tickets = RxList<ticketDataModel>();

  void getTicket()async{
    try{
      isLoading(true);
      QuerySnapshot snapshot = await _firestore.collection('ticket').where('user_id', isEqualTo: uid).get();

      if(snapshot.docs.isNotEmpty){
        tickets.value = snapshot.docs.map((doc) {
          return ticketDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      }
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

}