import 'package:flutter/foundation.dart';

class AppConstants {
  static String get baseApiUrl {
    if(kDebugMode) {
      return "$baseDevelopApiUrl/";
    } else {
      return "$baseProdApiUrl/";
    }
  }

  static const String baseDevelopApiUrl = "https://api.persia.tickets";
  static const String baseProdApiUrl = baseDevelopApiUrl;

  static const hiveBox = "bilit";
  static const hiveAuthToken = "authToken";
  static const hiveAuthTokenString = "authTokenString";
  static const assetImagesDefaultPath = "assets/images/";

}