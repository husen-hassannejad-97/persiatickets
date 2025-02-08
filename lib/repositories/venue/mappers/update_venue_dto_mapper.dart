import 'package:injectable/injectable.dart';

import '../../../services/venue/dto/update_venue_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../input_models/update_venue_input_model.dart';

@injectable
class UpdateVenueDtoMapper implements BaseDtoMapper<UpdateVenueDto, UpdateVenueInputModel> {
  @override
  UpdateVenueDto toDto(UpdateVenueInputModel model) {
    return UpdateVenueDto(
      name: model.name,
      address: model.address,
      description: model.description,
      capacity: model.capacity,
    );
  }

  @override
  UpdateVenueInputModel fromDto(UpdateVenueDto dto) {
    return UpdateVenueInputModel(
      name: dto.name,
      address: dto.address,
      description: dto.description,
      capacity: dto.capacity,
    );
  }
}
