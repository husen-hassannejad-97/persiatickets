import 'package:billit_now/repositories/base/base_model.dart';

class LoggedUserInfoModel implements BaseModel {
  String sub;
  String email;
  String username;
  int tokenVersion;
  String firstName;
  String lastName;
  String? profileImg;
  int exp;
  String jti;
  String type;

  LoggedUserInfoModel({
    required this.sub,
    required this.email,
    required this.username,
    required this.tokenVersion,
    required this.firstName,
    required this.lastName,
    required this.profileImg,
    required this.exp,
    required this.jti,
    required this.type,
  });
}
