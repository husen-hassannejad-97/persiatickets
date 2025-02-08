import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../base/base_dto.dart';

part 'getting_there_response_dto.g.dart';

@JsonSerializable()
class GettingThereResponseDto implements BaseDto {
  final String title;
  final List<String> routes;

  GettingThereResponseDto({
    required this.title,
    required this.routes,
  });

  @factoryMethod
  factory GettingThereResponseDto.fromJson(Map<String, dynamic> json) => _$GettingThereResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GettingThereResponseDtoToJson(this);
}