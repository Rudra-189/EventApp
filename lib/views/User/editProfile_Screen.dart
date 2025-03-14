import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_project_01/models/userModel.dart';
import 'package:event_project_01/utils/showSnackbar.dart';
import 'package:event_project_01/views/loaderControler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../App_Resources/App_Color.dart';
import '../../App_Resources/App_Screen_Size.dart';
import '../../App_Resources/widgets/button.dart';

class editProfileScreen extends StatefulWidget {
  editProfileScreen({super.key});

  @override
  State<editProfileScreen> createState() => _editProfileScreenState();
}

class _editProfileScreenState extends State<editProfileScreen> {

  loaderControler loader = Get.put(loaderControler());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late userDataModel data;

  @override
  void initState() {
    super.initState();
    data = Get.arguments;
    nameController.text = data.name;
    emailController.text = data.email;
    print(data.photo);
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
            data.photo.isEmpty ? Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 75,
                    top: 75,
                    child: GestureDetector(
                      onTap: (){
                        showBottomSheet(context);
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(Icons.edit,color: Colors.green.shade600,size: 10,),
                      ),
                    ),
                  )
                ],
              ),
            ) : Container(
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
              child: Stack(
                children: [
                  Positioned(
                    left: 75,
                    top: 75,
                    child: GestureDetector(
                      onTap: (){
                        print("hello");
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Icon(Icons.edit,color: Colors.green.shade600,size: 10,),
                      ),
                    ),
                  )
                ],
              ),
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
                editProfile(nameController.text.toString(), emailController.text.toString(),imageUrl);
              },
            ),
            SizedBox(height: height * 0.02,),
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context){

    final height = AppScreenSize.height(context);
    final width = AppScreenSize.width(context);

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,

      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  pickImage();
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/Gallery.svg'),
                      Text("From Gallery",style: TextStyle(color: Colors.black,fontSize: 12,letterSpacing: 1),)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/camera.svg'),
                      Text("Take Photo",style: TextStyle(color: Colors.black,fontSize: 12,letterSpacing: 1),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  File? _imageFile;
  String? imageUrl;
  Future<void> pickImage() async{
    ImagePicker imagePicker=ImagePicker();
    final file = await imagePicker.pickImage(source: ImageSource.gallery);

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
        Reference ref = FirebaseStorage.instance.ref().child('images/$uid/event photos/${DateTime.now().toString()}');
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

  void editProfile(String name,email,url)async{
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('user').doc(uid).update({
      "name" : name,
      "email" : email,
      'photo' : url
    }).whenComplete(() {
      showSnackBar.message(context, "Edit Profile success");
      Get.back();
      // Navigator.of(context).pop();
    },);
  }
}