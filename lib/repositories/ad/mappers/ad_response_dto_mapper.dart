import 'package:billit_now/repositories/ad/models/ad_model.dart';
import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/services/ad/response_dto/ad_response_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdResponseDtoMapper extends BaseDtoMapper<AdResponseDto, AdModel> {
  @override
  AdModel fromDto(AdResponseDto dto) {
    return AdModel(
        title: dto.title,
        description: dto.description,
        mediaUrls: dto.mediaUrls,
        priority: dto.priority,
        pageLocation: dto.pageLocation,
        adType: dto.adType,
        link: dto.link,
        linkTitle: dto.linkTitle,
        mediaThumbnail: dto.mediaThumbnail ?? "",
        mediaLogo: dto.mediaLogo ?? "",
        mediaType: dto.mediaType == "image" ? AdMediaType.Image : AdMediaType.Video,
        logo: dto.logo ?? "",
        id: dto.id,
        createdAt: dto.createdAt,
        updatedAt: dto.updatedAt);
  }

  @override
  AdResponseDto toDto(AdModel model) {
    return AdResponseDto(
        title: model.title,
        description: model.description,
        mediaUrls: model.mediaUrls,
        priority: model.priority,
        pageLocation: model.pageLocation,
        adType: model.adType,
        link: model.link,
        linkTitle: model.linkTitle,
        mediaThumbnail: model.mediaThumbnail,
        mediaLogo: model.mediaLogo,
        mediaType: model.mediaType == AdMediaType.Image ? "image" : "video",
        logo: model.logo,
        id: model.id,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt);
  }
}
