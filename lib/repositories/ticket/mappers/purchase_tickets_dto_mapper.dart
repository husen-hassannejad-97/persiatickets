import 'package:injectable/injectable.dart';

import '../../../services/ticket/dto/purchase_tickets_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../input_models/purchase_tickets_input_model.dart';

@injectable
class PurchaseTicketsDtoMapper implements BaseDtoMapper<PurchaseTicketsDto, PurchaseTicketsInputModel> {
  @override
  PurchaseTicketsDto toDto(PurchaseTicketsInputModel model) {
    return PurchaseTicketsDto(
      ticketIds: model.ticketIds,
    );
  }

  @override
  PurchaseTicketsInputModel fromDto(PurchaseTicketsDto dto) {
    return PurchaseTicketsInputModel(
      ticketIds: dto.ticketIds,
    );
  }
}