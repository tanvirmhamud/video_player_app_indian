import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/Controller/theme.dart';

import 'package:video_player_app/features/video-player-app/presentation/Utils/colors.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/dimenstion.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/images.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/home/widgets/custom_text_field.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/music/tabs/album_tab.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/music/tabs/artist_tab.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/music/tabs/playlist_tab.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/music/tabs/songs_tab.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/big_bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';
import 'package:video_player_app/features/video-player-app/provider/recent_songs_provider.dart';

import '../../../provider/music_search_provider.dart';

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final List<String> cataList = [
    "Songs",
    "PlayList",
    "Artist",
    "Albums",
    "Genre",
    "Folcs",
    "Catagory",
    "Old",
    "Classic",
  ];

  final List<Widget> tabsList = [
    SongsTab(),
    PlayListTab(),
    ArtistsTab(),
    AlbumTab(),
    SongsTab(),
    PlayListTab(),
    SongsTab(),
    PlayListTab(),
    PlayListTab(),
  ];

  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();
  bool searchActive = false;
  final OnAudioQuery _onAudioQuery = OnAudioQuery();
  late MusicSearchProvider searchProvider;

  @override
  void initState() {
    searchProvider = Provider.of(context, listen: false);
    super.initState();
    // requestStoragePermission();
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _onAudioQuery.permissionsRequest();
      if (!permissionStatus) {
        await _onAudioQuery.permissionsRequest();
      }
      // ensure build method
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.height10 - 2),
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width15, right: Dimensions.width15),
                height: Dimensions.height70,
                width: Dimensions.screenWidth,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3),
                      color: Colors.grey.withOpacity(.5),
                      spreadRadius: 1,
                      blurRadius: 5)
                ]),
                child: Consumer<MusicSearchProvider>(
                    builder: (context, provider, child) {
                  return GetBuilder<ThemeController>(builder: (controller) {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (provider.getSearchActive)
                            Expanded(
                              child: TextField(
                                cursorColor: AppColors.cursorColor,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: AppColors.underlineBorder),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5,
                                        color: AppColors.underlineBorder),
                                  ),
                                ),
                                onChanged: (value) {
                                  provider.updateSearchTerm(value);
                                },
                              ),
                            ),
                          if (!provider.getSearchActive)
                            Row(
                              children: [
                                Icon(
                                  Icons.menu,
                                  color: controller.mainColor,
                                ),
                                SizedBox(
                                  width: Dimensions.height15,
                                ),
                                RegularText(
                                  text: "Music",
                                  color: controller.mainColor,
                                  size: Dimensions.font20,
                                )
                              ],
                            ),
                          // if (!searchActive)
                          GestureDetector(
                            onTap: () {
                              searchProvider.updateSearchActive(
                                  !provider.getSearchActive);
                              // setState(() {
                              // searchActive = !searchActive;
                              // });
                            },
                            child: Icon(
                              Icons.search,
                              color: controller.mainColor,
                            ),
                          ),
                        ]);
                  });
                }),
              ),
            ),
            SizedBox(
              height: Dimensions.width15,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width15, right: Dimensions.width15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RegularText(
                  text: "Recently Played",
                  color: Colors.black,
                  size: Dimensions.font20,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height15,
            ),

            // * songs square widget

            Container(
              height: 120,
              width: 400,
              child: Consumer<RecentPlayedProvider>(
                  builder: (context, value, child) {
                return ListView.builder(
                    itemCount: value.recentPlayerSongs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: MusicSquareWigdet(
                          song: value.recentPlayerSongs[index],
                        ),
                      );
                    }));
              }),
            ),

            SizedBox(
              height: Dimensions.height15,
            ),

            // * items list
            Container(
              height: Dimensions.height53 - 3,
              width: double.infinity,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cataList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: RegularText(
                              text: cataList[index],
                              size: Dimensions.font16,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height5,
                          ),
                          selectedIndex == index
                              ? AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  height: 2,
                                  width: Dimensions.height45 - 5,
                                  color: AppColors.redPurpleColor,
                                )
                              : Container()
                        ],
                      ),
                    );
                  })),
            ),

            Container(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.width15, right: Dimensions.width15),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .54,
                    width: double.infinity,
                    child: tabsList[selectedIndex],
                  ),
                ),
              ]),
            )
          ],
        ),
      )),
    );
  }
}

class MusicSquareWigdet extends StatelessWidget {
  final SongModel song;

  const MusicSquareWigdet({
    Key? key,
    required this.song,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.height102 - 2,
          width: Dimensions.height102 + 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                  ).nullArtworkWidget !=
                  null
              ? QueryArtworkWidget(
                  id: song.id,
                  type: ArtworkType.AUDIO,
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/mp3_logo.png"),
                      ),
                    ),
                  ),
                ),
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        BigBoldText(
          text: song.title,
          size: Dimensions.height10 + 4,
          //
        ),
        RegularText(
          text: song.displayName,
          size: Dimensions.height10 + 2,
        ),
      ],
    );
  }
}
