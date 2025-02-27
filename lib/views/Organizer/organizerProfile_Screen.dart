import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../App_Resources/App_Screen_Size.dart';
import '../auth/login_Screen.dart';

class organizerProfileScreen extends StatefulWidget {
  const organizerProfileScreen({super.key});

  @override
  State<organizerProfileScreen> createState() => _organizerProfileScreenState();
}

class _organizerProfileScreenState extends State<organizerProfileScreen> {
  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.back();
            // Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),
        ),
        title: Text("PROFILE",style: TextStyle(color: Colors.white,fontSize: 18),),
        backgroundColor: Colors.green.shade600,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              CircleAvatar(
                radius: height * 0.05,
              ),
              Text("John Done",style: TextStyle(color: Colors.green.shade600,fontSize: 16),),
              Text("JohnDone@gmail.com",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 13),),
              SizedBox(height: height * 0.05,),
              Container(
                height: height * 0.065,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.095),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  leading: Icon(Icons.person,color: Colors.green.shade600,size: 20,),
                  title: Text("Edite Profile",style: TextStyle(color: Colors.white,fontSize: 14),),
                  trailing: Icon(Icons.arrow_right,color: Colors.green.shade600,size: 20,),
                ),
              ),
              SizedBox(height: height * 0.02,),
              Container(
                height: height * 0.065,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.095),
                  borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  leading: Icon(Icons.message_outlined,color: Colors.green.shade600,size: 20,),
                  title: Text("Massage",style: TextStyle(color: Colors.white,fontSize: 14),),
                  trailing: Icon(Icons.arrow_right,color: Colors.green.shade600,size: 20,),
                ),
              ),
              SizedBox(height: height * 0.02,),
              Container(
                height: height * 0.065,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.095),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  leading: Icon(Icons.bookmark_border,color: Colors.green.shade600,size: 20,),
                  title: Text("Bookmark",style: TextStyle(color: Colors.white,fontSize: 14),),
                  trailing: Icon(Icons.arrow_right,color: Colors.green.shade600,size: 20,),
                ),
              ),
              SizedBox(height: height * 0.02,),
              Container(
                height: height * 0.065,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.095),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  leading: Icon(Icons.mail,color: Colors.green.shade600,size: 20,),
                  title: Text("Contact Us",style: TextStyle(color: Colors.white,fontSize: 14),),
                  trailing: Icon(Icons.arrow_right,color: Colors.green.shade600,size: 20,),
                ),
              ),
              SizedBox(height: height * 0.02,),
              Container(
                height: height * 0.065,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.095),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  leading: Icon(Icons.settings,color: Colors.green.shade600,size: 20,),
                  title: Text("Settings",style: TextStyle(color: Colors.white,fontSize: 14),),
                  trailing: Icon(Icons.arrow_right,color: Colors.green.shade600,size: 20,),
                ),
              ),
              SizedBox(height: height * 0.02,),
              Container(
                height: height * 0.065,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.095),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: ListTile(
                  leading: Icon(Icons.help_outline,color: Colors.green.shade600,size: 20,),
                  title: Text("Helps & FAQs",style: TextStyle(color: Colors.white,fontSize: 14),),
                  trailing: Icon(Icons.arrow_right,color: Colors.green.shade600,size: 20,),
                ),
              ),
              SizedBox(height: height * 0.02,),
              GestureDetector(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Expanded(
                        child: AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0), // Change the shape here
                          ),
                          title: Row(
                            children: [
                              Icon(Icons.warning_amber_rounded,color: Colors.green.shade600,),
                              SizedBox(width: 10,),
                              Text('Sign out',style: TextStyle(fontSize: 16),),
                            ],
                          ),
                          content: Text('Do You Want Signout?'),
                          actions: [
                            GestureDetector(
                              onTap:(){
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel",style: TextStyle(color: Colors.green.shade600),),
                            ),
                            SizedBox(width: 5,),
                            GestureDetector(
                              onTap:(){
                                Signout();
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 30,
                                width: 50,
                                decoration: BoxDecoration(color: Colors.green.shade600),
                                child: Center(child: Text("Ok",style: TextStyle(color: Colors.white),)),
                              ),
                            )
                          ],

                        ),
                      );
                    },
                  );
                },
                child: Container(
                  height: height * 0.065,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.095),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: ListTile(
                    leading: Icon(Icons.login_outlined,color: Colors.green.shade600,size: 20,),
                    title: Text("Sign Out",style: TextStyle(color: Colors.white,fontSize: 14),),
                    trailing: Icon(Icons.arrow_right,color: Colors.green.shade600,size: 20,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void Signout()async{
    final auth = FirebaseAuth.instance;
    auth.signOut().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginScreen(),));
    },);
  }
}

