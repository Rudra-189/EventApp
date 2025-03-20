import 'package:event_project_01/views/User/calender/calender_Screen.dart';
import 'package:event_project_01/views/User/ticket/ticket_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../App_Resources/App_Color.dart';
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
          calenderScreen(),
          ticketScreen(),
          userProfileScreen()
        ],
      ),
      bottomNavigationBar:GNav(
        tabMargin: EdgeInsets.only(top: 0,bottom: 0),
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
            icon: Icons.circle,
            leading: Column(
              children: [
                Icon(Icons.explore,size: 20,color: _curentIndex == 0 ? Colors.green.shade600 : Colors.white.withOpacity(0.25),),
                Text("explore",style: TextStyle(color: _curentIndex == 0 ? Colors.white : Colors.white.withOpacity(0.25),fontSize: 10),)
              ],
            ),
            // text: 'explore',
          ),
          GButton(
            icon: Icons.circle,
            leading: Column(
              children: [
                Icon(Icons.event,size: 20,color: _curentIndex == 1 ? Colors.green.shade600 : Colors.white.withOpacity(0.25),),
                Text("calender",style: TextStyle(color: _curentIndex == 1 ? Colors.white : Colors.white.withOpacity(0.25),fontSize: 10),)
              ],
            ),
            // text: 'event',
          ),
          GButton(
            leading: Column(
              children: [
                SvgPicture.asset(
                  "assets/images/ticket.svg",
                  width: 30,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    _curentIndex == 2 ? Colors.green.shade600 : Colors.white.withOpacity(0.25), // Change color when selected
                    BlendMode.srcIn,
                  ),
                ),
                Text("ticket",style: TextStyle(color: _curentIndex == 2 ? Colors.white : Colors.white.withOpacity(0.25),fontSize: 10),)
              ],
            ),
            icon: Icons.circle,
            // text: 'location',
          ),
          GButton(
            icon: Icons.circle,
            leading: Column(
              children: [
                Icon(Icons.person,size: 20,color: _curentIndex == 3 ? Colors.green.shade600 : Colors.white.withOpacity(0.25),),
                Text("profile",style: TextStyle(color: _curentIndex == 3 ? Colors.white : Colors.white.withOpacity(0.25),fontSize: 10),)
              ],
            ),
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

