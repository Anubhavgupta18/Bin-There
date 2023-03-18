import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReportPickupController extends GetxController {
  Rx<File> file = File('').obs;
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
}
