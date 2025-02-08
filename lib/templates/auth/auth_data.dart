import 'package:billit_now/apps/helper/utils/country_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveCountryOnStorage(CountryModel data, Function() done) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('countryName', data.name);
  await prefs.setString('dialCode', data.dialCode);
  await prefs.setString('countryCode', data.code);
  await prefs.setInt('mobileNumberLength', data.mobileNumberLength);
  await prefs.setString('countryPhoneFormat', data.format);
  done();
}

Future<CountryModel> getCountryFromStorage() async {
  final prefs = await SharedPreferences.getInstance();

  return CountryModel(
      name: prefs.getString('countryName') ?? '',
      dialCode: prefs.getString('dialCode') ?? '',
      code: prefs.getString('countryCode') ?? '',
      mobileNumberLength: prefs.getInt('mobileNumberLength') ?? 0,
      format: prefs.getString('countryPhoneFormat') ?? '');
}
