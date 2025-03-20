import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class helpandfaqs_Screen extends StatefulWidget {
  const helpandfaqs_Screen({super.key});

  @override
  State<helpandfaqs_Screen> createState() => _helpandfaqs_ScreenState();
}

class _helpandfaqs_ScreenState extends State<helpandfaqs_Screen> {

  final List<Map<String, String>> faqs = [
    {"question": "How to book a ticket?", "answer": "Go to the event page and click 'Book Now'."},
    {"question": "Can I cancel my ticket?", "answer": "Yes, you can cancel within 24 hours before the event."},
    {"question": "How will I receive my ticket?", "answer": "Your ticket will be show in my ticket section you can also download and share ticket"},
    {"question": "What payment methods are accepted?", "answer": "We accept Credit/Debit cards, UPI, g pay, and Razorpay."},
    {"question": "Is my payment secure?", "answer": "Yes, we use encrypted payment gateways for secure transactions."},
    {"question": "Can I transfer my ticket to someone else?", "answer": "No, tickets are non-transferable and linked to your account."},
    {"question": "What if an event is canceled?", "answer": "If an event is canceled, you will receive a full refund automatically with in 7 days."},
    {"question": "How can I contact customer support?", "answer": "You can reach us via email at support@eventapp.com or call +91 98765 43210."},
    {"question": "Do I need to print my ticket?", "answer": "No, you can show your digital ticket with the QR code at entry."},
    {"question": "Can I get a refund after the event starts?", "answer": "No, refunds are only available before the event begins."},
    {"question": "How do I change my account details?", "answer": "Go to 'Profile' > 'Edit Profile' to update your details."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 18,),
        ),
        title: Text("Help & FAQs",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            iconColor: Colors.green.shade600,
            title: Text(faqs[index]['question']!,style: TextStyle(color: Colors.white,fontSize: 14),),
            children: [
              Padding(padding: EdgeInsets.all(10),
                child: Text(faqs[index]['answer']!,style: TextStyle(color: Colors.white,fontSize: 14)),
              ),
            ],
          );
        },
      ),
    );
  }
}
