import 'package:billit_now/apps/helper/utils/app_icon_name.dart';

import '../../base/base_model.dart';

class VenueGuidelinesModel implements BaseModel {
  final List<GuidesModel> guides;

  VenueGuidelinesModel({required this.guides});
}

class GuidesModel implements BaseModel {
  final String icon;

  final String desc;

  GuidesModel({required this.icon, required this.desc});
}
