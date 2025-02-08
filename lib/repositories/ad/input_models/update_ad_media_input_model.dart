import 'package:billit_now/repositories/base/base_model.dart';

class UpdateAdMediaInputModel implements BaseModel {
  final String mediaFile;
  final String mediaThumbnail;
  final String mediaLogo;
  final String logo;

  UpdateAdMediaInputModel({
    required this.mediaFile,
    required this.mediaThumbnail,
    required this.mediaLogo,
    required this.logo,
  });

}