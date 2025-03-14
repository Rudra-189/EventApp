import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/paymentModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class walletControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var payments =<paymentDataModel>[].obs;
  RxInt Revenue = 0.obs;

  void getEventPayment()async{
    try{
      isLoading(true);
      payments.clear();
      Revenue.value = 0;
      QuerySnapshot snapshot = await _firestore.collection('payments').where('organizerId', isEqualTo: uid).get();

      if(snapshot.docs.isNotEmpty){
        payments.assignAll(snapshot.docs.map((doc) {
          return paymentDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList());
        for(var i in payments){
          Revenue.value = Revenue.value + i.amount;
        }
      }
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

}