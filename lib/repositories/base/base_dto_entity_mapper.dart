import 'package:billit_now/services/base/base_dto.dart';
import 'package:billit_now/local_storage/base/base_entity.dart';

abstract class BaseDtoEntityMapper<Dto extends BaseDto, Entity extends BaseEntity> {
  Dto toDto(Entity entity);
  Entity fromDto(Dto dto);
}