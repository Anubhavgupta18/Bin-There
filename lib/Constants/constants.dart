import 'package:get_storage/get_storage.dart';

class Constants {
  static String apiUrl = 'https://bin-there-production.up.railway.app';
  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  Map<String, String> authHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('user')['token']}'
  };
  Map<String, String> authHeader2 = {
    'Authorization': 'Bearer ${GetStorage().read('user')['token']}'
  };
}
