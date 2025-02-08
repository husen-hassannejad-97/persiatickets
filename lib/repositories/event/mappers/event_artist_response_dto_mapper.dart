import 'package:billit_now/repositories/base/base_dto_mapper.dart';
import 'package:billit_now/repositories/event/models/about_artist_model.dart';
import 'package:billit_now/repositories/event/models/programs_model.dart';
import 'package:billit_now/repositories/event/models/programs_status.dart';
import 'package:billit_now/repositories/event/models/top_music.dart';
import 'package:billit_now/services/event/response_dto/event_artist_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_details_response_dto.dart';
import 'package:billit_now/services/event/response_dto/event_program_response_dto.dart';
import 'package:injectable/injectable.dart';

import '../../../services/event/response_dto/event_details_music_response_dto.dart';

@injectable
class EventArtistResponseDtoMapper extends BaseDtoMapper<EventDetailsResponseDto, AboutArtistModel> {

  @override
  AboutArtistModel fromDto(EventDetailsResponseDto dto) {
    return AboutArtistModel(
        artistName: dto.eventArtist?.stateName ?? "",
        about: dto.eventArtist?.fullBio ?? dto.eventArtist?.shortBio ?? "",
        musics: dto.musics?.where((EventDetailsMusicResponseDto response) {
              return response.fileUrl != null;
            }).map((EventDetailsMusicResponseDto response) {
              return TopMusicModel(
                  source: response.fileUrl!, name: response.name, album: "");
            }).toList() ??
            List.empty());
  }

  @override
  EventDetailsResponseDto toDto(AboutArtistModel model) {
    // TODO: implement toDto
    throw UnimplementedError();
  }

}