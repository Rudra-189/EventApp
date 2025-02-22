import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/eventmodel.dart';

class eventDetailControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var selectedEvent = Rxn<eventDataModel>();

  var event = RxList<eventDataModel>();
  var categoryRelatedEvent = RxList<eventDataModel>();

  void fetchEventById(String id)async{
    try {
      isLoading(true);
      selectedEvent.value=null;
      DocumentSnapshot doc = await _firestore.collection('event').doc(id).get();
      if (doc.exists) {
        selectedEvent.value = eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        selectedEvent.value = null;
      }
    } catch (e) {
      print("Error fetching event: $e");
    }finally{
      isLoading(false);
    }
  }
  void fetchCategoryEventById(String category)async{
    try {
      categoryRelatedEvent.clear();
      QuerySnapshot snapshot = await _firestore.collection('event').get();
      event.value = snapshot.docs.map((doc) {
        return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      categoryRelatedEvent.assignAll(event.where((event) => event.category == category).toList());
    } catch (e) {
      print("Error fetching event: $e");
    }
  }
}