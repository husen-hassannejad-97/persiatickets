import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/about_organizer_model.dart';
import 'package:billit_now/services/shared_response_dto/organizer_response_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrganizerResponseDtoMapper extends BaseDtoMapper<OrganizerResponseDto, OrganizerModel> {
  @override
  OrganizerModel fromDto(OrganizerResponseDto dto) {
    return OrganizerModel(
        organizerImage: dto.image ?? "",
        name: '${dto.firstName} ${dto.lastName}'.trim(),
        phoneNumber: dto.phoneNumber ?? "",
        emailAddress: dto.email ?? "",
        company: dto.company ?? "",
        officeNumber: dto.officeNumber ?? "",
        address: dto.address ?? "",
        socials: List.empty(), // TODO Missing data from server
        featuredSingers: List.empty() // TODO Missing data from server
    );
  }

  @override
  OrganizerResponseDto toDto(OrganizerModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}