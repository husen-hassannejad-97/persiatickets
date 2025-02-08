import 'package:billit_now/services/base/base_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'purchase_tickets_dto.g.dart';

@JsonSerializable()
class PurchaseTicketsDto implements BaseDto {
  final List<int> ticketIds;

  PurchaseTicketsDto({
    required this.ticketIds,
  });

  @factoryMethod
  factory PurchaseTicketsDto.fromJson(Map<String, dynamic> json) =>
      _$PurchaseTicketsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseTicketsDtoToJson(this);
}