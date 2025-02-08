import 'package:billit_now/repositories/ticket/mappers/ticket_status_dto_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../services/ticket/response_dto/ticket_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/ticket_model.dart';

@injectable
class TicketResponseDtoMapper implements BaseDtoMapper<TicketResponseDto, TicketModel> {
  final TicketStatusDtoMapper ticketStatusDtoMapper;
  const TicketResponseDtoMapper({
    required this.ticketStatusDtoMapper,
  });
  @override
  TicketResponseDto toDto(TicketModel model) {
    return TicketResponseDto(
      eventId: model.eventId,
      seatId: model.seatId,
      price: model.price,
      status: ticketStatusDtoMapper.toDto(model.status),
      id: model.id,
      orderId: model.orderId,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  @override
  TicketModel fromDto(TicketResponseDto dto) {
    return TicketModel(
      eventId: dto.eventId,
      seatId: dto.seatId,
      price: dto.price,
      status: ticketStatusDtoMapper.fromDto(dto.status),
      id: dto.id,
      orderId: dto.orderId,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
