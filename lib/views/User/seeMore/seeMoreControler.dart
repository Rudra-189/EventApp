import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../models/eventmodel.dart';

class seeMoreControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var event = RxList<eventDataModel>();

  @override
  void onInit() {
    super.onInit();
    getEvent();
  }

  void getEvent()async{
    try{
      QuerySnapshot snapshot = await _firestore.collection('event').orderBy('date', descending: false).get();
      event.value = snapshot.docs.map((doc) {
        return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    }catch(e) {
      print("///////////${e.toString()}///////////");
    }finally{
      isLoading(false);
    }
  }
}