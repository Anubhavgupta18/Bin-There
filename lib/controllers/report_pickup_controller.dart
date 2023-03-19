import 'dart:io';

import 'package:bin_there/models/allReports_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dio/src/form_data.dart' as formData;
import 'package:dio/src/multipart_file.dart' as multipartFile;
import '../Constants/constants.dart';

class ReportPickupController extends GetxController {
  Rx<File> file = File('').obs;
  // TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Rx<Position>? position;
  final dio = Dio();
  var allReports = <AllReports>[].obs;
  var isLoading = false.obs;
  @override
  onInit() async{
    await getAllReports();
    super.onInit();
  }

  reportNonPickup() async {
    try {
      // isLoading(true);
      // Map<String, String> header = {'Authorization': 'Bearer $token'};
      String fileName = file.value.path.split('/').last;
      formData.FormData data = formData.FormData.fromMap({
        "lat": position!.value.latitude,
        "description": descriptionController.text,
        "lon": position!.value.longitude,
        "image": await multipartFile.MultipartFile.fromFile(file.value.path,
            filename: fileName),
      });
      var response = await dio.post('${Constants.apiUrl}/api/reports',
          options: Options(headers: Constants().authHeader), data: data);

      print(response.statusCode);
      print(response);
      // print(await res.stream.bytesToString());
    } catch (er) {
      debugPrint(er.toString());
    } finally {
      file.value = File('');
      // locationController.text='';
      descriptionController.text = '';
      isLoading(false);
    }
  }

  getAllReports() async {
    try {
      isLoading(true);
      var response = await http.get(
          Uri.parse(
              '${Constants.apiUrl}/api/reports/user/${GetStorage().read('user')['user']['_id']}'),
          headers: Constants().authHeader);
      if (response.statusCode == 200) {
        // print(response.body);
        allReports.value = allReportsFromJson(response.body);
      }
    } catch (er) {
      debugPrint(er.toString());
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading(false);
    }
  }
}
