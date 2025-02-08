import 'package:billit_now/repositories/ad/input_models/create_ad_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/ad/dto/create_ad_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateAdDtoMapper extends BaseDtoMapper<CreateAdDto, CreateAdInputModel> {
  @override
  CreateAdInputModel fromDto(CreateAdDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  CreateAdDto toDto(CreateAdInputModel model) {
    return CreateAdDto(
        title: model.title,
        description: model.description,
        priority: model.priority,
        pageLocation: model.pageLocation,
        adType: model.adType,
        link: model.link,
        linkTitle: model.linkTitle);
  }
}
