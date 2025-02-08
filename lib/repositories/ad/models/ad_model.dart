import 'package:billit_now/repositories/base/base_model.dart';

enum AdMediaType {
  Image, Video
}

class AdModel implements BaseModel {
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
  final AdMediaType mediaType;
  final String logo;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;

  AdModel({
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
    required this.mediaType,
    required this.logo,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

}