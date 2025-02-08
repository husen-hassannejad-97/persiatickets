import 'package:billit_now/repositories/base/base_model.dart';
import 'package:billit_now/repositories/shared/models/code_type.dart';
import 'package:billit_now/repositories/shared/models/device_info_model.dart';

class SendCodeInputModel implements BaseModel {
  CodeType codeType;
  String input;
  DeviceInfoModel deviceInfoModel;
  SendCodeInputModel({
    required this.codeType,
    required this.input,
    required this.deviceInfoModel,
  });
}