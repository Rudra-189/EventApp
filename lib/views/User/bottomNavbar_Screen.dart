import 'package:event_project_01/views/User/ticket/ticket_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../App_Resources/App_Color.dart';
import 'Add_Screen.dart';
import 'Event_Screen.dart';
import 'Explore/explore_Screen.dart';
import 'userProfile/userProfile_Screen.dart';

class bottomNavbarScreen extends StatefulWidget {
  const bottomNavbarScreen({super.key});

  @override
  State<bottomNavbarScreen> createState() => _bottomNavbarScreenState();
}

class _bottomNavbarScreenState extends State<bottomNavbarScreen> {

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
          exploreScreen(),
          EventScreen(),
          AddScreen(),
          ticketScreen(),
          userProfileScreen()
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
            icon: Icons.airplane_ticket,
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

