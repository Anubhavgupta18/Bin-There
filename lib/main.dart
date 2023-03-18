import 'package:bin_there/views/home_screen.dart';
import 'package:bin_there/views/login_screen.dart';
// import 'package:bin_there/views/registartion_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future main() async {
  await GetStorage.init();
  // print(GetStorage().read('user')['user']['address']);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(useMaterial3: true),
      home: GetStorage().read('user') == null ? LoginScreen() : HomeScreen(),
    );
  }
}
