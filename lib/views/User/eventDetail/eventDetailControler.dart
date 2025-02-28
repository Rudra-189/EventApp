import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/userModel.dart';
import 'package:get/get.dart';

import '../../../models/eventmodel.dart';

class eventDetailControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isLoading = true.obs;
  var selectedEvent = Rxn<eventDataModel>();

  var OrganizerData = Rxn<userDataModel>();

  var event = RxList<eventDataModel>();
  var categoryRelatedEvent = RxList<eventDataModel>();

  void fetchEventById(String id,String category)async{
    try {
      isLoading(true);
      DocumentSnapshot doc = await _firestore.collection('event').doc(id).get();
      if (doc.exists) {
        selectedEvent.value = eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        fetchCategoryEventById(id,category);
        getUserData(selectedEvent.value!.organizer_id);
      } else {
        selectedEvent.value = null;
      }
    } catch (e) {
      print("Error fetching event: $e");
    }finally{
      isLoading(false);
    }
  }
  void fetchCategoryEventById(String id,String category)async{
    try {
      categoryRelatedEvent.clear();
      QuerySnapshot snapshot = await _firestore.collection('event').get();
      event.value = snapshot.docs.map((doc) {
        return eventDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      categoryRelatedEvent.assignAll(event.where((event) => event.category == category).where((event)=> event.id != id).toList());
    } catch (e) {
      print("Error fetching event: $e");
    }
  }

  void getUserData(String id)async{
    try{
      isLoading(true);
      DocumentSnapshot doc = await _firestore.collection('user').doc(id).get();
      if (doc.exists) {
        OrganizerData.value = userDataModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
    }catch(e){
      print("///////${e.toString()}///////");
    }finally{
      isLoading(false);
    }
  }

}