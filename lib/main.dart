// ignore_for_file: prefer_const_constructors

import 'package:doodhwala/HomePage/home_page.dart';
import 'package:doodhwala/themes/Light_Dark_theme/themes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final ThemeController themeController = Get.put(ThemeController());

   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
      GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:themeController.currentTheme.value,
      home: MyHomePage(),
    ),
    );
  }
}
