import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/programs_model.dart';
import 'package:billit_now/repositories/event/models/programs_status.dart';
import 'package:billit_now/services/event/response_dto/event_program_response_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class EventProgramResponseDtoMapper extends BaseDtoMapper<EventProgramResponseDto, ProgramsModel> {
  @override
  ProgramsModel fromDto(EventProgramResponseDto dto) {
    return ProgramsModel(
        date: dto.startDateTime,
        time: dto.startDateTime,
        status: dto.ticketSaleStart.isAfter(DateTime.now()) ? ProgramsStatus.comingSoon : ProgramsStatus.completing,
        seatsCount: dto.ticketsAvailable,
        priceRange: '${dto.minTicketPrice} - ${dto.maxTicketPrice}'
    );
  }

  @override
  EventProgramResponseDto toDto(ProgramsModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}