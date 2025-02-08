import 'package:billit_now/repositories/base/base_repository.dart';
import 'package:billit_now/repositories/ticket/input_models/purchase_tickets_input_model.dart';
import 'package:billit_now/repositories/ticket/mappers/purchase_tickets_dto_mapper.dart';
import 'package:billit_now/repositories/ticket/mappers/purchase_tickets_response_dto_mapper.dart';
import 'package:billit_now/repositories/ticket/mappers/ticket_response_dto_mapper.dart';
import 'package:billit_now/repositories/ticket/models/purchase_tickets_model.dart';
import 'package:billit_now/repositories/ticket/models/ticket_model.dart';
import 'package:billit_now/services/ticket/response_dto/purchase_tickets_response_dto.dart';
import 'package:billit_now/services/ticket/response_dto/ticket_response_dto.dart';
import 'package:billit_now/services/ticket/ticket_service.dart';
import 'package:injectable/injectable.dart';

import '../shared/result.dart';

@singleton
class TicketRepository extends BaseRepository {

  final TicketService ticketService;
  final TicketResponseDtoMapper ticketResponseDtoMapper;
  final PurchaseTicketsDtoMapper purchaseTicketsDtoMapper;
  final PurchaseTicketsResponseDtoMapper purchaseTicketsResponseDtoMapper;
  TicketRepository({
    required this.ticketService,
    required this.ticketResponseDtoMapper,
    required this.purchaseTicketsResponseDtoMapper,
    required this.purchaseTicketsDtoMapper,
  });

  Future<Result<List<TicketModel>>> getTickets(String eventId) {
    return callApi(() {
      return ticketService.tickets(eventId);
    }).map(
            (List<TicketResponseDto> data) => data.map(
                (TicketResponseDto item) => ticketResponseDtoMapper.fromDto(item)
        ).toList()
    );
  }

  Future<Result<TicketModel>> reserveTicket(String ticketId) {
    return callApi(() {
      return ticketService.reserveTicket(ticketId);
    }).map(
            (TicketResponseDto item) => ticketResponseDtoMapper.fromDto(item)
    );
  }

  Future<Result<PurchaseTicketsModel>> purchaseTicket(PurchaseTicketsInputModel purchaseTicketsInputModel) {
    return callApi(() {
      return ticketService.purchaseTicket(
        purchaseTicketsDtoMapper.toDto(purchaseTicketsInputModel)
      );
    }).map(
            (PurchaseTicketsResponseDto item) => purchaseTicketsResponseDtoMapper.fromDto(item)
    );
  }

}