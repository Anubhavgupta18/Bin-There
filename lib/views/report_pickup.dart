import 'dart:io';
import 'dart:math';

import 'package:bin_there/controllers/report_pickup_controller.dart';
import 'package:bin_there/views/registartion_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReportPickup extends StatelessWidget {
  const ReportPickup({super.key});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    ReportPickupController reportPickupController =
        Get.put(ReportPickupController());
    chooseImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      reportPickupController.file.value = File(pickedFile!.path);
    }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: GestureDetector(
                onTap: () async {
                  await chooseImage();
                },
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(24),
                  child: Obx(
                    () => Container(
                      height: 200,
                      width: double.infinity,
                      child: reportPickupController.file.value.path == ''
                          ? const Center(
                              child: Text(
                                'No Image Selected',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Obx(
                              () => Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Image.file(
                                      reportPickupController.file.value,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                    ),
                                    Material(
                                      elevation: 8,
                                      borderRadius: BorderRadius.circular(24),
                                      color: Colors.white70,
                                      child: IconButton(
                                        onPressed: () {
                                          reportPickupController.file.value =
                                              File('');
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            CustomInputField(
              hintText: 'Location of the bin',
              obscureText: false,
              inputType: TextInputType.text,
              textEditingController: reportPickupController.locationController,
            ),
            CustomInputField(
              hintText: 'Description',
              obscureText: false,
              inputType: TextInputType.text,
              textEditingController:
                  reportPickupController.descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}
