import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../repositories/shared/models/device_info_model.dart';

Future<DeviceInfoModel> getDeviceInfoModel() async {
  final deviceInfoPlugin = DeviceInfoPlugin();

  // Retrieve device name and OS version
  String deviceName = "Unknown Device";
  String osVersion = "Unknown OS Version";
  String deviceModel = "Unknown Model";

  if(!kIsWeb) {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceName = androidInfo.device ?? "Unknown Device";
      osVersion = androidInfo.version.release ?? "Unknown OS Version";
      deviceModel = androidInfo.model ?? "Unknown Model";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceName = iosInfo.name ?? "Unknown Device";
      osVersion = iosInfo.systemVersion ?? "Unknown OS Version";
      deviceModel = iosInfo.model ?? "Unknown Model";
    }
  }

  // Retrieve FCM token
  // final fcmToken = await FirebaseMessaging.instance.getToken() ?? "Unknown FCM Token";

  // Retrieve app version
  // final packageInfo = await PackageInfo.fromPlatform();
  // final appVersion = packageInfo.version;

  // Check if notifications are enabled
  // final notificationSettings = await FirebaseMessaging.instance.getNotificationSettings();
  // final notificationsEnabled = notificationSettings.authorizationStatus == AuthorizationStatus.authorized;

  // Determine if the device is active (this could be an app-defined condition, for example, if the app is in foreground)
  final isActive = true; // You can adjust this based on your app's logic.

  // Build and return the DeviceInfoModel
  return DeviceInfoModel(
    deviceName: deviceName,
    fcmToken: "fcmToken",
    osVersion: osVersion,
    deviceModel: deviceModel,
    appVersion: "appVersion",
    isActive: isActive,
    notificationsEnabled: false,
  );
}