import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/ticket/models/purchase_status_model.dart';
import 'package:billit_now/services/ticket/response_dto/purchase_tickets_response_dto.dart';
import 'package:injectable/injectable.dart';

@injectable
class PurchaseStatusDtoMapper extends BaseDtoMapper<PurchaseStatusDto, PurchaseStatusModel> {
  @override
  PurchaseStatusModel fromDto(PurchaseStatusDto dto) {
    switch (dto) {
      case PurchaseStatusDto.pending:
        return PurchaseStatusModel.pending;
      case PurchaseStatusDto.completed:
        return PurchaseStatusModel.completed;
      case PurchaseStatusDto.cancelled:
        return PurchaseStatusModel.cancelled;
    }
  }

  @override
  PurchaseStatusDto toDto(PurchaseStatusModel model) {
    switch (model) {
      case PurchaseStatusModel.pending:
        return PurchaseStatusDto.pending;
      case PurchaseStatusModel.completed:
        return PurchaseStatusDto.completed;
      case PurchaseStatusModel.cancelled:
        return PurchaseStatusDto.cancelled;
    }
  }

}