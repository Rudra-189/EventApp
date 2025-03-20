import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class contactusScreen extends StatefulWidget {
  const contactusScreen({super.key});

  @override
  State<contactusScreen> createState() => _contactusScreenState();
}

class _contactusScreenState extends State<contactusScreen> {
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
          child: Icon(Icons.arrow_back,size: 18,color: Colors.white,),
        ),
        title: Text("CONTACT US",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("You can get in touch with us through below platforms.Our Team will reach out to you as soon as it would be possible.",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 10),),
            SizedBox(height: 25,),
            Container(
              height: 200,
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Customer Support",style: TextStyle(color: Colors.white,fontSize: 14),),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.phone,color: Colors.green.shade600,size: 18,),
                    ),
                    title: Text("Contact Number",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12),),
                    subtitle: Text("+91 9510758778",style: TextStyle(color: Colors.white,fontSize: 14),),
                  ),
                  ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.email_outlined,color: Colors.green.shade600,size: 18,),
                    ),
                    title: Text("Email Address",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12),),
                    subtitle: Text("eventera@gmail.com",style: TextStyle(color: Colors.white,fontSize: 14),),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25,),
            Container(
              height: 275,
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Social Media",style: TextStyle(color: Colors.white,fontSize: 14),),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/images/instagram.svg"),
                    ),
                    title: Text("Instagram",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12),),
                    subtitle: Text("@event_era",style: TextStyle(color: Colors.white,fontSize: 14),),
                  ),
                  ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/images/twitter.svg",height: 30,),
                    ),
                    title: Text("Twitter",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12),),
                    subtitle: Text("@event_era",style: TextStyle(color: Colors.white,fontSize: 14),),
                  ),
                  ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/images/facebook.svg",height: 25,color: Colors.blue,),
                    ),
                    title: Text("Facebook",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 12),),
                    subtitle: Text("@event_era",style: TextStyle(color: Colors.white,fontSize: 14),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
