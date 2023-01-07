import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/images.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/videos/favorite_videos/favourite_video.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/videos/online_videos/all_videos.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/videos/online_videos/gallery_videos.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/videos/search_online_video.dart';
import 'package:video_player_app/features/video-player-app/provider/youtube_videos_provider.dart';
import '../../../Utils/dimenstion.dart';
import '../../../widgets/big_custom_appbar.dart';
import '../../../widgets/bold_text.dart';
import '../../../widgets/medium_video_tile.dart';
import '../../../widgets/menu_option_widget.dart';
import '../../../widgets/regular_text.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<String> _menuOpetionsList = [
    "For You",
    "Device Videos",
  ];
  List<String> _moodsTitle = ["Sad", "Chil", "Happy", "Horror"];
  List<String> _singersTitle = ["Eminem", "Honny Singh", "Gippy", "Atif"];

  List<Color> _colorsList = [
    Colors.blue,
    Colors.purple,
    Colors.yellow,
    Colors.green,
  ];
  int selectedIndex = 0;
  late YoutubeVideoProvider youtubeVideoProvider =
      Provider.of(context, listen: false);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigCustomAppBar(
        title: "Online Videos",
        firstIconTap: () {
          Get.to(SearchOnlineVideo());
        },
        secondIconTap: () {
          Get.to(FavouriteVideoPage());
        },
        firstIcon: Icons.search,
        secondIcon: Icons.favorite_border,
        color: Colors.black.withOpacity(.6),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // CustomAppBar(
          //   title: "Online Videos",
          //   icon: Icons.search,
          //   secondIcon: Icons.favorite_border_sharp,
          //   iconColor: Colors.black.withOpacity(.6),
          // ),
          Column(
            children: [
              SizedBox(
                height: Dimensions.height15,
              ),

              //* Menu section

              Container(
                  height: Dimensions.height30 + 5,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: _menuOpetionsList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.width10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                                if (index == 1) {
                                  Get.to(DeviceVideoScreen());
                                }
                              },
                              child: MenuOptionsWidget(
                                index: index,
                                title: _menuOpetionsList[index],
                                selectedIndex: selectedIndex,
                              ),
                            ),
                          ),
                        );
                      }))),
              SizedBox(
                height: Dimensions.height15,
              ),

              //* */ Trending Artitist
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BoldText(
                    text: "Trending Artists",
                    size: Dimensions.font16,
                  ),
                ),
              ),

              Container(
                height: Dimensions.height140,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: ((context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(AllVideosPage());
                        },
                        child: CircularImageWidget(
                          title: _singersTitle[index],
                          imgUrl: "assets/images/singer.jpeg",
                        ),
                      );
                    })),
              ),
              SizedBox(
                height: Dimensions.height15,
              ),

              // * Moods

              Padding(
                padding: EdgeInsets.only(left: Dimensions.width15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BoldText(
                    text: "Moods",
                    size: Dimensions.font16,
                  ),
                ),
              ),
              Container(
                height: Dimensions.height140,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: ((context, index) {
                      return CircularImageWidget(
                        title: _moodsTitle[index],
                        imgUrl: AppIcons.glass,
                        bgColor: _colorsList[index],
                      );
                    })),
              )

              // * Trending Music Videos
              ,
              SizedBox(
                height: Dimensions.height15,
              ),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BoldText(
                    text: "Trending Vidoes",
                    size: Dimensions.font16,
                  ),
                ),
              ),
              FutureBuilder(
                future: youtubeVideoProvider.fetchVideos(),
                // initialData: InitialData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Consumer<YoutubeVideoProvider>(
                        builder: (context, provider, snapshot) {
                      return Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.trendingVidoes.length,
                            itemBuilder: ((context, index) {
                              return MediumVideoTile(
                                type: 'trend',
                                video: provider.trendingVidoes[index],
                                videoUrl: provider.motivationVidoes[index].url,
                                title: provider.trendingVidoes[index].title,
                                subtitle: provider
                                    .trendingVidoes[index].description
                                    .toString(),
                                imgUrl: provider
                                    .trendingVidoes[index].thumbnail.medium.url
                                    .toString(),
                              );
                            })),
                      );
                    });
                  } else {
                    return JumpingDotsProgressIndicator(
                      fontSize: 50,
                      dotSpacing: 2,
                    );
                  }
                },
              ),

              // * Motivational Vidoes

              Padding(
                padding: EdgeInsets.only(left: Dimensions.width15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BoldText(
                    text: "Motivational Vidoes",
                    size: Dimensions.font16,
                  ),
                ),
              ),
              FutureBuilder(
                future: youtubeVideoProvider.fetchVideos(),
                // initialData: InitialData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Consumer<YoutubeVideoProvider>(
                        builder: (context, provider, snapshot) {
                      return Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.motivationVidoes.length,
                            itemBuilder: ((context, index) {
                              return MediumVideoTile(
                                type: 'motivation',
                                video: provider.motivationVidoes[index],
                                videoUrl: provider.motivationVidoes[index].url,
                                title: provider.motivationVidoes[index].title,
                                subtitle: provider
                                        .motivationVidoes[index].description ??
                                    "Welcome to this video",
                                imgUrl: provider.motivationVidoes[index]
                                    .thumbnail.medium.url
                                    .toString(),
                              );
                            })),
                      );
                    });
                  } else {
                    return JumpingDotsProgressIndicator(
                      fontSize: 50,
                      dotSpacing: 2,
                    );
                  }
                },
              ),

              // * Science and Technology

              Padding(
                padding: EdgeInsets.only(left: Dimensions.width15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: BoldText(
                    text: "Science & Technology",
                    size: Dimensions.font16,
                  ),
                ),
              ),
              FutureBuilder(
                future: youtubeVideoProvider.fetchVideos(),
                // initialData: InitialData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Consumer<YoutubeVideoProvider>(
                        builder: (context, provider, snapshot) {
                      return Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.techVidoes.length,
                            itemBuilder: ((context, index) {
                              return MediumVideoTile(
                                type: 'tech',
                                video: provider.techVidoes[index],
                                videoUrl: provider.techVidoes[index].url,
                                title: provider.techVidoes[index].title,
                                subtitle:
                                    provider.techVidoes[index].description ??
                                        "Welcome to this video",
                                imgUrl: provider
                                    .techVidoes[index].thumbnail.medium.url
                                    .toString(),
                              );
                            })),
                      );
                    });
                  } else {
                    return JumpingDotsProgressIndicator(
                      fontSize: 50,
                      dotSpacing: 2,
                    );
                  }
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class CircularImageWidget extends StatelessWidget {
  final String title;
  final String imgUrl;
  final Color? bgColor;

  const CircularImageWidget({
    Key? key,
    required this.title,
    required this.imgUrl,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: Dimensions.height102 - 2,
            width: Dimensions.height102 - 2,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor != null ? bgColor : Colors.transparent,
                image: DecorationImage(
                  image: AssetImage(imgUrl),
                ),
                border: Border.all(
                  color: bgColor != null ? Colors.transparent : Colors.black,
                )),
          ),
          SizedBox(
            height: Dimensions.height5,
          ),
          RegularText(
            text: title,
            size: Dimensions.height10 + 2,
          ),
        ],
      ),
    );
  }
}
