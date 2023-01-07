import 'package:on_audio_query/on_audio_query.dart';

class AlbumTabModel {
  String name;
  List<SongModel> songsList;

  AlbumTabModel({
    required this.name,
    required this.songsList,
  });

  setSongs(SongModel song) {
    if (songsList.contains(song)) {
    } else {
      songsList.add(song);
    }
  }

  ResetSongs() {
    songsList.clear();
  }
}
