import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/utils/coinBox.dart';
import 'package:event_project_01/utils/coinSystem.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:event_project_01/views/User/bottomNavbar_Screen.dart';
import 'package:event_project_01/views/loaderControler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../App_Resources/App_Screen_Size.dart';
import '../../App_Resources/widgets/button.dart';

class photoUploadScreen extends StatefulWidget {
  const photoUploadScreen({super.key});

  @override
  State<photoUploadScreen> createState() => _photoUploadScreenState();
}

class _photoUploadScreenState extends State<photoUploadScreen> {

  final loaderControler loader = Get.put(loaderControler());

  String? role;

  @override
  void initState() {
    super.initState();
    role = Get.arguments['role'];
  }

  @override
  Widget build(BuildContext context) {

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.075,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Upload Your Photo Profile",style: TextStyle(color: Colors.white,fontSize: 18),)
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("This data will be displayed in your account",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 14),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("profile for security",style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 14),)
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            GestureDetector(
              onTap: (){
                pickImageFromGallery();
              },
              child: Container(
                height: height * 0.2,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/Gallery.svg'),
                      Text("From Gallery",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: (){
                pickImageCamera();
              },
              child: Container(
                height: height * 0.2,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/camera.svg'),
                      Text("Tack Photo",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            GestureDetector(
              child: custom_Button(valu: "Next"),
              onTap: (){
                if(imageUrl != null){
                  addPhoto(role!);
                }else{
                  showSnackBar.error_message(context,"pick image first");
                }
              },
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    if(role == "User"){
                      Get.offAllNamed(appRoutesName.welcomeCoinScreen);

                    }else{
                      Get.offAllNamed(appRoutesName.organizerDashBordScreen);
                    }
                  },
                  child: Text("skip",style: TextStyle(color: Colors.green,fontSize: 12,letterSpacing: 1),),
                )
              ],
            ),
            SizedBox(
              height: height * 0.025,
            ),
          ],
        ),
      ),
    );
  }
  File? _imageFile;
  String? imageUrl;
  Future<void> pickImageFromGallery() async{
    ImagePicker imagePicker=ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);

    if(file!=null){
      setState(() {
        _imageFile = File(file.path);
      });
      uploadImage();
    }
  }
  Future<void> pickImageCamera() async{
    ImagePicker imagePicker=ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.camera);

    if(file!=null){
      setState(() {
        _imageFile = File(file.path);
      });
      uploadImage();
    }
  }
  Future<void>uploadImage()async{
    final uid = FirebaseAuth.instance.currentUser!.uid;

    if(_imageFile !=null){
      try{
        loader.startLoading();
        Reference ref = FirebaseStorage.instance.ref().child('images/$uid/user photo');
        UploadTask uploadTask = ref.putFile(_imageFile!);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        setState(() {
          imageUrl = downloadURL;
        });

        print("Image Url : $downloadURL");
      }catch(e){
        print("/////////////////${e.toString()}/////////////////");
      }finally{
        loader.stopLoading();
      }
    }
  }
  Future<void>addPhoto(String role)async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      'photo':imageUrl
    }).whenComplete(() {
      if(role == "User"){
        Get.offAllNamed(appRoutesName.welcomeCoinScreen);
      }else{
        Get.offAllNamed(appRoutesName.organizerDashBordScreen);
      }
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => bottomNavbarScreen()),(Route<dynamic> route) => false);
    },);
  }
}
