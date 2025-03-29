import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/eventmodel.dart';
import 'package:event_project_01/models/ticketModel.dart';
import 'package:event_project_01/utils/coinBox.dart';
import 'package:event_project_01/utils/coinSystem.dart';
import 'package:event_project_01/views/loaderControler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../models/userModel.dart';
import '../../../routes/appRoutesName.dart';
import '../../../utils/notification.dart';


class ticketBookingControler extends GetxController {

  final loaderControler loader = Get.put(loaderControler());

  late Razorpay _razorpay;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  var isLoading = true.obs;
  var user = Rxn<userDataModel>();

  int bookedTicket = 0;


  int seats = 0;
  int total = 0;
  String? type;
  eventDataModel? event;
  int discount = 0;
  int coin = 0;



  @override
  void onInit() {
    super.onInit();
    getUserData();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void getData(int s,d,c,String t,eventDataModel data){
    seats = s;
    type = t;
    event = data;
    discount = d;
    coin = c;
    if(discount != 0){
      if(type == "economy"){
        total = event!.price.Economy * seats;
        total = (total -(total*(discount/100))).toInt();
      }else if(type == "vip"){
        total = event!.price.VIP * seats;
        total = (total -(total*(discount/100))).toInt();
      }
    }else{
      if(type == "economy"){
        total = event!.price.Economy * seats;
      }else if(type == "vip"){
        total = event!.price.VIP * seats;
      }
    }
    print(total);
    print(discount);
    print(coin);
    openCheckout();
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

  /// Open Razorpay Checkout
  void openCheckout() {
    var options = {
      'key': 'rzp_test_gLDbd5ZAHE1E4P', // Replace with your Razorpay Key ID
      'amount': (total * 100).toInt(), // Convert to paise
      'name': 'Event Ticket Payment',
      'description': 'Payment for Event ID: ${event!.id}',
      'prefill': {
        'contact': '9876543210', // Replace with user contact
        'email': user.value!.email, // Replace with user email
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("/////////${e.toString()}///////////");
    }
  }

  /// Handle Successful Payment
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    loader.startLoading();
    if(discount != 0){
      print("inside coin -");
      print(discount !=0 );
      coinSystem.addCoin(coin, "used coin to booked Ticket", "spend");
    }
    final uid = FirebaseAuth.instance.currentUser!.uid;
    var random = Random();
    int randomNumber = random.nextInt(10000000);
    String id ="TICKET$randomNumber";
    String code = randomNumber.toString()+uid;
    print(uid);
    NotificationService.showNotification(title: "Ticket Booked", body: "Your ticket for ${event!.title} on ${DateFormat('MM/dd/yyyy').format(event!.date)} is confirmed! Check your Ticket.Get ready for an amazing experience!");
    // NotificationService.Notification_message("Ticket Booked", "Your ticket for ${event!.title} on ${DateFormat('MM/dd/yyyy').format(event!.date)} is confirmed! Check your Ticket.Get ready for an amazing experience!");
    await FirebaseFirestore.instance.collection('ticket').doc(id).set({
      "id": id,
      "user_id": uid,
      "event_id": event!.id,
      "type" : type,
      "seat" : seats,
      "qr_code" : code,
      "event_data" : {
        "title" : event!.title,
        "date" : event!.date,
        "img" : event!.img,
        "location" : event!.location
      },
      "status" : "booked",
      "payment_id" : response.paymentId,
      "timestamp": FieldValue.serverTimestamp()
    }).whenComplete(()async{
      if(type == 'vip'){
        await FirebaseFirestore.instance.collection('event').doc(event!.id).update({
          "availableSeats" : {
            "VIP" : (event!.availableSeats.VIP - seats),
            "Economy" : event!.availableSeats.Economy
          }
        });
      }
      if(type == 'economy'){
        await FirebaseFirestore.instance.collection('event').doc(event!.id).update({
          "availableSeats" : {
            "VIP" : event!.availableSeats.VIP,
            "Economy" : (event!.availableSeats.Economy - seats),
          }
        });
      }
    },).then((value)async{
      await _firestore.collection("payments").doc(response.paymentId).set({
        "id" : response.paymentId,
        "userId": user.value!.id,
        "eventId": event!.id,
        "organizerId" : event!.organizer_id,
        "ticketId" : id,
        "amount": total,
        "discount" : discount,
        "status": "Success",
        "timestamp": FieldValue.serverTimestamp(),
      });
    },).whenComplete(() {
      loader.stopLoading();
      coinSystem.addCoin(((total ~/ 100) * 3).toInt(), "got coins for booking a ticket!", "reward");
      Future.delayed(Duration(seconds: 5),() => showRewardDialog("🏆 You got coins for booking a ticket!",((total ~/ 100) * 3).toInt()),);
      Get.offAllNamed(appRoutesName.bottomNavbarScreen,arguments: {
        'bookedTicket' : true,
        'coin' : ((total ~/ 100) * 3).toInt()
      });
    },);

    // Store payment details in Firebase
  }

  /// Handle Payment Failure

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.offAllNamed(appRoutesName.bottomNavbarScreen);
  }


  @override
  void onClose() {
    _razorpay.clear(); // Clean up
    super.onClose();
  }

  void getBookedTicket(String id)async{
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('ticket')
          .where('event_id', isEqualTo: id)
          .where('user_id', isEqualTo: uid)
          .get();
      for (var doc in querySnapshot.docs) {
        bookedTicket += (doc['seat'] as int);
      }
    }catch(e){
      print("///////////${e.toString()}/////////");
    }finally{
      print(bookedTicket);
    }
  }
}
