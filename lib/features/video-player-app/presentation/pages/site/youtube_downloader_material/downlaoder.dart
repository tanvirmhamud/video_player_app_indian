

import 'dart:convert';

import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Download {
  Future<void> downloadVideo(String youTube_link, String title) async {
    final result = await FlutterYoutubeDownloader.downloadVideo(
        youTube_link, "$title", 18);
    print(result);




  }



}