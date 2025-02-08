import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:hive_flutter/adapters.dart';

import 'bootstrap.dart';
import 'core/di/di_setup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //Remove the # prefix from the web URL
  usePathUrlStrategy();

  configureDependencies();
  bootstrap();
}
