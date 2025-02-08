import 'package:billit_now/repositories/base/base_model.dart';

import '../../shared/models/code_type.dart';

class VerifySignupInputModel implements BaseModel {
  CodeType type;
  String id;
  String code;
  VerifySignupInputModel({
    required this.type,
    required this.id,
    required this.code,
  });
}