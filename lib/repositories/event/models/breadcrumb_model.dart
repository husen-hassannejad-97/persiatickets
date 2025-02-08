import '../../base/base_model.dart';

class BreadcrumbModel implements BaseModel {
  final String shareLink;
  final Function() addToTrackList;

  BreadcrumbModel({required this.shareLink, required this.addToTrackList});
}
