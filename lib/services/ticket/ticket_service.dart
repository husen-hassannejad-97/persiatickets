import 'package:billit_now/services/base/base_service.dart';
import 'package:billit_now/services/ticket/dto/purchase_tickets_dto.dart';
import 'package:billit_now/services/ticket/response_dto/purchase_tickets_response_dto.dart';
import 'package:billit_now/services/ticket/response_dto/ticket_response_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'ticket_service.g.dart';

@RestApi()
@singleton
abstract class TicketService extends BaseService {

  @factoryMethod
  factory TicketService(Dio dio) = _TicketService;

  @GET('tickets/event/{event_id}')
  Future<List<TicketResponseDto>> tickets(@Path("event_id") String eventId);

  @POST('tickets/reserve')
  Future<TicketResponseDto> reserveTicket(@Query("ticket_id") String ticketId);

  @POST('tickets/purchase')
  Future<PurchaseTicketsResponseDto> purchaseTicket(@Body() PurchaseTicketsDto purchaseTicketsDto);

}