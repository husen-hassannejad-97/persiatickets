import '../../base/base_model.dart';

class ExplorePricingModel implements BaseModel {
  final String name;
  final String desc;
  final List<PricingModel> sections;

  ExplorePricingModel({
    required this.name,
    required this.desc,
    required this.sections,
  });
}

class PricingModel implements BaseModel {
  final String sectionName;
  final int freeSeatsCount;
  final int totalSeatsCount;
  final double startPrice;
  final double endPrice;

  PricingModel(
      {required this.sectionName,
      required this.freeSeatsCount,
      required this.totalSeatsCount,
      required this.startPrice,
      required this.endPrice,});
}
