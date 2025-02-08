import 'package:injectable/injectable.dart';

import '../../../services/ticket/response_dto/ticket_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/ticket_status_model.dart';

@injectable
class TicketStatusDtoMapper implements BaseDtoMapper<TicketStatusDto, TicketStatusModel> {
  @override
  TicketStatusDto toDto(TicketStatusModel model) {
    switch (model) {
      case TicketStatusModel.available:
        return TicketStatusDto.available;
      case TicketStatusModel.reserved:
        return TicketStatusDto.reserved;
      case TicketStatusModel.sold:
        return TicketStatusDto.sold;
    }
  }

  @override
  TicketStatusModel fromDto(TicketStatusDto dto) {
    switch (dto) {
      case TicketStatusDto.available:
        return TicketStatusModel.available;
      case TicketStatusDto.reserved:
        return TicketStatusModel.reserved;
      case TicketStatusDto.sold:
        return TicketStatusModel.sold;
    }
  }
}