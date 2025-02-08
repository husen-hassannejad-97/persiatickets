import 'package:billit_now/repositories/ad/input_models/update_ad_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/ad/dto/update_ad_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAdDtoMapper extends BaseDtoMapper<UpdateAdDto, UpdateAdInputModel> {
  @override
  UpdateAdInputModel fromDto(UpdateAdDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  UpdateAdDto toDto(UpdateAdInputModel model) {
    return UpdateAdDto(title: model.title, description: model.description, mediaUrls: model.mediaUrls, priority: model.priority, pageLocation: model.pageLocation, adType: model.adType, link: model.link, linkTitle: model.linkTitle, mediaThumbnail: model.mediaThumbnail, mediaLogo: model.mediaLogo, logo: model.logo);
  }

}