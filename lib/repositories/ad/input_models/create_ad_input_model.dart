import '../../base/base_model.dart';

class CreateAdInputModel implements BaseModel {
  final String title;
  final String description;
  final int priority;
  final String pageLocation;
  final String adType;
  final String link;
  final String linkTitle;

  CreateAdInputModel({
    required this.title,
    required this.description,
    required this.priority,
    required this.pageLocation,
    required this.adType,
    required this.link,
    required this.linkTitle,
  });

}