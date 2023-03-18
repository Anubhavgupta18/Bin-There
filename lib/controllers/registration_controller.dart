import 'dart:convert';

import 'package:bin_there/Constants/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RegistartionController extends GetxController {
  var otpSent = false.obs;
  var isLoading = false.obs;
  var isUserSelected = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  void toggleUserSelection() {
    isUserSelected.value = !isUserSelected.value;
  }

  Future sendOtp() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));
    try {
      var response =
          await http.post(Uri.parse('${Constants.apiUrl}/api/users/signup'),
              body: jsonEncode({
                'email': emailController.text,
                'password': passwordController.text,
                'name': nameController.text,
              }),
              headers: Constants.header);
      if (response.statusCode == 201) {
        otpSent.value = true;
      }
      print(response.statusCode);
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
      // otpSent.value = true;
    }
  }

  Future register() async {
    isLoading.value = true;
    try {
      var response =
          await http.post(Uri.parse('${Constants.apiUrl}/api/users/verifyotp'),
              body: jsonEncode({
                'email': emailController.text,
                'otp': otpController.text,
              }),
              headers: Constants.header);
      if (response.statusCode == 200) {
        GetStorage().write('token', jsonDecode(response.body)['token']);
      }
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
