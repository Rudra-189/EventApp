import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class coinSystem{

  static void addCoin(int coin,String title,type){
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final DatabaseReference databaseRef = FirebaseDatabase.instance.ref("users/$uid/coinHistory");

    String? id = databaseRef.push().key;

    databaseRef.child('${id}').set({
      'id' : id,
      'amount': coin,
      'title': title,
      'type': type,
      'timestamp': ServerValue.timestamp
    });
    updateCoin(uid,type,coin);
  }

  static void updateCoin(String id,type,int coin)async{

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('user').doc(id).get();

    int currentFirestoreCoins = userSnapshot['coin'];

    if(type == "reward"){
      await FirebaseFirestore.instance.collection('user').doc(id).update({
        'coin' : (currentFirestoreCoins + coin)
      });
    }else if(type == "spend"){
      await FirebaseFirestore.instance.collection('user').doc(id).update({
        'coin' : (currentFirestoreCoins - coin)
      });
    }

  }
}