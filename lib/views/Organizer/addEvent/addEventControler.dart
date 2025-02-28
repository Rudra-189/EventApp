import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addEventControler extends GetxController{
  var image = Rx<File?>(null); // Observable for image
  var titleController = TextEditingController();
  var type = ''.obs;
  var dateTime = Rxn<DateTime>();
  var locationController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();



}