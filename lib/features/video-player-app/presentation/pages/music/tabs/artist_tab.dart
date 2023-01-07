import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/model/artist_model.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/colors.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/music/tabs/songs_tab.dart';
import 'package:video_player_app/features/video-player-app/provider/music_artist_povider.dart';

import '../../../../provider/music_playlist_provider.dart';
import '../../../Utils/dimenstion.dart';
import '../../../Utils/images.dart';
import '../../../widgets/big_bold_text.dart';
import '../../../widgets/bold_text.dart';
import '../../../widgets/regular_text.dart';
import '../player/orange_music_player.dart';
import '../widgets/artist_widget.dart';

class ArtistsTab extends StatelessWidget {
  ArtistsTab({
    Key? key,
  }) : super(key: key);

  final List<Color> color = [Colors.black, AppColors.redColor, Colors.pink];
  final List<String> icons = [AppIcons.browser, AppIcons.clock, AppIcons.star];
  final List<String> titles = [
    "Craete playlist",
    "Recent Track",
    "My top List"
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ArtistProvider>(builder: (context, provider, child) {
      return Container(
          child: Row(
              children: List.generate(provider.artistsList.length, (index) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(50))),
                context: context,
                builder: ((context) => ArtistBottomSheet(
                      songs: provider.artistsList[index].songsList,
                      artist: provider.artistsList[index],
                    )));
          },
          child: ArtistsSquareWigdet(
            bgImg: AppImages.artists,
            name: provider.artistsList[index].name,
            countSongs: provider.artistsList[index].songsList.length,
          ),
        );
      })));
    });
  }
}

class ArtistBottomSheet extends StatefulWidget {
  List<SongModel> songs;
  ArtistTabModel artist;

  ArtistBottomSheet({
    required this.songs,
    required this.artist,
    Key? key,
  }) : super(key: key);

  @override
  State<ArtistBottomSheet> createState() =>
      _CreateNewPlayListBottomSheetState();
}

class _CreateNewPlayListBottomSheetState extends State<ArtistBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return buildSheet(context: context);
  }

  Widget buildSheet({String? route, required BuildContext context}) {
    return Container(
      height: 400,
      child: ArtistListView(
        songs: widget.songs,
        artist: widget.artist,
      ),
    );
  }
}

class ArtistListView extends StatefulWidget {
  List<SongModel> songs;
  ArtistTabModel artist;
  ArtistListView({required this.songs, required this.artist, Key? key})
      : super(key: key);

  @override
  State<ArtistListView> createState() => _ArtistListListViewState();
}

class _ArtistListListViewState extends State<ArtistListView> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BoldText(
              text: "Artist ${widget.artist.name}",
              size: 18,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.songs.length,
              scrollDirection: Axis.vertical,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () async {
                    // _changePlayerVisbility();
                    // setState(() {
                    //   currentIndex++;
                    // });

                    Get.to(OrangeMusicPlayer(
                      songs: widget.songs,
                      currentindex: index,
                      updatedIndex: (updatedIndex) {
                        setState(() {
                          currentIndex == updatedIndex;
                        });
                      },
                    ));
                  },
                  child: SongsRowWidget(
                    songName: widget.songs[index].title,
                    subtitle: widget.songs[index].displayName,
                    song: widget.songs[index],
                    img: QueryArtworkWidget(
                      id: widget.songs[index].id,
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
  }
}
