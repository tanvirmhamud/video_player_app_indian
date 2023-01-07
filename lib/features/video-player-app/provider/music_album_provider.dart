import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/album_model.dart';

class AlbumProvider extends ChangeNotifier {
  List<AlbumTabModel> albumsList = [];
  List<String> albumsNamesList = [];

  fetchAlbums(List<SongModel> songs) {
    print(songs);
    for (AlbumTabModel artists in albumsList) {
      artists.songsList.clear();
    }

    for (SongModel element in songs) {
      print(element);
      if (albumsList.isEmpty && element.album != null) {
        albumsList.add(
          AlbumTabModel(name: element.album!, songsList: [element]),
        );

        setNamesList();
        // notifyListeners();
      } else if (element.album != null) {
        if (albumsNamesList.contains(element.album)) {
          for (AlbumTabModel albums in albumsList) {
            if (element.album == albums.name) {
              albums.setSongs(element);
            }
          }
        } else {
          albumsList.add(
              AlbumTabModel(name: element.album!, songsList: [element]));
          setNamesList();
        }
        // notifyListeners();
      }
    }
    print(albumsList);
    print(albumsNamesList);
  }

  setNamesList() {
    for (AlbumTabModel album in albumsList) {
      if (albumsNamesList.contains(album.name)) {
      } else {
        albumsNamesList.add(album.name);
      }
    }
  }
}
