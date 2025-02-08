import 'package:billit_now/repositories/base/base_model.dart';

enum AdActionType {
  View, Click
}

class RecordAdActionInputModel implements BaseModel {
  final AdActionType actionType;

  RecordAdActionInputModel({required this.actionType});
}