import 'package:freezed_annotation/freezed_annotation.dart';

import '../../base/base_dto.dart';

part 'event_category_dto.g.dart';

@JsonEnum(alwaysCreate: true)
enum EventCategoryDto implements BaseDto {
  theater, concert, cinema;
}

extension EventCategoryModelExtensions on EventCategoryDto {
  String get value {
    switch(this) {
      default:
        return toString().split('.')[1];
    }
  }
}