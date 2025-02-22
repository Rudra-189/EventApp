import 'package:event_project_01/Screens/Add_Screen.dart';
import 'package:event_project_01/Screens/Event_Screen.dart';
import 'package:event_project_01/Screens/Explore/Explore_Screen.dart';
import 'package:event_project_01/Screens/Location_Screen.dart';
import 'package:event_project_01/Screens/Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../App_Resources/App_Color.dart';

class BouttomNavbar extends StatefulWidget {
  const BouttomNavbar({super.key});

  @override
  State<BouttomNavbar> createState() => _BouttomNavbarState();
}

class _BouttomNavbarState extends State<BouttomNavbar> {

  int _curentIndex = 0;

  PageController pageController=PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColour,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          ExploreScreen(),
          EventScreen(),
          AddScreen(),
          LocationScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar:GNav(
        tabMargin: EdgeInsets.only(top: 10,bottom: 5),
        gap: 10,
        selectedIndex: _curentIndex,
        color: AppColor.iconColor,
        activeColor: Colors.green.shade600,
        padding: EdgeInsets.all(15),
        backgroundColor: Colors.black,
        iconSize: 20,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        haptic: true,
        curve: Curves.bounceIn,
        tabs:[
          GButton(
            icon: Icons.explore,
            // text: 'explore',
          ),
          GButton(
            icon: Icons.event,
            // text: 'event',
          ),
          GButton(
            icon: Icons.add_circle,
            // text: 'Add',
          ),
          GButton(
            icon: Icons.location_pin,
            // text: 'location',
          ),
          GButton(
            icon: Icons.person,
            // text: 'profile',
          ),
        ],
        onTabChange: (int index) {
          setState(() {
            _curentIndex = index;
            pageController.jumpToPage(_curentIndex);
          });
        },
      ),
    );
  }
}

