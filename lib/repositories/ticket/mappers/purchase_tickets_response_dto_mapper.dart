import 'package:billit_now/repositories/ticket/mappers/purchase_status_dto_mapper.dart';
import 'package:billit_now/repositories/ticket/mappers/ticket_response_dto_mapper.dart';
import 'package:billit_now/repositories/ticket/models/ticket_model.dart';
import 'package:billit_now/services/ticket/response_dto/ticket_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../services/ticket/response_dto/purchase_tickets_response_dto.dart';
import '../../base/base_dto_mapper.dart';
import '../models/purchase_tickets_model.dart';

@injectable
class PurchaseTicketsResponseDtoMapper implements BaseDtoMapper<PurchaseTicketsResponseDto, PurchaseTicketsModel> {
  final PurchaseStatusDtoMapper purchaseStatusDtoMapper;
  final TicketResponseDtoMapper ticketResponseDtoMapper;
  const PurchaseTicketsResponseDtoMapper({
    required this.purchaseStatusDtoMapper,
    required this.ticketResponseDtoMapper,
  });
  @override
  PurchaseTicketsResponseDto toDto(PurchaseTicketsModel model) {
    return PurchaseTicketsResponseDto(
      userId: model.userId,
      totalAmount: model.totalAmount,
      status: purchaseStatusDtoMapper.toDto(model.status),
      id: model.id,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      tickets: model.tickets.map((TicketModel model){
        return ticketResponseDtoMapper.toDto(model);
      }).toList(),
    );
  }

  @override
  PurchaseTicketsModel fromDto(PurchaseTicketsResponseDto dto) {
    return PurchaseTicketsModel(
      userId: dto.userId,
      totalAmount: dto.totalAmount,
      status: purchaseStatusDtoMapper.fromDto(dto.status),
      id: dto.id,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      tickets: dto.tickets.map((TicketResponseDto dto) {
        return ticketResponseDtoMapper.fromDto(dto);
      }).toList(),
    );
  }
}
