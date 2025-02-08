import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/about_artist_model.dart';
import 'package:billit_now/repositories/event/models/programs_model.dart';
import 'package:billit_now/repositories/event/models/programs_status.dart';
import 'package:billit_now/repositories/event/models/venue_facilities_model.dart';
import 'package:billit_now/repositories/event/models/venue_location_model.dart';
import 'package:billit_now/services/event/response_dto/event_artist_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_program_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_venue_facility_response_dto.dart';
import 'package:billit_now/services/venue/response_dto/venue_response_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class EventVenueResponseVenueLocationDtoMapper
    extends BaseDtoMapper<VenueResponseDto, VenueLocationModel> {
  @override
  VenueLocationModel fromDto(VenueResponseDto dto) {
    return VenueLocationModel(
        name: dto.name,
        address: dto.address,
        lat: dto.latitude ?? 0.0,
        lon: dto.longitude ?? 0.0,
        overViewDesc: dto.description ?? "",
        nearbyAmenitiesDesc: dto.nearbyAmenities ?? "",
        gettingThereItems: List.generate(dto.gettingThere?.length ?? 0, (gtIndex) {
          return GettingThereItems(
              title: dto.gettingThere![gtIndex].title,
              items: List.generate(dto.gettingThere![gtIndex].routes.length, (iIndex) {
                return dto.gettingThere![gtIndex].routes[iIndex];
              })
          );
        }),
    );
  }

  @override
  VenueResponseDto toDto(VenueLocationModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}