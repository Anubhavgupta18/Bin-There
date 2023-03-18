import 'package:bin_there/controllers/login_controller.dart';
import 'package:bin_there/views/registartion_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: loginController.isLoading.value,
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Login Screen',
                    style: GoogleFonts.aBeeZee(fontSize: 30),
                  ),
                ),
                Expanded(
                  child: Image.asset('assets/binthere.png'),
                ),
                CustomInputField(
                  hintText: 'Email',
                  obscureText: false,
                  inputType: TextInputType.emailAddress,
                  textEditingController: loginController.emailController,
                ),
                CustomInputField(
                  hintText: 'Password',
                  obscureText: true,
                  inputType: TextInputType.visiblePassword,
                  textEditingController: loginController.passwordController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const RegistrationScreen());
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (await loginController.login() == 200) {
                      Get.offAll(() => const HomeScreen());
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
