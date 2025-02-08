import 'package:billit_now/repositories/event/models/programs_status.dart';

import '../../base/base_model.dart';

class ProgramsModel implements BaseModel {
  final DateTime date;
  final DateTime time;
  final ProgramsStatus status;
  final int seatsCount;
  final String priceRange;

  ProgramsModel(
      {required this.date,
      required this.time,
      required this.status,
      required this.seatsCount,
      required this.priceRange,});
}
