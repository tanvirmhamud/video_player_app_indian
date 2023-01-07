import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../model/playlist_model.dart';

class PlayListprovider extends ChangeNotifier {
  List<PlayListModelClass> _playLists = [];
  List<String> _songs = ["Dill Nahi", "Dill Hare", "Yoyo", "Raste"];
  List<PlayListModelClass> get playListSongs => _playLists;
  List<String> get songs => _songs;

  openPlaylist({required String playlistName, File? playImage}) {
    bool exists = false;
    for (PlayListModelClass element in _playLists) {
      if (element.playName == playlistName) {
        exists = true;

        break;
      }
    }

    if (!exists) {
      _playLists.add(
        PlayListModelClass(
            playName: playlistName, playlistImg: playImage, playlist: []),
      );
    }
    // if (exists) {
    //   Get.snackbar("Playlist", "Already exists with this name");
    // }

    notifyListeners();

    // notifyListeners();
  }

  addSongsInPlaylist({required SongModel song, required String playlistName}) {
    print(playlistName);
    _playLists.forEach((element) {
      print(element);
      print(element.playName == playlistName);
      if (element.playName == playlistName) {
        if (element.playlist.contains(song)) {
          Get.snackbar("Already", "in Playlist");
        } else {
          element.playlist.add(song);
          Get.snackbar("Added", "in Playlist");
          print(element.playlist);
        }
      }
    });
    // _playListsongs.first;
    notifyListeners();
  }

  addSong(String song) {
    _songs.add(song);
  }
}
