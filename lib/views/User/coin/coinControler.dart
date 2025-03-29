import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class coinControler extends GetxController{
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var coinHistory = [].obs;
  var availableCoin=0.obs;

  void getCoinHistory()async{
    try {
      isLoading(true);
      getUserData();
      DatabaseEvent event = await _dbRef.child('users/$uid/coinHistory').once();
      DataSnapshot snapshot = event.snapshot;
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        List<Map<String, dynamic>> historyList = data.entries.map((entry) {
          return {
            'id': entry.key,
            'amount': entry.value['amount'] ?? 0,
            'title': entry.value['title'] ?? 'No Title',
            'type': entry.value['type'] ?? '',
            'timestamp': DateTime.fromMillisecondsSinceEpoch(entry.value['timestamp']) ?? 0,
          };
        }).toList();

        // Sort by timestamp (latest first)
        historyList.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

        // Update observable list
        coinHistory.value = historyList;
      }else {
        coinHistory.clear();
      }
    } catch (error) {
      print("Error retrieving bookmarks: $error");
    }finally{
      isLoading(false);
    }
  }
  void getUserData()async{
    try{
      isLoading(true);
      DocumentSnapshot doc = await _firestore.collection('user').doc(uid).get();
      if (doc.exists) {
        availableCoin.value = doc['coin'];
      }
    }catch(e){
      print("///////${e.toString()}///////");
    }finally{
      isLoading(false);
      print(availableCoin);
    }
  }
}