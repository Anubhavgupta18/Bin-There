import 'dart:io';
import 'dart:math';

import 'package:bin_there/controllers/report_pickup_controller.dart';
import 'package:bin_there/views/registartion_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ReportPickup extends StatelessWidget {
  const ReportPickup({super.key});

  @override
  Widget build(BuildContext context) {
    ReportPickupController reportPickupController =
        Get.put(ReportPickupController());
    Future<bool> _handleLocationPermission() async {
      bool serviceEnabled;
      LocationPermission permission;
      // late Position position;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location services are disabled. Please enable the services')));
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permissions are denied')));
          return false;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')));
        return false;
      }
      return true;
    }

    Future<void> _getCurrentPosition() async {
      final hasPermission = await _handleLocationPermission();
      reportPickupController.isLoading(true);
      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        print(position);
        reportPickupController.position = position.obs;
        // setState(() {
        //   _currentPosition = position;
        // });
      }).catchError((e) {
        debugPrint(e);
      });
    }

    Position? _currentPosition;
    final ImagePicker picker = ImagePicker();
    chooseImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      reportPickupController.file.value = File(pickedFile!.path);
    }

    Future<void> _getAddressFromLatLng(Position position) async {
      await placemarkFromCoordinates(
              reportPickupController.position!.value.latitude,
              reportPickupController.position!.value.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        print(place);
        // setState(() {
        //   _currentAddress =
        //      '${place.street}, ${place.subLocality},
        //       ${place.subAdministrativeArea}, ${place.postalCode}';
        // });
      }).catchError((e) {
        debugPrint(e);
      });
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
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: reportPickupController.isLoading.value,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          color: Colors.white70,
                                          child: IconButton(
                                            onPressed: () {
                                              reportPickupController
                                                  .file.value = File('');
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
                  hintText: 'Description',
                  obscureText: false,
                  inputType: TextInputType.text,
                  textEditingController:
                      reportPickupController.descriptionController,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ElevatedButton(
                      onPressed: () async {
                        if (reportPickupController.file.value.path != '' &&
                            reportPickupController.descriptionController.text !=
                                '') {
                          await _getCurrentPosition();
                          // await _getAddressFromLatLng(reportPickupController.position!.value);
                          reportPickupController.reportNonPickup();
                          Get.snackbar('Success', 'Report Submitted');
                        } else {
                          Get.snackbar('Error', 'Please fill all the fields');
                        }
                      },
                      child: const Text('Submit your report')),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    'Your Past Reports: ',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: reportPickupController.allReports.length,
                      // scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(24),
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            child: Center(
                              child: Row(
                                children: [
                                  Obx(
                                    () => Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            '${reportPickupController.allReports[index].image?.url}',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${reportPickupController.allReports[index].description}',
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
