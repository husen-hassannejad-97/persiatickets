import 'package:billit_now/repositories/base/base_model.dart';

class HeaderNavigationModel implements BaseModel {
  final String title;
  final bool isDone;
  final bool isHover;

  HeaderNavigationModel(
      {required this.title, required this.isDone, required this.isHover});
}
