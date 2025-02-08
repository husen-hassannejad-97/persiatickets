import '../../base/base_model.dart';

class EventAdBannerModel implements BaseModel {
  final String image;
  final String title;
  final String desc;
  final String btnTitle;
  final String link;

  EventAdBannerModel(
      {required this.image,
      required this.title,
      required this.desc,
      required this.btnTitle,
      required this.link});
}
