import 'package:billit_now/apps/helper/utils/app_icon_name.dart';

import '../../base/base_model.dart';

class VenueFacilitiesModel implements BaseModel {
  final String name;
  final String desc;
  final List<FacilitiesModel> facilities;

  VenueFacilitiesModel(
      {required this.name, required this.desc, required this.facilities});
}

class FacilitiesModel implements BaseModel {
  final String title;
  final List<FacilityModel> facilities;

  FacilitiesModel({required this.title, required this.facilities});
}

class FacilityModel implements BaseModel {
  final String icon;
  final String title;
  final String desc;

  FacilityModel({required this.icon, required this.title, required this.desc});
}
