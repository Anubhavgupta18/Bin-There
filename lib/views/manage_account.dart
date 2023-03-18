import 'package:bin_there/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'login_screen.dart';

class ManageAccount extends StatelessWidget {
  const ManageAccount({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                GetStorage().remove('user');
                Get.offAll(
                  () => LoginScreen(),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(200),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/binthere.png'),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.pencil,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  elevation: 8,
                  child: Obx(
                    () => TextFormField(
                      // initialValue: 'Present Address',
                      controller: profileController.addressController.value,
                      onChanged: (value) =>
                          print(profileController.addressController.value.text),
                      decoration: const InputDecoration(
                        hintText: 'Address',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.home),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
