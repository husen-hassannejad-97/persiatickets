import 'package:shared_preferences/shared_preferences.dart';

Future<void> savePhoneOnStorage(String phone, Function() done) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('phone', phone);

  done();
}

Future<String> getPhoneFromStorage() async {
  final prefs = await SharedPreferences.getInstance();

  String phone = prefs.getString('phone') ?? '';

  return phone;
}
