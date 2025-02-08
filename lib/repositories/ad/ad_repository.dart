import 'package:billit_now/repositories/ad/input_models/create_ad_input_model.dart';
import 'package:billit_now/repositories/ad/input_models/record_ad_action_input_model.dart';
import 'package:billit_now/repositories/ad/input_models/update_ad_input_model.dart';
import 'package:billit_now/repositories/ad/input_models/update_ad_media_input_model.dart';
import 'package:billit_now/repositories/ad/mappers/ad_response_dto_mapper.dart';
import 'package:billit_now/repositories/ad/mappers/create_ad_dto_mapper.dart';
import 'package:billit_now/repositories/ad/mappers/record_ad_action_dto_mapper.dart';
import 'package:billit_now/repositories/ad/models/ad_action_stats_model.dart';
import 'package:billit_now/repositories/ad/models/ad_model.dart';
import 'package:billit_now/repositories/ad/models/record_ad_action_model.dart';
import 'package:billit_now/repositories/shared/result.dart';
import 'package:billit_now/services/ad/ad_service.dart';
import 'package:billit_now/services/ad/response_dto/ad_response_dto.dart';
import 'package:injectable/injectable.dart';
import '../../services/ad/response_dto/ad_action_stats_response_dto.dart';
import '../../services/ad/response_dto/record_ad_action_response_dto.dart';
import '../base/base_repository.dart';
import 'mappers/ad_action_stats_response_dto_mapper.dart';
import 'mappers/record_ad_action_response_dto_mapper.dart';
import 'mappers/update_ad_dto_mapper.dart';
import 'mappers/update_ad_media_dto_mapper.dart';

@singleton
class AdRepository extends BaseRepository {

  final AdService adService;
  final AdResponseDtoMapper adResponseDtoMapper;
  final CreateAdDtoMapper createAdDtoMapper;
  final RecordAdActionDtoMapper recordAdActionDtoMapper;
  final UpdateAdDtoMapper updateAdDtoMapper;
  final UpdateAdMediaDtoMapper updateAdMediaDtoMapper;
  final RecordAdActionResponseDtoMapper recordAdActionResponseDtoMapper;
  final AdActionStatsResponseDtoMapper adActionStatsResponseDtoMapper;
  AdRepository({
    required this.adService,
    required this.adResponseDtoMapper,
    required this.createAdDtoMapper,
    required this.recordAdActionDtoMapper,
    required this.updateAdDtoMapper,
    required this.updateAdMediaDtoMapper,
    required this.recordAdActionResponseDtoMapper,
    required this.adActionStatsResponseDtoMapper,
  });

  Future<Result<List<AdModel>>> getAds(
      String pageLocation,
      int limit,
      int offset,
      ) {
    return callApi(() {
      return adService.ads(pageLocation, limit, offset);
    }).map(
            (List<AdResponseDto> data) => data.map(
                (AdResponseDto item) => adResponseDtoMapper.fromDto(item)
        ).toList()
    );
  }

  Future<Result<AdModel>> createAd(
      CreateAdInputModel createAdInputModel,
      ) {
    return callApi(() {
      return adService.createAd(
          createAdDtoMapper.toDto(createAdInputModel)
      );
    }).map(
            (AdResponseDto response) => adResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<AdModel>> updateAdMedia(
      String adId,
      UpdateAdMediaInputModel updateAdMediaInputModel,
      ) {
    return callApi(() {
      return adService.updateAdMedia(
          adId,
          updateAdMediaDtoMapper.toDto(updateAdMediaInputModel)
      );
    }).map(
            (AdResponseDto response) => adResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<AdModel>> deleteAdMedia(
      String adId,
      String mediaType,
      String mediaUrl,
      ) {
    return callApi(() {
      return adService.deleteAdMedia(
          adId,
          mediaType,
          mediaUrl,
      );
    }).map(
            (AdResponseDto response) => adResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<AdModel>> updateAd(
      String adId,
      UpdateAdInputModel updateAdInputModel,
      ) {
    return callApi(() {
      return adService.updateAd(
        adId,
        updateAdDtoMapper.toDto(updateAdInputModel),
      );
    }).map(
            (AdResponseDto response) => adResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<AdModel>> getAd(
      String adId,
      ) {
    return callApi(() {
      return adService.getAd(
        adId,
      );
    }).map(
            (AdResponseDto response) => adResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<AdModel>> showAd(
      String pageLocation,
      ) {
    return callApi(() {
      return adService.showAd(
        pageLocation,
      );
    }).map(
            (AdResponseDto response) => adResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<RecordAdActionModel>> setRecordAdAction(
      String adId,
      RecordAdActionInputModel recordAdActionInputModel,
      ) {
    return callApi(() {
      return adService.recordAdAction(
        adId,
        recordAdActionDtoMapper.toDto(recordAdActionInputModel),
      );
    }).map(
            (RecordAdActionResponseDto response) => recordAdActionResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<AdActionStatsModel>> getAdActionStats(
      String adId
      ) {
    return callApi(() {
      return adService.adActionStats(
        adId,
      );
    }).map(
            (AdActionStatsResponseDto response) => adActionStatsResponseDtoMapper.fromDto(response)
    );
  }

}