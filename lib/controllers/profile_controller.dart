import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    await Future.delayed(const Duration(seconds: 2));
    addressController.value = TextEditingController(text: 'Address');
    super.onInit();
  }

  late Rx<TextEditingController> addressController =
      TextEditingController().obs;
}
