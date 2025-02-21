import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "John Doe";
  String email = "johndoe@example.com";
  String phone = "+1234567890";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Profile",style: TextStyle(color: Colors.white,fontSize: 18),),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 20,),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 12),
            Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
            // Text(email, style: TextStyle(fontSize: 16, color: Colors.grey)),
            // Text(phone, style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 30),
            Divider(endIndent: 35,indent: 35,thickness: 0.3,),
            SizedBox(height: 14),
            ListTile(leading: Icon(Icons.edit,color: Colors.white), title: Text("Edit Profile",style: TextStyle(color: Colors.white),), onTap: () async {
              // final result = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => EditProfileScreen(name, email, phone),
              //   ),
              // );
              // if (result != null) {
              //   setState(() {
              //     name = result["name"];
              //     email = result["email"];
              //     phone = result["phone"];
              //   });
              // }
            },),
            SizedBox(height: 10),
            ListTile(leading: Icon(Icons.settings,color: Colors.white,), title: Text("Settings",style: TextStyle(color: Colors.white)), onTap: () {}),
            SizedBox(height: 10),
            ListTile(leading: Icon(Icons.calendar_month,color: Colors.white), title: Text("Calender",style: TextStyle(color: Colors.white)), onTap: () {}),
            SizedBox(height: 10),
            ListTile(leading: Icon(Icons.bookmark,color: Colors.white), title: Text("Bookmark",style: TextStyle(color: Colors.white)), onTap: () {}),
            SizedBox(height: 10),
            ListTile(leading: Icon(Icons.email,color: Colors.white), title: Text("Contact Us",style: TextStyle(color: Colors.white)), onTap: () {}),
            SizedBox(height: 10),
            ListTile(leading: Icon(Icons.help,color: Colors.white), title: Text("Help & FAQs",style: TextStyle(color: Colors.white)), onTap: () {}),
            SizedBox(height: 10),
            ListTile(leading: Icon(Icons.logout,color: Colors.white), title: Text("Logout",style: TextStyle(color: Colors.white)), onTap: () {}),
          ],
        ),
      ),
    );
  }
}

