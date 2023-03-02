import 'dart:io';

// import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/videos/online_videos/better_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../../provider/gallery_videos_provider.dart';
import '../../../widgets/big_custom_appbar.dart';

class DeviceVideoScreen extends StatefulWidget {
  const DeviceVideoScreen({super.key});
  @override
  DeviceVideoScreenState createState() => DeviceVideoScreenState();
}

class DeviceVideoScreenState extends State<DeviceVideoScreen> {
  List videos = [];
  late var uint8list;
  late GalleryVideosProvider galleryVideosProvider;

  @override
  void initState() {
    galleryVideosProvider =
        Provider.of<GalleryVideosProvider>(context, listen: false);

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

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigCustomAppBar(
        title: "Gallery Videos",
        firstIconTap: () {
          // Get.to(SearchOnlineVideo());
        },
        secondIconTap: () {
          // Get.to(FavouriteVideoPage());
        },
        // firstIcon: Icons.search,
        // secondIcon: Icons.favorite_border,
        color: Colors.black.withOpacity(.6),
      ),
      body: FutureBuilder(
        future: galleryVideosProvider.fetchVideos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Consumer<GalleryVideosProvider>(
                  builder: (context, provider, child) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.videosPathList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(BetterPlayerView(
                                path: provider.videosPathList[index],
                                index: index,
                              ));
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      FutureBuilder(
                                        future: _generateThumbnail(
                                            provider.videosPathList[index]),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider.videosPathList[index]
                                                    .toString()
                                                    .split("/")
                                                    .last
                                                    .split(".mp4")
                                                    .first
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              // Spacer(),
                                              Text(
                                                provider.videosPathList[index]
                                                    .toString()
                                                    .split("/")
                                                    .elementAt(4)
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
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
                    ),
                  ],
                );
              }),
            );
          } else {
            // return Center(child: JumpingDotsProgressIndicator());
            return Center(
              child: Text(
                "Loading...",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
