import 'package:get_storage/get_storage.dart';

class Constants {
  static String apiUrl = 'http://192.168.1.3:3009';
  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  Map<String, String> authHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('user')['token']}'
  };
}
