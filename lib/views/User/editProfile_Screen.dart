import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/userModel.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../App_Resources/App_Color.dart';
import '../../App_Resources/App_Screen_Size.dart';
import '../../App_Resources/widgets/button.dart';

class editProfileScreen extends StatefulWidget {
  editProfileScreen({super.key});

  @override
  State<editProfileScreen> createState() => _editProfileScreenState();
}

class _editProfileScreenState extends State<editProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late userDataModel data;

  @override
  void initState() {
    super.initState();
    data = Get.arguments;
    nameController.text = data.name;
    emailController.text = data.email;
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: (){
            Get.back();
            // Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,size: 20,color: Colors.white,),
        ),
        title: Text("EDIT PROFILE",style: TextStyle(color: Colors.white,fontSize: 16),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: height * 0.02,),
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(data.photo),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Positioned(
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.edit,color: Colors.green.shade600,size: 10,),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: height * 0.025,),
            Row(
              children: [
                Text("Name",style: TextStyle(color: Colors.white,fontSize: 14),),
              ],
            ),
            SizedBox(height: height * 0.01,),
            TextFormField(
              controller: nameController,
              cursorColor: AppColor.textColor,
              style: TextStyle(color:AppColor.textColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.textFiledBgColor,
                contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: AppColor.borderColor,
                        width: 0.25
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColor.secondaryColour,
                      width: 0.5,
                    )
                ),
              ),
            ),
            SizedBox(height: height * 0.025,),
            Row(
              children: [
                Text("Email",style: TextStyle(color: Colors.white,fontSize: 14),),
              ],
            ),
            SizedBox(height: height * 0.01,),
            TextFormField(
              controller: emailController,
              cursorColor: AppColor.textColor,
              style: TextStyle(color:AppColor.textColor),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.textFiledBgColor,
                contentPadding: EdgeInsets.symmetric(vertical: height *0.021,horizontal: width * 0.05),
                hintStyle: TextStyle(color: AppColor.hintColor,fontSize: 14),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                        color: AppColor.borderColor,
                        width: 0.25
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColor.secondaryColour,
                      width: 0.5,
                    )
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            GestureDetector(
              child: custom_Button(valu: "SAVE CHANGES"),
              onTap: (){
                if(data.name == nameController.text.toString() && data.email == emailController.text.toString()){
                  showSnackBar.error_message(context, "Please Change any thing");
                }else{
                  editProfile(nameController.text.toString(), emailController.text.toString());
                }
              },
            ),
            SizedBox(height: height * 0.02,),
          ],
        ),
      ),
    );
  }
  void editProfile(String name,email)async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      "name" : name,
      "email" : email
    }).whenComplete(() {
      showSnackBar.message(context, "Edit Profile success");
      Get.back();
      // Navigator.of(context).pop();
    },);
  }
}
//Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircleAvatar(
//                   radius: width * 0.125,
//                   backgroundImage: NetworkImage(widget.userData.photo),
//                 )
//               ],
//             ),