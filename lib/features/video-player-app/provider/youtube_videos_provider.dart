import 'package:youtube_api/youtube_api.dart';

import 'package:flutter/cupertino.dart';

class YoutubeVideoProvider extends ChangeNotifier {
  List<YouTubeVideo> trendingVidoes = [];
  List<YouTubeVideo> techVidoes = [];
  List<YouTubeVideo> motivationVidoes = [];

  fetchVideos() async {
    String key = 'AIzaSyAl1LL3QPxU_fg7PIve-wdkYk_jRIbajGU';
    YoutubeAPI ytApi = new YoutubeAPI(key, maxResults: 25);
    techVidoes = await ytApi.search("technology", type: 'video');
    motivationVidoes = await ytApi.search("motivational videos", type: 'video');
    trendingVidoes = await ytApi.getTrends(regionCode: 'PK');
    notifyListeners();
    return 1;
  }
}
