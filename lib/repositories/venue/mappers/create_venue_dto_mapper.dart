import 'package:injectable/injectable.dart';

import '../../../services/venue/dto/create_venue_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../input_models/create_venue_input_model.dart';

@injectable
class CreateVenueDtoMapper implements BaseDtoMapper<CreateVenueDto, CreateVenueInputModel> {
  @override
  CreateVenueDto toDto(CreateVenueInputModel model) {
    return CreateVenueDto(
      name: model.name,
      address: model.address,
      description: model.description,
      capacity: model.capacity,
    );
  }

  @override
  CreateVenueInputModel fromDto(CreateVenueDto dto) {
    return CreateVenueInputModel(
      name: dto.name,
      address: dto.address,
      description: dto.description,
      capacity: dto.capacity,
    );
  }
}
