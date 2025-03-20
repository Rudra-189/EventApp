import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/eventmodel.dart';

class bookmarkControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var bookmarks = RxList<eventDataModel>();

  @override
  void onInit() {
    super.onInit();
    print("bookmark");
    fetchBookmarkedEvents();
  }

  Future<void> fetchBookmarkedEvents() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid/bookmark");
    try {
      isLoading(true);
      DatabaseEvent event = await ref.once();
      if (event.snapshot.exists) {
        Map<dynamic, dynamic>? bookmarks = event.snapshot.value as Map?;
        if (bookmarks != null) {
          List<String> eventIds = bookmarks.keys.cast<String>().toList();
          await fetchEventDetails(eventIds);
          print(eventIds);
        }
      }
    } catch (error) {
      print("Error retrieving bookmarks: $error");
    }finally{
      isLoading(false);
    }
  }

  Future<void> fetchEventDetails(List<String> eventIds) async {
    try{
      isLoading(true);
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('event').where('id', whereIn: eventIds).get();

      if(snapshot.docs.isNotEmpty){
        bookmarks.assignAll(snapshot.docs.map((doc) {
          return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }).toList());
      }

    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
      print(bookmarks.toString());
    }
  }
}