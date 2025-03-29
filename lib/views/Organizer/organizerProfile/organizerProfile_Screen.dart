import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/views/Organizer/organizerProfile/organizerProfileControler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../App_Resources/App_Screen_Size.dart';
import '../editProfile/organizerEditProfile.dart';

class organizerProfileScreen extends StatefulWidget {
  const organizerProfileScreen({super.key});

  @override
  State<organizerProfileScreen> createState() => _organizerProfileScreenState();
}

class _organizerProfileScreenState extends State<organizerProfileScreen> {

  final organizerProfileControler controler = Get.put(organizerProfileControler());

  @override
  void initState() {
    super.initState();
    controler.getUserData();
  }

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
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Obx(() {
        if(controler.isLoading.value){
          return Center(child: CircularProgressIndicator(color: Colors.green.shade600,));
        }else{
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  controler.user.value!.photo.isEmpty ? CircleAvatar(
                    radius: height * 0.05,
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ) : CircleAvatar(
                    radius: height * 0.05,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    backgroundImage: NetworkImage(controler.user.value!.photo),
                  ),
                  Obx(() {
                    return Text(controler.user.value!.name,style: TextStyle(color: Colors.green.shade600,fontSize: 16),);
                  },),
                  Text(controler.user.value!.email,style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 13),),
                  SizedBox(height: height * 0.05,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(appRoutesName.organizerEditProfileScreen,arguments: controler.user.value!);
                    },
                    child: Container(
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
                  ),
                  SizedBox(height: height * 0.02,),
                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
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
          );
        }
      },),
    );
  }

  void Signout()async{
    final auth = FirebaseAuth.instance;
    auth.signOut().then((value) {
      Get.offAllNamed(appRoutesName.loginScreen);
    },);
  }
}

