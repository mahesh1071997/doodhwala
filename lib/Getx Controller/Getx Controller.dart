
// ignore_for_file: file_names

import 'package:get/get.dart';

// Quantity Controller
class QuantityController extends GetxController {
  var selectedValue = ''.obs;

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }
}
