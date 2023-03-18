import 'dart:math';
import 'dart:ui';

import 'package:bin_there/controllers/pickup_controller.dart';
import 'package:bin_there/views/registartion_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'login_screen.dart';

class PickupService extends StatelessWidget {
  const PickupService({super.key});

  @override
  Widget build(BuildContext context) {
    PickupController pickupController = Get.put(PickupController());
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
      if (!hasPermission) return;
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        print(position);
        pickupController.position = position.obs;
        // setState(() {
        //   _currentPosition = position;
        // });
      }).catchError((e) {
        debugPrint(e);
      });
    }

    Position? _currentPosition;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff5bbfd7), Color(0xfff59934)]).createShader(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Center(
                child: Text(
                  'Get your waste Picked up, schedule your pickup now',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Availiable Slots:',
                style: GoogleFonts.nunitoSans(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
                height: 100,
                child: Obx(
                  () => ModalProgressHUD(
                    inAsyncCall: pickupController.isLoading.value,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount:
                            pickupController.timeSlots?.value.timeslots.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () {
                                pickupController.selectedTimeSlot.value = index;
                              },
                              child: Obx(
                                () => Container(
                                  width: 100,
                                  child: Material(
                                    color: pickupController
                                                .selectedTimeSlot.value ==
                                            index
                                        ? Colors.green
                                        : Colors.white,
                                    elevation: 20,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        '${pickupController.timeSlots?.value.timeslots[index]}',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      useSafeArea: true,
                      useRootNavigator: true,
                      // isDismissible: true,
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await _getCurrentPosition();
                                  print(pickupController
                                      .position?.value.latitude);
                                  // print(pickupController.position.value);
                                },
                                child: const Text('Get Current Location'),
                              ),
                            ),
                            Text('OR',
                                style: GoogleFonts.nunitoSans(
                                    fontSize: 20, fontWeight: FontWeight.w700)),
                            CustomInputField(
                              hintText: 'Flat No.',
                              obscureText: false,
                              inputType: TextInputType.text,
                              textEditingController:
                                  pickupController.flatController,
                            ),
                            CustomInputField(
                              hintText: 'Street',
                              obscureText: false,
                              inputType: TextInputType.text,
                              textEditingController:
                                  pickupController.streetController,
                            ),
                            CustomInputField(
                              hintText: 'Pincode',
                              obscureText: false,
                              inputType: TextInputType.phone,
                              textEditingController:
                                  pickupController.pincodeController,
                            ),
                            CustomInputField(
                              hintText: 'State',
                              obscureText: false,
                              inputType: TextInputType.text,
                              textEditingController:
                                  pickupController.stateController,
                            ),
                            CustomInputField(
                              hintText: 'City',
                              obscureText: false,
                              inputType: TextInputType.text,
                              textEditingController:
                                  pickupController.cityController,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  pickupController.updateAddress();
                                },
                                child: Text('Submit'))
                          ],
                        );
                      });
                },
                child: Text(
                  GetStorage().read('user')['user']['address'] != {}
                      ? 'Change Address'
                      : 'Select a Pickup Location',
                  style: GoogleFonts.nunitoSans(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                    onPressed: () {
                      pickupController.createPickup();
                    },
                    child: Text('Schedule Pickup'))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Agent Details:',
                style: GoogleFonts.nunitoSans(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Obx(
                () => Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(24),
                  animationDuration: const Duration(seconds: 3),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ModalProgressHUD(
                      inAsyncCall: pickupController.isLoading.value,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  pickupController.timeSlots?.value.timeslots
                                              .length !=
                                          null
                                      ? 'Agent Name : ${pickupController.timeSlots?.value.name}'
                                      : 'No Agent Available',
                                  style: GoogleFonts.nunitoSans(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Pickup Status:',
                style: GoogleFonts.nunitoSans(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AnimatedContainer(
                height: 200,
                duration: const Duration(seconds: 3),
                width: double.infinity,
                child: Obx(
                  () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pickupController.allPickups.length,
                    itemBuilder: (context, index) => pickupController
                                .allPickups.length !=
                            0
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              elevation: 8,
                              borderRadius: BorderRadius.circular(24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Date : ${DateFormat('dd/mm/yyyy').format(pickupController.allPickups[index].createdAt as DateTime)}'),
                                  Text(
                                    'Time Slot : ' +
                                        pickupController
                                            .allPickups[index].timeslot
                                            .toString(),
                                  ),
                                  Text('Status : ' +
                                      pickupController.allPickups[index].status
                                          .toString()
                                          .toUpperCase()),
                                  GestureDetector(
                                      onTap: () {
                                        pickupController.updatePickupStatus();
                                      },
                                      child: Text(
                                        'Approve Pickup',
                                        style: TextStyle(color: Colors.blue),
                                      ))
                                ],
                              ),
                            ),
                          )
                        : Center(
                            child: Text('No Pickups Scheduled'),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
