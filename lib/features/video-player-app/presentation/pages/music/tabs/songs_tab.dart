import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/music/player/orange_music_player.dart';
import 'package:video_player_app/features/video-player-app/provider/music_artist_povider.dart';
import 'package:video_player_app/features/video-player-app/provider/music_search_provider.dart';

import '../../../../provider/music_album_provider.dart';
import '../../../Utils/dimenstion.dart';
import '../../../Utils/images.dart';
import '../../../widgets/bold_text.dart';
import '../../../widgets/regular_text.dart';
import '../player/black_music_player.dart';
import '../player/purple_music_player.dart';
import '../player/teal_music_player.dart';
import '../widgets/bottom_sheet.dart';

class SongsTab extends StatefulWidget {
  const SongsTab({
    Key? key,
  }) : super(key: key);

  @override
  State<SongsTab> createState() => _SongsTabState();
}

class _SongsTabState extends State<SongsTab> {
  final OnAudioQuery _onAudioQuery = OnAudioQuery();
  final AudioPlayer _player = AudioPlayer();
  late ArtistProvider artistProvider;
  late AlbumProvider albumProvider;

  // * more variables

  List<SongModel> songs = [];
  String currentSong = '';
  int currentIndex = 0;
  bool isPlayerVisible = false;

  void _changePlayerVisbility() {
    setState(() {
      isPlayerVisible = !isPlayerVisible;
    });
  }

  @override
  void initState() {
    artistProvider = Provider.of<ArtistProvider>(context, listen: false);
    albumProvider = Provider.of<AlbumProvider>(context, listen: false);
    super.initState();

    requestStoragePermission();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _onAudioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _onAudioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  printSongs(songs) {
    for (SongModel song in songs) {
      print(song.album);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
        future: _onAudioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          print("${item.data?.length}");

          if (item.data == null) {
            return Center(child: CircularProgressIndicator());
          } else if (item.data!.length == 0) {
            return Center(
              child: Container(
                child: Text("No Song Found"),
              ),
            );
          } else {
            songs.clear();
            songs = item.data!;
            artistProvider.fetchArtists(songs);
            albumProvider.fetchAlbums(songs);

            return Consumer<MusicSearchProvider>(
                builder: (context, provider, child) {
              return ListView.builder(
                  itemCount: item.data!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) {
                    if (provider.getSearchActive) {
                      if (item.data![index].title
                          .toLowerCase()
                          .startsWith(provider.getSearchTerm.toLowerCase())) {
                        return GestureDetector(
                          onTap: () async {
                            _changePlayerVisbility();
                            setState(() {
                              currentIndex++;
                            });

                            // Get.to(OrangeMusicPlayer(
                            //   songs: songs,
                            //   currentindex: index,
                            //   updatedIndex: (updatedIndex) {
                            //     setState(() {
                            //       currentIndex == updatedIndex;
                            //     });
                            //   },
                            // ));

                            // Get.to(BlackMusicPlayer(
                            //   songs: songs,
                            //   currentindex: index,
                            //   updatedIndex: (updatedIndex) {
                            //     setState(() {
                            //       currentIndex == updatedIndex;
                            //     });
                            //   },
                            // ));
                          },
                          child: SongsRowWidget(
                            songName: item.data![index].title,
                            subtitle: item.data![index].displayName,
                            song: item.data![index],
                            img: QueryArtworkWidget(
                              id: item.data![index].id,
                              type: ArtworkType.AUDIO,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 0.1,
                        );
                      }
                    } else {
                      return GestureDetector(
                        onTap: () async {
                          _changePlayerVisbility();
                          setState(() {
                            currentIndex++;
                          });

                          // Get.to(OrangeMusicPlayer(
                          //   songs: songs,
                          //   currentindex: index,
                          //   updatedIndex: (updatedIndex) {
                          //     setState(() {
                          //       currentIndex == updatedIndex;
                          //     });
                          //   },
                          // ));

                          Get.to(TealMusicPlayer(
                            songs: songs,
                            currentindex: index,
                            updatedIndex: (updatedIndex) {
                              setState(() {
                                currentIndex == updatedIndex;
                              });
                            },
                          ));
                        },
                        child: SongsRowWidget(
                          song: item.data![index],
                          songName: item.data![index].title,
                          subtitle: item.data![index].displayName,
                          img: QueryArtworkWidget(
                            id: item.data![index].id,
                            type: ArtworkType.AUDIO,
                          ),
                        ),
                      );
                    }
                  }));
            });
          }
        });
  }

// * create playlist
  ConcatenatingAudioSource _createPlayList(List<SongModel>? data) {
    List<AudioSource> sources = [];

    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!)));
    }

    return ConcatenatingAudioSource(children: sources);
  }
}

class SongsRowWidget extends StatelessWidget {
  final String songName;
  final String subtitle;
  final SongModel song;
  final QueryArtworkWidget img;
  const SongsRowWidget({
    Key? key,
    required this.song,
    required this.songName,
    required this.subtitle,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            img.nullArtworkWidget != null
                ? img
                : Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/mp3_logo.png"),
                      ),
                    ),
                  ),
            SizedBox(
              width: Dimensions.width15,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoldText(
                    text: songName,
                    size: Dimensions.font16 - 2,
                  ),
                  RegularText(
                    text: subtitle,
                    size: Dimensions.font16 - 4,
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            height: 40,
            color: Colors.transparent,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              print("bottom Sheet");
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(Dimensions.height53 - 3))),
                  context: context,
                  builder: ((context) => AlbumBottomSheet(
                        song: song,
                      ))).whenComplete(() {
                print("hihfiahf");
              });
            },
            child: SizedBox(
              height: Dimensions.height25 - 5,
              width: Dimensions.height25 - 5,
              child: Image.asset(MusicIcons.doubeDots),
            ),
          ),
        )
      ]),
    );
  }
}
