import '../../base/base_model.dart';

class UpdateAdInputModel implements BaseModel {
  final String title;
  final String description;
  final List<String> mediaUrls;
  final int priority;
  final String pageLocation;
  final String adType;
  final String link;
  final String linkTitle;
  final String mediaThumbnail;
  final String mediaLogo;
  final String logo;

  UpdateAdInputModel({
    required this.title,
    required this.description,
    required this.mediaUrls,
    required this.priority,
    required this.pageLocation,
    required this.adType,
    required this.link,
    required this.linkTitle,
    required this.mediaThumbnail,
    required this.mediaLogo,
    required this.logo,
  });

}