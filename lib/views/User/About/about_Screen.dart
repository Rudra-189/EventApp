import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../App_Resources/App_Screen_Size.dart';

class aboutScreen extends StatefulWidget {
  const aboutScreen({super.key});

  @override
  State<aboutScreen> createState() => _aboutScreenState();
}

class _aboutScreenState extends State<aboutScreen> {
  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Icon(Icons.arrow_back,size: 18,color: Colors.white,),
        ),
        title: Text("ABOUT",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Logo
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/BG Event Era.png', height: 150), // Add your app logo in assets
                ],
              ),
            ),
            SizedBox(height: 10),

            // Short Description
            Text(
              "Welcome to Event Ticket Booking, the ultimate platform for discovering and booking events seamlessly. "
                  "Explore exciting events, book tickets, and enjoy a hassle-free experience!",
              style: TextStyle(fontSize: 14,color: Colors.white),
            ),
            SizedBox(height: 20),

            // Key Features
            Text("🔹 Key Features:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
            SizedBox(height: 5),
            Text("✅ Browse and discover upcoming events.",style: TextStyle(fontSize: 12,color: Colors.white)),
            Text("✅ Book tickets instantly with secure payments.",style: TextStyle(fontSize: 12,color: Colors.white)),
            Text("✅ Get event notifications and reminders.",style: TextStyle(fontSize: 12,color: Colors.white)),
            Text("✅ QR code-based check-in for easy entry.",style: TextStyle(fontSize: 12,color: Colors.white)),
            Text("✅ Manage your bookings and cancellations.",style: TextStyle(fontSize: 12,color: Colors.white)),
            SizedBox(height: 20),

            // Version Info
            Text("📌 App Version: 1.0.0", style: TextStyle(fontSize: 14,color: Colors.white)),
            Text("📅 Last Updated: March 2025",style: TextStyle(fontSize: 14,color: Colors.white)),
            SizedBox(height: 20),

            // Contact & Support
            Text("📞 Contact & Support", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white)),
            Text("📩 Email: support@eventera.com",style: TextStyle(fontSize: 14,color: Colors.white)),
            Text("🌐 Website: www.eventera.com",style: TextStyle(fontSize: 14,color: Colors.white)),
            SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Text("📜 Terms & Conditions", style: TextStyle(fontSize: 16, color: Colors.blue)),
                  SizedBox(height: 10,),
                  Text("🔒 Privacy Policy", style: TextStyle(fontSize: 16, color: Colors.blue)),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
