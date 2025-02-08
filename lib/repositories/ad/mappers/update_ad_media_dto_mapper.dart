import 'package:billit_now/repositories/ad/input_models/update_ad_media_input_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/ad/dto/update_ad_media_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateAdMediaDtoMapper extends BaseDtoMapper<UpdateAdMediaDto, UpdateAdMediaInputModel> {
  @override
  UpdateAdMediaInputModel fromDto(UpdateAdMediaDto dto) {
    // TODO: implement fromDto
    throw UnimplementedError();
  }

  @override
  UpdateAdMediaDto toDto(UpdateAdMediaInputModel model) {
    return UpdateAdMediaDto(mediaFile: model.mediaFile, mediaThumbnail: model.mediaThumbnail, mediaLogo: model.mediaLogo, logo: model.logo);
  }

}