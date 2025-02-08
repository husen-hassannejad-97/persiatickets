import '../../base/base_model.dart';
import '../models/event_category_model.dart';

class GetEventsInputModel implements BaseModel {
  final EventCategoryModel eventCategoryModel;
  final int limit;
  GetEventsInputModel({
    required this.eventCategoryModel,
    required this.limit,
  });
}