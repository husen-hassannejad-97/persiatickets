import 'package:billit_now/apps/helper/utils/app_icon_name.dart';

import '../../base/base_model.dart';

class AboutOrganizerModel implements BaseModel {
  final OrganizerModel organizerModel;
  AboutOrganizerModel({
    required this.organizerModel
  });
}

class OrganizerModel implements BaseModel {
  final String organizerImage;
  final String name;
  final String phoneNumber;
  final String emailAddress;
  final String company;
  final String officeNumber;
  final String address;
  final List<SocialModel> socials;
  final List<SingerModel> featuredSingers;

  OrganizerModel(
      {required this.organizerImage,
        required this.name,
        required this.phoneNumber,
        required this.emailAddress,
        required this.company,
        required this.officeNumber,
        required this.address,
        required this.socials,
        required this.featuredSingers});
}

class SocialModel implements BaseModel {
  final String icon;
  final String link;

  SocialModel({required this.icon, required this.link});
}

class SingerModel implements BaseModel {
  final String image;
  final String name;

  SingerModel({required this.image, required this.name});
}
