import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/eventmodel.dart';
import '../../../models/userModel.dart';

class exploreControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var upcomingEvent = RxList<eventDataModel>();
  var event = RxList<eventDataModel>();
  var categoryEvent = RxList<eventDataModel>();
  var user = Rxn<userDataModel>();
  var coins = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getEvent();
    getUserData();
  }

  void getEvent()async{
    try{
      isLoading(true);
      upcomingEvent.clear();
      getCoins();
      DateTime today = DateTime.now();
      DateTime twoMonthsLater = today.add(const Duration(days: 45));

      print(today);
      print(twoMonthsLater);

      QuerySnapshot snapshot = await _firestore.collection('event').where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(today)).where('date', isLessThanOrEqualTo: Timestamp.fromDate(twoMonthsLater)).orderBy('date', descending: false).get();
      upcomingEvent.value = snapshot.docs.map((doc) {
        return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      print(upcomingEvent);
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

  void getUserData()async{
    try{
      isLoading(true);
      DocumentSnapshot doc = await _firestore.collection('user').doc(uid).get();
      if (doc.exists) {
        user.value = userDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
    }catch(e){
      print("///////${e.toString()}///////");
    }finally{
      isLoading(false);
    }
  }

  void fetchCategoryEvent(String category)async{
    try {
      QuerySnapshot snapshot = await _firestore.collection('event').orderBy('date', descending: false).get();
      event.value = snapshot.docs.map((doc) {
        return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      categoryEvent.clear();
      categoryEvent.assignAll(event.where((event) => event.category == category.toLowerCase()).toList());
    } catch (e) {
      print("Error fetching event: $e");
    }
  }

  void getCoins()async{
    DocumentSnapshot userDoc = await _firestore.collection('user').doc(uid).get();
    if (userDoc.exists) {
      coins.value = userDoc['coin'] ?? 0;
    }
  }
}