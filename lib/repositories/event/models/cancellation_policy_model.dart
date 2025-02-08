import 'package:billit_now/apps/helper/utils/app_icon_name.dart';

import '../../base/base_model.dart';

class CancellationPolicyModel implements BaseModel {
  final String title;
  final List<CancellationPolicyItemModel> policies;

  CancellationPolicyModel({
    required this.title,
    required this.policies,
  });
}

class CancellationPolicyItemModel implements BaseModel {
  final String icon;
  final String title;
  final String description;

  CancellationPolicyItemModel({
    required this.icon,
    required this.title,
    required this.description,
  });
}
