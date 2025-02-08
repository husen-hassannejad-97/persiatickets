import 'package:billit_now/repositories/base/base_model.dart';

import '../../shared/models/code_type.dart';

class CodeInputModel implements BaseModel {
  CodeType codeType;
  String input;
  CodeInputModel({
    required this.codeType,
    required this.input
  });
}