import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import 'package:video_player/video_player.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/dimenstion.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/notification_widget.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../provider/youtube_videos_provider.dart';

class NetworkVideoPlayer extends StatefulWidget {
  final YouTubeVideo video;
  final String type;
  const NetworkVideoPlayer({
    required this.video,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  State<NetworkVideoPlayer> createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  late YoutubePlayerController _controller;
  List<YouTubeVideo> playList = [];

  late String? id;
  @override
  void initState() {
    updatePlaylist();

    id = YoutubePlayer.convertUrlToId(widget.video.url);
    _controller = YoutubePlayerController(
      initialVideoId: id!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    super.initState();
  }

  updatePlaylist() {
    YoutubeVideoProvider youtubeVideoProvider =
        Provider.of(context, listen: false);
    playList = widget.type == 'tech'
        ? youtubeVideoProvider.techVidoes
        : widget.type == "trend"
            ? youtubeVideoProvider.trendingVidoes
            : youtubeVideoProvider.motivationVidoes;
    playList.shuffle();

    print(playList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          // bottomActions: [],
          // aspectRatio: 6 / 14,
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          onReady: () {
            _controller.addListener(() {});
          },
        ),
        builder: (context, player) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    child: player,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BoldText(
                            text: widget.video.title,
                            maxlines: 2,
                          ),
                          RegularText(
                            text: widget.video.description!,
                            maxLines: 3,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                  Consumer<YoutubeVideoProvider>(
                      builder: (context, provider, snapshot) {
                    return Expanded(
                      child: Container(
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: playList.length,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      String newCode =
                                          YoutubePlayer.convertUrlToId(
                                              playList[index].url)!;
                                      _controller.load(newCode);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: Dimensions.screenHeight * 0.13,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          playList[index]
                                                              .thumbnail
                                                              .medium
                                                              .url!),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              flex: 5,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      BoldText(
                                                        text: playList[index]
                                                            .title,
                                                        maxlines: 2,
                                                      ),
                                                      RegularText(
                                                        text: playList[index]
                                                            .description!,
                                                        maxLines: 3,
                                                        size: 12,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              flex: 5,
                                            ),
                                            Divider(
                                              thickness: 1,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          );
        });
  }
}
