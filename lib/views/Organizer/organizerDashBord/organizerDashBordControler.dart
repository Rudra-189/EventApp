import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/eventmodel.dart';
import 'package:event_project_01/models/ticketModel.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class organizerDashBordControler extends GetxController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;

  var canceledTicketCount = 0.obs;
  var ticketCount = 0.obs;
  var earningCount = 0.obs;

  void getMyEvent()async{
    try{
      isLoading(true);
      canceledTicketCount.value = 0;
      ticketCount.value = 0;
      earningCount.value = 0;
      QuerySnapshot snapshot = await _firestore.collection('event').where('organizer_id', isEqualTo: uid).get();

      if(snapshot.docs.isNotEmpty){
        List<String> eventIds = snapshot.docs.map((doc) => doc.id).toList();
        print(eventIds.toString());
        if (eventIds.isNotEmpty) {
          getInformation(eventIds);
        }
      }
    }catch(e){
      debugPrint('#//////${e.toString()}//////#');
    }finally{
      isLoading(false);
    }
  }

  void getInformation(List<String> eventIds)async{
    try {
      isLoading(true);
      QuerySnapshot snapshot1 = await _firestore.collection('cancel').where('eventId', whereIn: eventIds).get();
      QuerySnapshot snapshot2 = await _firestore.collection('ticket').where('event_id', whereIn: eventIds).get();
      QuerySnapshot snapshot3 = await _firestore.collection('payments').where('organizerId', isEqualTo: uid).get();
      canceledTicketCount.value = snapshot1.docs.length; // Store count
      ticketCount.value = snapshot2.docs.length; // Store count

      for (var doc in snapshot3.docs) {
        var data = doc.data() as Map<String, dynamic>;
        earningCount += (data['amount'] ?? 0); // Sum refund amounts
      }

    } catch (e) {
      print("Error fetching canceled tickets: $e");
    }finally{
      isLoading(false);
    }
  }

  String qrResult = '';

  void scanBarcode(BuildContext context)async{
    try{
      qrResult = '';
      qrResult = (await SimpleBarcodeScanner.scanBarcode(
        context,
        barcodeAppBar: const BarcodeAppBar(
          appBarTitle: 'Test',
          centerTitle: false,
          enableBackButton: true,
          backButtonIcon: Icon(Icons.arrow_back_ios),
        ),
        isShowFlashIcon: true,
        delayMillis: 2000,
        cameraFace: CameraFace.back,
      )).toString();
      getUserTicket(context, qrResult);
    }catch(e){
      print("/////////${e.toString()}////////");
    }finally{
      print(qrResult);
    }
  }

  void getUserTicket(BuildContext context,String id)async{
    try {
      final querySnapshot = await _firestore.collection('ticket').where('qr_code',isEqualTo: id).get();
      if (querySnapshot.docs.isNotEmpty) {

        var doc = querySnapshot.docs.first;
        var userTicket = ticketDataModel.fromMap(doc.data(), doc.id);

        if(userTicket.status == "booked"){
          showSnackBar.message(context, "Ticket is Found");
        }else if(userTicket.status == "pending"){
          showSnackBar.error_message (context, "Ticket is Under Cancellation");
        }
      }else{
        showSnackBar.error_message(context, "Ticket not Found");
      }
    } catch (e) {
      print("Error fetching event: $e");
    }finally{

    }
  }
}