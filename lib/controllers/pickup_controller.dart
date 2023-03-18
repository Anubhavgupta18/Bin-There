import 'dart:convert';

import 'package:bin_there/models/allPickups_model.dart';
import 'package:bin_there/models/timeslot_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../Constants/constants.dart';
import '../views/login_screen.dart';

class PickupController extends GetxController {
  @override
  void onInit() async {
    await getTimeSlots();
    super.onInit();
  }

  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  TextEditingController flatController = TextEditingController(
      text: GetStorage().read('user')['user']['address']['flatNo']);
  TextEditingController streetController = TextEditingController(
      text: GetStorage().read('user')['user']['address']['street']);
  TextEditingController pincodeController = TextEditingController(
      text: GetStorage().read('user')['user']['address']['pincode']);
  TextEditingController stateController = TextEditingController(
      text: GetStorage().read('user')['user']['address']['state']);
  TextEditingController cityController = TextEditingController(
      text: GetStorage().read('user')['user']['address']['city']);
  var selectedTimeSlot = 0.obs;
  var isLoading = false.obs;
  Rx<TimeSlots>? timeSlots;
  var allPickups = <AllPickups>[].obs;
  Rx<Position>? position;
  getTimeSlots() async {
    try {
      isLoading(true);
      await getAllPickups();
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/api/users/timeslots'),
          headers: Constants().authHeader);
      if (response.statusCode == 200) {
        timeSlots = timeSlotsFromJson(response.body).obs;
      }
      print(timeSlots?.value.timeslots.length);
    } catch (err) {
      print(err);
      Get.snackbar('Error', "Couldn't fetch time slots");
    } finally {
      isLoading(false);
    }
  }

  getAllPickups() async {
    try {
      var response = await http.get(
          Uri.parse('${Constants.apiUrl}/api/pickups/user'),
          headers: Constants().authHeader);
      if (response.statusCode == 201) {
        // print(response.body);
        allPickups = allPickupsFromJson(response.body).obs;
      }
    } catch (err) {
      print(err);
    }
  }

  createPickup() async {
    try {
      var response =
          await http.post(Uri.parse('${Constants.apiUrl}/api/pickups/'),
              body: jsonEncode({
                'timeslot':
                    "${timeSlots?.value.timeslots[selectedTimeSlot.value]}",
                'agentId': timeSlots?.value.id,
              }),
              headers: Constants().authHeader);
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Pickup created successfully');
        await getAllPickups();
      }
    } catch (err) {
      print(err);
    }
  }

  updatePickupStatus() async {
    try {
      var response = await http.patch(
          Uri.parse(
              '${Constants.apiUrl}/api/pickups/update/${allPickups[selectedTimeSlot.value].id}'),
          body: jsonEncode({'status': 'approved'}),
          headers: Constants().authHeader);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'You confirmed the pickup from your house');
        await getAllPickups();
      }
    } catch (err) {
      print(err);
    }
  }

  updateAddress() async {
    print(position?.value.latitude);
    try {
      var response =
          await http.patch(Uri.parse('${Constants.apiUrl}/api/users/update'),
              body: jsonEncode({
                "address": {
                  'flatNo': flatController.text,
                  'street': streetController.text,
                  'pincode': pincodeController.text,
                  'state': stateController.text,
                  'city': cityController.text,
                  'lat': position?.value.latitude,
                  'lon': position?.value.longitude
                }
              }),
              headers: Constants().authHeader);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar(
            'Success', 'Address updated successfully, Logging you out');
        // GetStorage().write('user', jsonDecode(response.body));
        GetStorage().remove('user');

        Get.offAll(() => LoginScreen());
      }
    } catch (err) {
      print(err);
    }
  }
}
