import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/artist_model.dart';

class ArtistProvider extends ChangeNotifier {
  List<ArtistTabModel> artistsList = [];
  List<String> artistNamesList = [];

  fetchArtists(List<SongModel> songs) {
    for (ArtistTabModel artists in artistsList) {
      artists.songsList.clear();
    }
    for (SongModel element in songs) {
      if (artistsList.isEmpty && element.artist != null) {
        artistsList.add(
          ArtistTabModel(name: element.artist!, songsList: [element]),
        );

        setNamesList();
        // notifyListeners();
      } else if (element.artist != null) {
        if (artistNamesList.contains(element.artist)) {
          for (ArtistTabModel artists in artistsList) {
            if (element.artist == artists.name) {
              if (artists.songsList.contains(element)) {
              } else {
                artists.setSongs(element);
              }
            }
          }
        } else {
          artistsList
              .add(ArtistTabModel(name: element.artist!, songsList: [element]));
          setNamesList();
        }
        // notifyListeners();
      }
    }
    print(artistsList);
    print(artistNamesList);
  }

  setNamesList() {
    for (ArtistTabModel artist in artistsList) {
      if (artistNamesList.contains(artist.name)) {
      } else {
        artistNamesList.add(artist.name);
      }
    }
  }
}
