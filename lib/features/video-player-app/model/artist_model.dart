import 'package:on_audio_query/on_audio_query.dart';

class ArtistTabModel {
  String name;
  List<SongModel> songsList;

  ArtistTabModel({
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
