import 'package:billit_now/local_storage/base/base_entity.dart';

import 'base_model.dart';

abstract class BaseEntityMapper<Entity extends BaseEntity, Model extends BaseModel> {
  Entity toEntity(Model model);
  Model fromEntity(Entity entity);
}