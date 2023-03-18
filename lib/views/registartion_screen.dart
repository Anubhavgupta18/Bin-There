// ignore_for_file: must_be_immutable

import 'package:bin_there/controllers/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegistartionController registrationController =
        Get.put(RegistartionController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff5BBFD7), Color(0xffF59934)]).createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: const Text(
            'Bin There',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Register Here',
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: Image.asset('assets/binthere.png')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomInputField(
                      hintText: 'Name',
                      obscureText: false,
                      inputType: TextInputType.name,
                      textEditingController:
                          registrationController.nameController,
                    ),
                    CustomInputField(
                      hintText: 'Email Address',
                      textEditingController:
                          registrationController.emailController,
                      obscureText: false,
                      inputType: TextInputType.emailAddress,
                    ),
                    CustomInputField(
                      hintText: 'Password',
                      textEditingController:
                          registrationController.passwordController,
                      obscureText: true,
                      inputType: TextInputType.visiblePassword,
                    ),
                    Obx(
                      () => Visibility(
                        visible: registrationController.otpSent.value,
                        child: CustomInputField(
                          textEditingController:
                              registrationController.otpController,
                          hintText: 'OTP',
                          obscureText: true,
                          inputType: const TextInputType.numberWithOptions(
                              decimal: false),
                        ),
                      ),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                          visible: registrationController.isLoading.value,
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Obx(
                        () => Visibility(
                          visible: registrationController.otpSent.value,
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {},
                                  child: const Text('Resend OTP'))),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(8),
                      child: GestureDetector(
                        onTap: !registrationController.isLoading.value
                            ? () async {
                                if (registrationController.otpSent.value) {
                                  if (registrationController
                                              .emailController.text !=
                                          '' &&
                                      registrationController
                                              .passwordController.text !=
                                          '' &&
                                      registrationController
                                              .nameController.text !=
                                          '' &&
                                      registrationController
                                              .otpController.text !=
                                          '') {
                                    if (await registrationController
                                            .register() ==
                                        200) {
                                      Get.snackbar('Success', "OTP Verified");
                                      Get.offAll(() => const HomeScreen());
                                    } else {
                                      Get.snackbar(
                                          'Error', "OTP Does not match");
                                    }
                                  } else {
                                    Get.snackbar(
                                        'Error', 'Please fill all the fields');
                                  }
                                } else {
                                  if (registrationController
                                              .emailController.text !=
                                          '' &&
                                      registrationController
                                              .passwordController.text !=
                                          '' &&
                                      registrationController
                                              .nameController.text !=
                                          '') {
                                    if (await registrationController
                                            .sendOtp() !=
                                        201) {
                                      Get.snackbar('Error',
                                          'Please enter a valid email address');
                                    }
                                  } else {
                                    Get.snackbar(
                                        'Error', 'Please fill all the fields');
                                  }
                                }
                              }
                            : null,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Obx(
                              () => Text(
                                registrationController.otpSent.value
                                    ? 'Register'
                                    : 'Get OTP',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  CustomInputField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.inputType,
      required this.textEditingController});
  String hintText;
  bool obscureText;
  TextEditingController textEditingController;
  TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Material(
        elevation: 12,
        // color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: TextField(
            controller: textEditingController,
            obscureText: obscureText,
            keyboardAppearance: Brightness.light,
            keyboardType: inputType,
            decoration:
                InputDecoration(border: InputBorder.none, hintText: hintText),
          ),
        ),
      ),
    );
  }
}
