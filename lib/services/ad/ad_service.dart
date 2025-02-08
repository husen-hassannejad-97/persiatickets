import 'package:billit_now/services/ad/response_dto/ad_action_stats_response_dto.dart';
import 'package:billit_now/services/ad/response_dto/ad_response_dto.dart';
import 'package:billit_now/services/ad/response_dto/record_ad_action_response_dto.dart';
import 'package:billit_now/services/base/base_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'dto/create_ad_dto.dart';
import 'dto/record_ad_action_dto.dart';
import 'dto/update_ad_dto.dart';
import 'dto/update_ad_media_dto.dart';

part 'ad_service.g.dart';

const AddServiceVersion = "v1";

@RestApi()
@singleton
abstract class AdService extends BaseService {

  @factoryMethod
  factory AdService(Dio dio) = _AdService;

  @GET('tbl/ads')
  Future<List<AdResponseDto>> ads(
    @Query("page_location") String pageLocation,
    @Query("limit") int limit,
    @Query("offset") int offset,
  );

  @POST('tbl/ads')
  Future<AdResponseDto> createAd(
      @Body() CreateAdDto createAdDto,
      );

  @POST('tbl/ads/{ad_id}/media')
  Future<AdResponseDto> updateAdMedia(
    @Path("ad_id") String adId,
    @Body() UpdateAdMediaDto updateAdMediaDto,
  );

  @DELETE('tbl/ads/{ad_id}/media')
  Future<AdResponseDto> deleteAdMedia(
    @Path("ad_id") String adId,
      @Query("media_type") String mediaType,
      @Query("media_url") String mediaUrl,
  );

  @PUT('tbl/ads/{ad_id}')
  Future<AdResponseDto> updateAd(
    @Path("ad_id") String adId,
      @Body() UpdateAdDto updateAdDto,
  );

  @GET('tbl/ads/{ad_id}')
  Future<AdResponseDto> getAd(
      @Path("ad_id") String adId,
  );

  @GET('tbl/ads/show')
  Future<AdResponseDto> showAd(
    @Query("page_location") String pageLocation,
  );

  @POST('tbl/ads/{ad_id}/action')
  Future<RecordAdActionResponseDto> recordAdAction(
      @Path("ad_id") String adId,
      @Body() RecordAdActionDto recordAdActionDto,
  );

  @GET('tbl/ads/{ad_id}/stats')
  Future<AdActionStatsResponseDto> adActionStats(
      @Path("ad_id") String adId,
  );

}