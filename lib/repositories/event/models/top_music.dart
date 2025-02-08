import '../../base/base_model.dart';

class TopMusicModel implements BaseModel {
  final String source;
  final String name;
  final String album;

  TopMusicModel({
    required this.source,
    required this.name,
    required this.album,
  });
}
