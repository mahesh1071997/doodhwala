import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ThemeData lightTheme = ThemeData.light();
final ThemeData darkTheme = ThemeData.dark();

class ThemeController extends GetxController {

     Rx<ThemeData> currentTheme = lightTheme.obs;

  void switchToLightTheme(){
    Get.changeTheme(lightTheme);
    currentTheme.value = lightTheme;
  }

  void switchToDarkTheme() {
    Get.changeTheme(darkTheme);
    currentTheme.value = darkTheme;
  }
}

