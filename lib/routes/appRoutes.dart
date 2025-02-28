import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/views/Organizer/addEvent/addEvent_Screen.dart';
import 'package:event_project_01/views/Organizer/myEvent/myEvent_Screen.dart';
import 'package:event_project_01/views/Organizer/organizerDashBord/organizerDashBord_Screen.dart';
import 'package:event_project_01/views/Organizer/organizerProfile_Screen.dart';
import 'package:event_project_01/views/Organizer/ticketBooked/ticketBooked_Screen.dart';
import 'package:event_project_01/views/User/Explore/explore_Screen.dart';
import 'package:event_project_01/views/User/bottomNavbar_Screen.dart';
import 'package:event_project_01/views/User/editProfile_Screen.dart';
import 'package:event_project_01/views/User/eventDetail/eventDetail_Screen.dart';
import 'package:event_project_01/views/User/search/search_Screen.dart';
import 'package:event_project_01/views/User/ticket/ticket_Screen.dart';
import 'package:event_project_01/views/User/ticketBooking/ticketBooking_Scereen.dart';
import 'package:event_project_01/views/User/userProfile/userProfile_Screen.dart';
import 'package:event_project_01/views/auth/forgotPassword_Screen.dart';
import 'package:event_project_01/views/auth/login_Screen.dart';
import 'package:event_project_01/views/auth/photoUpload_Screen.dart';
import 'package:event_project_01/views/auth/signup_Screen.dart';
import 'package:event_project_01/views/auth/splash_Screen.dart';
import 'package:get/get.dart';

class appRoutes{
  static final getRouts =[
    //auth routes
    GetPage(
      name: appRoutesName.initialScreen,
      page: ()=>splashScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.loginScreen,
      page: ()=>loginScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.signupScreen,
      page: ()=>signupScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.forgotPasswordScreen,
      page: ()=>forgotPasswordScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.photoUploadScreen,
      page: ()=>photoUploadScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),

    //organizer routes
    GetPage(
      name: appRoutesName.organizerDashBordScreen,
      page: ()=>organizerDashBordScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.addEventScreen,
      page: ()=>addEventScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.myEventScreen,
      page: ()=>myEventScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.ticketBookedScreen,
      page: ()=>ticketBookedScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.organizerProfileScreen,
      page: ()=>organizerProfileScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),

    //user routes
    GetPage(
      name: appRoutesName.bottomNavbarScreen,
      page: ()=>bottomNavbarScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.exploreScreen,
      page: ()=>exploreScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.searchScreen,
      page: ()=>searchScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.eventDetailScreen,
      page: ()=>eventDetailScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),//this
    GetPage(
      name: appRoutesName.ticketScreen,
      page: ()=>ticketScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.ticketBookingScreen,
      page: ()=>ticketBookingScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.userProfileScreen,
      page: ()=>userProfileScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: appRoutesName.editProfileScreen,
      page: ()=>editProfileScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
  ];
}