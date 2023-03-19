import 'dart:convert';

import 'package:bin_there/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  Rx<User>? user;
  login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));
    print(emailController.text);
    print(passwordController.text);
    try {
      var response = await http.post(
          Uri.parse('${Constants.apiUrl}/api/users/signin'),
          body: jsonEncode({
            'email': emailController.text,
            'password': passwordController.text
          }),
          headers: Constants.header);
      // print(response.body);
      // Get.snackbar('Login', response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        user = User.fromJson(data).obs;
        GetStorage().write('user', data);
      }
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      // Get.snackbar('Login', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
