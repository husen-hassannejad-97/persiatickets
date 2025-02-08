import '../../base/base_model.dart';

class InfoFaqModel implements BaseModel {
  final String desc;
  final List<FaqModel> faqs;

  InfoFaqModel({
    required this.desc,
    required this.faqs,
  });
}

class FaqModel implements BaseModel {
  final String title;
  final String desc;
  final List<String>? items;

  FaqModel({required this.title, required this.desc, this.items});
}
