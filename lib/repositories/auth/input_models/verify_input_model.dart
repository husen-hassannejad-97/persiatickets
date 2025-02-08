import 'package:billit_now/repositories/base/base_model.dart';

import '../../shared/models/code_type.dart';

class VerifyInputModel implements BaseModel {
  CodeType type;
  String id;
  String code;
  VerifyInputModel({
    required this.type,
    required this.id,
    required this.code,
  });
}