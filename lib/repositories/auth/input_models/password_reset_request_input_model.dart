import 'package:billit_now/repositories/base/base_model.dart';

class PasswordResetRequestInputModel implements BaseModel {
  final String email;
  const PasswordResetRequestInputModel({required this.email});
}