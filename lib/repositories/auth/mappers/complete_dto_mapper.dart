import 'package:billit_now/repositories/auth/input_models/code_input_model.dart';
import 'package:billit_now/repositories/auth/input_models/complete_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/auth/dto/complete_dto.dart';
import 'package:injectable/injectable.dart';

@singleton
class CompleteDtoMapper extends BaseDtoMapper<CompleteDto, CompleteInputModel> {
  @override
  CompleteInputModel fromDto(CompleteDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  CompleteDto toDto(CompleteInputModel model) {
    return CompleteDto(
        email: model.email,
        phoneNumber: model.phoneNumber,
        password: model.password,
        firstName: model.firstName,
        lastName: model.lastName
    );
  }

}