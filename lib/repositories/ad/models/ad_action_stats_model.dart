import 'package:billit_now/repositories/base/base_model.dart';

class AdActionStatsModel implements BaseModel {
  final int adId;
  final int totalViews;
  final int totalClicks;

  AdActionStatsModel({
    required this.adId,
    required this.totalViews,
    required this.totalClicks,
  });

}