import 'package:billit_now/repositories/event/models/top_music.dart';

import '../../base/base_model.dart';

class AboutArtistModel implements BaseModel {
  final String artistName;
  final String about;
  final List<TopMusicModel> musics;

  AboutArtistModel({
    required this.artistName,
    required this.about,
    required this.musics,
  });
}
