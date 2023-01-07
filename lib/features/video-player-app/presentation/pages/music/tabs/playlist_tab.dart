import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/colors.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/music/tabs/songs_tab.dart';

import '../../../../provider/music_playlist_provider.dart';
import '../../../Utils/dimenstion.dart';
import '../../../Utils/images.dart';
import '../../../widgets/bold_text.dart';
import '../../../widgets/regular_text.dart';
import '../player/orange_music_player.dart';
import '../widgets/bottom_sheet.dart';

class PlayListTab extends StatelessWidget {
  PlayListTab({
    Key? key,
  }) : super(key: key);

  final List<Color> color = [Colors.black, AppColors.redColor, Colors.pink];
  final List<String> icons = [
    MusicIcons.createPlay,
    MusicIcons.recentTrack,
    MusicIcons.top
  ];
  final List<String> titles = [
    "Craete playlist",
    "Recent Track",
    "My top List"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: Dimensions.height15,
        ),
        GestureDetector(
          onTap: () {
            print(context.read<PlayListprovider>().playListSongs);

            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50))),
                context: context,
                builder: ((context) => CreateNewPlayListBottomSheet()));
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: AppColors.deepPurpleColor,
                      image: DecorationImage(
                          image: AssetImage(
                            MusicIcons.createPlay,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BoldText(
                      text: "Create new playlist",
                      size: 17,
                    ),
                  ),
                ],
              )),
        ),
        Expanded(child:
            Consumer<PlayListprovider>(builder: (context, provider, child) {
          return ListView.builder(
              itemCount: provider.playListSongs.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 30, top: 20),
                  child: GestureDetector(
                    onTap: () {
                      // showModalBottomSheet(
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.vertical(
                      //           top: Radius.circular(20))),
                      //   context: context,
                      //   builder: ((context) => PlayListItemsBottomSheet()),
                      // );
                    },
                    child: PlayListItem(
                      // song: song,
                      playName: provider.playListSongs[index].playName,
                      playlist: provider.playListSongs[index].playlist,
                      playlistImg: provider.playListSongs[index].playlistImg,
                      index: index,
                    ),
                  ),
                );
              }));
        }))
      ],
    );
  }
}

class PlayListItemsBottomSheet extends StatefulWidget {
  int index;

  PlayListItemsBottomSheet({
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<PlayListItemsBottomSheet> createState() =>
      _CreateNewPlayListBottomSheetState();
}

class _CreateNewPlayListBottomSheetState
    extends State<PlayListItemsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return buildSheet(context: context);
  }

  Widget buildSheet({String? route, required BuildContext context}) {
    return Container(
      height: 400,
      child: PlayListView(index: widget.index),
    );
  }
}

class PlayListView extends StatefulWidget {
  int index;
  PlayListView({required this.index, Key? key}) : super(key: key);

  @override
  State<PlayListView> createState() => _PlayListViewState();
}

class _PlayListViewState extends State<PlayListView> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListprovider>(builder: (context, provider, child) {
      return Container(
        // height: 500,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BoldText(
                text: provider.playListSongs[widget.index].playName,
                size: 18,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: provider.playListSongs[widget.index].playlist.length,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () async {
                      // _changePlayerVisbility();
                      // setState(() {
                      //   currentIndex++;
                      // });

                      Get.to(OrangeMusicPlayer(
                        songs: provider.playListSongs[widget.index].playlist,
                        currentindex: index,
                        updatedIndex: (updatedIndex) {
                          setState(() {
                            currentIndex == updatedIndex;
                          });
                        },
                      ));
                    },
                    child: SongsRowWidget(
                      songName: provider
                          .playListSongs[widget.index].playlist[index].title,
                      subtitle: provider.playListSongs[widget.index]
                          .playlist[index].displayName,
                      song:
                          provider.playListSongs[widget.index].playlist[index],
                      img: QueryArtworkWidget(
                        id: provider
                            .playListSongs[widget.index].playlist[index].id,
                        type: ArtworkType.AUDIO,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    });
  }
}
