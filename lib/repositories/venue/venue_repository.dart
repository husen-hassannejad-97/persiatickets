import 'package:billit_now/repositories/base/base_repository.dart';
import 'package:billit_now/repositories/venue/input_models/create_venue_input_model.dart';
import 'package:billit_now/repositories/venue/input_models/update_venue_input_model.dart';
import 'package:billit_now/repositories/venue/mappers/create_venue_dto_mapper.dart';
import 'package:billit_now/repositories/venue/mappers/update_venue_dto_mapper.dart';
import 'package:billit_now/repositories/venue/mappers/venue_response_dto_mapper.dart';
import 'package:billit_now/repositories/venue/models/venue_model.dart';
import 'package:billit_now/services/venue/response_dto/venue_response_dto.dart';
import 'package:billit_now/services/venue/venue_service.dart';
import 'package:injectable/injectable.dart';

import '../shared/result.dart';

@singleton
class VenueRepository extends BaseRepository {

  final VenueService venueService;
  final VenueResponseDtoMapper venueResponseDtoMapper;
  final CreateVenueDtoMapper createVenueDtoMapper;
  final UpdateVenueDtoMapper updateVenueDtoMapper;
  VenueRepository({
    required this.venueService,
    required this.venueResponseDtoMapper,
    required this.createVenueDtoMapper,
    required this.updateVenueDtoMapper,
  });

  Future<Result<List<VenueModel>>> getVenues() {
    return callApi(() {
      return venueService.venues();
    }).map(
            (List<VenueResponseDto> data) => data.map(
                (VenueResponseDto item) => venueResponseDtoMapper.fromDto(item)
        ).toList()
    );
  }

  Future<Result<VenueModel>> createVenue(CreateVenueInputModel createVenueInputModel) {
    return callApi(() {
      return venueService.createVenue(
          createVenueDtoMapper.toDto(createVenueInputModel)
      );
    }).map(
            (VenueResponseDto response) => venueResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<VenueModel>> updateVenue(String venueId, UpdateVenueInputModel updateVenueInputModel) {
    return callApi(() {
      return venueService.updateVenue(
          venueId,
          updateVenueDtoMapper.toDto(updateVenueInputModel)
      );
    }).map(
            (VenueResponseDto response) => venueResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<VenueModel>> deleteVenue(String venueId) {
    return callApi(() {
      return venueService.deleteVenue(
        venueId,
      );
    }).map(
            (VenueResponseDto response) => venueResponseDtoMapper.fromDto(response)
    );
  }

  Future<Result<VenueModel>> getVenue(String venueId) {
    return callApi(() {
      return venueService.venue(
        venueId,
      );
    }).map(
            (VenueResponseDto response) => venueResponseDtoMapper.fromDto(response)
    );
  }

}