import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class userProfileControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var user = Rxn<userDataModel>();

  @override
  void onInit() {
    super.onInit();
    getUserData();
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
}