import 'package:billit_now/repositories/base/base_model.dart';

class CompleteInputModel implements BaseModel {
  final String email;
  final String phoneNumber;
  final String password;
  final String firstName;
  final String lastName;

  CompleteInputModel({
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
}