import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/provider/gallery_videos_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class BetterPlayerView extends StatefulWidget {
  String path;
  int? index;
  final String? videourl;
  BetterPlayerView({this.index, required this.path, super.key, this.videourl});

  @override
  State<BetterPlayerView> createState() => _BetterPlayerViewState();
}

class _BetterPlayerViewState extends State<BetterPlayerView> {
  // late BetterPlayerController _betterPlayerController;

  late XFile fileTempe = XFile("/" + widget.path);
  late List playList;
  @override
  void initState() {
    if (widget.index != null) {
      GalleryVideosProvider galleryVideosProvider =
          Provider.of(context, listen: false);
      playList = galleryVideosProvider.videosPathList
          .getRange(
              widget.index! + 1, galleryVideosProvider.videosPathList.length)
          .toList();
    }

    super.initState();
  }

  Future _generateThumbnail(String vidPath) async {
    try {
      XFile temFile = XFile("/" + vidPath);
      final fileName = await VideoThumbnail.thumbnailData(
        video: temFile.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 64,
        quality: 75,
      );

      return fileName;
    } catch (e) {
      return 1;
    }
  }

  @override
  void dispose() {
    // _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.videourl != null
        ? Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  BetterPlayer.file(
                    widget.path,
                    betterPlayerConfiguration: BetterPlayerConfiguration(
                      expandToFill: false,
                      fit: BoxFit.contain,
                      autoPlay: true,
                    ),
                  ),
                ],
              ),
            ),
          )
        : widget.index == null
            ? BetterPlayer.file(
                fileTempe.path,
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  expandToFill: false,
                  fit: BoxFit.contain,
                  autoPlay: true,
                ),
              )
            : Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      BetterPlayer.file(
                        fileTempe.path,
                        betterPlayerConfiguration: BetterPlayerConfiguration(
                          expandToFill: false,
                          fit: BoxFit.contain,
                          autoPlay: true,
                        ),
                      ),
                      Consumer<GalleryVideosProvider>(
                          builder: (context, provider, child) {
                        return Expanded(
                            child: Container(
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: ListView.builder(
                            // itemCount: provider.videosPathList.length,
                            itemCount: playList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // _betterPlayerController.
                                  fileTempe = XFile("/" + playList[index]);
                                  setState(() {});
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          FutureBuilder(
                                            future: _generateThumbnail(
                                                playList[index]),
                                            // initialData: InitialData,
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data == 1) {
                                                  return Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "assets/video_logo.png"))),
                                                  );
                                                } else {
                                                  return Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: MemoryImage(
                                                              snapshot.data),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  );
                                                }
                                              } else {
                                                return Container(
                                                  height: 60,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/video_logo.png"))),
                                                );
                                              }
                                            },
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    playList[index]
                                                        .toString()
                                                        .split("/")
                                                        .last
                                                        .split(".mp4")
                                                        .first
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  // Spacer(),
                                                  Text(
                                                    playList[index]
                                                        .toString()
                                                        .split("/")
                                                        .elementAt(4)
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Divider(
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ));
                      })
                    ],
                  ),
                ),
              );
  }
}
