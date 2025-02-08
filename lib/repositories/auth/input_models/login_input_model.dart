import 'package:billit_now/repositories/base/base_model.dart';
import 'package:billit_now/repositories/shared/models/code_type.dart';

import '../../shared/models/device_info_model.dart';

class LoginInputModel implements BaseModel {
  final CodeType codeType;
  final String email;
  final String password;
  final DeviceInfoModel deviceInfoModel;

  LoginInputModel({
    required this.codeType,
    required this.email,
    required this.password,
    required this.deviceInfoModel,
  });
}