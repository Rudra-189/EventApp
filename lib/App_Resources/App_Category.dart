import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'App_Icon.dart';

abstract class AppCategory{

  static List<Map<String,dynamic>>category = [
    {
      "img" : AppIcon.sportsIcon,
      "name" : "sport",
    },
    {
      "img" : AppIcon.musicIcon,
      "name" : "music",
    },
    {
      "img" : AppIcon.foodIcon,
      "name" : "food",
    },
    {
      "img" : Icon(Icons.format_paint,color: Colors.white,size: 22,),
      "name" : "art",
    },
    {
      "img" : Icon(Icons.celebration,color: Colors.white,size: 22,),
      "name" : "festivals",
    },
    {
      "img" : Icon(Icons.upcoming,color: Colors.white,size: 22,),
      "name" : "product launches",
    },
    {
      "img" : Icon(Icons.groups,color: Colors.white,size: 22,),
      "name" : "conferences",
    },
    {
      "img" : Icon(Icons.design_services,color: Colors.white,size: 22,),
      "name" : "design",
    },
    {
      "img" : Icon(Icons.business,color: Colors.white,size: 22,),
      "name" : "business",
    },
    {
      "img" : Icon(Icons.cake,color: Colors.white,size: 22,),
      "name" : "birthday",
    },
  ];

}

