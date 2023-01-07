import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:video_player_app/features/video-player-app/model/genre_model.dart';

import '../model/artist_model.dart';

class GenreProvider extends ChangeNotifier {
  List<GenreTabModel> genreList = [];
  List<String> genreNames = [];

  fetchArtists(List<SongModel> songs) {
    for (GenreTabModel artists in genreList) {
      artists.songsList.clear();
    }
    for (SongModel element in songs) {
      if (genreList.isEmpty && element.genre != null) {
        genreList.add(
          GenreTabModel(name: element.genre!, songsList: [element]),
        );

        setNamesList();
        // notifyListeners();
      } else if (element.genre != null) {
        if (genreNames.contains(element.genre)) {
          for (GenreTabModel artists in genreList) {
            if (element.genre == artists.name) {
              if (artists.songsList.contains(element)) {
              } else {
                artists.setSongs(element);
              }
            }
          }
        } else {
          genreList.add(
            GenreTabModel(
              name: element.genre!,
              songsList: [element],
            ),
          );
          setNamesList();
        }
        // notifyListeners();
      }
    }
    print(genreList);
    print(genreNames);
  }

  setNamesList() {
    for (GenreTabModel genre in genreList) {
      if (genreNames.contains(genre.name)) {
      } else {
        genreNames.add(genre.name);
      }
    }
  }
}
