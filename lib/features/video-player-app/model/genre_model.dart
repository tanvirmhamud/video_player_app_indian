import 'package:on_audio_query/on_audio_query.dart';

class GenreTabModel {
  String name;
  List<SongModel> songsList;

  GenreTabModel({
    required this.name,
    required this.songsList,
  });

  setSongs(SongModel song) {
    if (songsList.contains(song)) {
    } else {
      songsList.add(song);
    }
  }

  
}
