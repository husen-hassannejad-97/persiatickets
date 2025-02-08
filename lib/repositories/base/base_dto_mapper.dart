import 'package:billit_now/services/base/base_dto.dart';
import 'package:billit_now/repositories/base/base_model.dart';

abstract class BaseDtoMapper<Dto extends BaseDto, Model extends BaseModel> {
  Dto toDto(Model model);
  Model fromDto(Dto dto);
}