import '../../base/base_model.dart';

class RecordAdActionModel implements BaseModel {
  final int id;
  final int adId;
  final String actionType;
  final DateTime timestamp;

  RecordAdActionModel({
    required this.id,
    required this.adId,
    required this.actionType,
    required this.timestamp,
  });

}