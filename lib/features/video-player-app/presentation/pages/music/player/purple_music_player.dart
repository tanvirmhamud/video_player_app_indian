// ignore_for_file: avoid_print, unused_field

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'package:video_player_app/features/video-player-app/presentation/Utils/dimenstion.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/images.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/big_bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';
import 'package:video_player_app/features/video-player-app/provider/recent_songs_provider.dart';

class PurpleMusicPlayer extends StatefulWidget {
  final List<SongModel> songs;

  final int currentindex;
  final Function(int) updatedIndex;
  const PurpleMusicPlayer(
      {super.key,
      required this.songs,
      required this.currentindex,
      required this.updatedIndex});

  @override
  State<PurpleMusicPlayer> createState() => _PurpleMusicPlayerState();
}

class _PurpleMusicPlayerState extends State<PurpleMusicPlayer> {
  late AnimationController animateController;

  final OnAudioQuery _onAudioQuery = OnAudioQuery();
  final AudioPlayer _player = AudioPlayer();
  ValueNotifier<bool> isPlayer = ValueNotifier<bool>(true);
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late int audioIndex;
  double test = 0.0;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();

    // requestStoragePermission();
    setState(() {
      audioIndex = widget.currentindex;
    });
  }

  void _playMusic({int? index, String? ur, required SongModel song}) async {
    if (ur != null) {
      try {
        if (isPlayer.value) {
          //your code goes here

          Future.delayed(const Duration(milliseconds: 100), () {
            context.read<RecentPlayedProvider>().addRecentSongs(song: song);
          });

          String? uri = ur;
          assetsAudioPlayer.open(Audio.file(uri), showNotification: true);
          assetsAudioPlayer.onReadyToPlay.listen((event) {
            assetsAudioPlayer.loopMode;
            assetsAudioPlayer.playlistAudioFinished.listen((value) {
              setState(() {
                print("paused");
                isPlayer.value = false;
              });
            });
            print("duration : ${event?.duration}");
            var onZero = const Duration(seconds: 0);

            duration = event?.duration ?? onZero;

            position = assetsAudioPlayer.currentPosition.value;
          });
        } else {
          // _player.pause();
          assetsAudioPlayer.pause();
        }
      } on PlayerException catch (e) {
        print("Error code: ${e.code}");

        if (kDebugMode) {
          print("Error message: ${e.message}");
        }
      } on PlayerInterruptedException catch (e) {
        print("Connection aborted: ${e.message}");
      } catch (e) {
        print(e);
      }
    }
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _onAudioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _onAudioQuery.permissionsRequest();
      }
      // ensure build method
      setState(() {});
    }
  }

  Future<void> shareFile(SongModel song) async {
    await FlutterShare.shareFile(
      title: '${song.title}',
      text: song.displayName,
      filePath: "/storage/emulated/0/Android/" + song.uri.toString(),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    // _onAudioQuery.dispose();
    assetsAudioPlayer.dispose();
    // _playMusic.dispose();

    super.dispose();
  }

  final bool _changed = true;
  List<SongModel> songs = [];
  String currentSong = '';
  int currentIndex = 0;
  bool isPlayerVisible = false;
  final bool _isFav = false;

  @override
  Widget build(BuildContext context) {
    // print("Tanvir ${widget.songs.length}");
    return FutureBuilder<List<SongModel>>(
        future: _onAudioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, items) {
          if (items.data == null || items.data!.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            String? uri = items.data![audioIndex].uri;
            print("rebuild");

            _playMusic(
                ur: uri, index: audioIndex, song: items.data![audioIndex]);
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 25,
                  width: 25,
                  child: Image.asset(
                    AppIcons.share,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Container(
              height: Dimensions.screenHeight,
              width: Dimensions.screenWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [
                      0.2,
                      0.2,
                      0.5,
                      0.8,
                      0.6,
                    ],
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.purple.withOpacity(1),
                      Colors.black,
                      Colors.black,
                    ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.height102,
                  ),
                  Spin(
                    infinite: true,
                    spins: 1,
                    manualTrigger: _changed,
                    controller: (controller) =>
                        animateController = controller..repeat(),
                    duration: const Duration(seconds: 8),
                    child: Container(
                      height: Dimensions.height277 + Dimensions.height25 + 3,
                      width: Dimensions.height277 + Dimensions.height25 - 2,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(50),
                        shape: BoxShape.circle,
                        image: QueryArtworkWidget(
                                  id: items.data![audioIndex].id,
                                  type: ArtworkType.AUDIO,
                                ).nullArtworkWidget ==
                                null
                            ? DecorationImage(
                                image: AssetImage(AppImages.artists),
                                fit: BoxFit.cover)
                            : null,
                      ),
                      child: QueryArtworkWidget(
                                id: items.data![audioIndex].id,
                                type: ArtworkType.AUDIO,
                              ).nullArtworkWidget ==
                              null
                          ? null
                          : QueryArtworkWidget(
                              id: items.data![audioIndex].id,
                              type: ArtworkType.AUDIO,
                              artworkHeight: Dimensions.height277 +
                                  Dimensions.height25 -
                                  2,
                              artworkWidth: Dimensions.height277 +
                                  Dimensions.height25 -
                                  2,
                              artworkBorder: BorderRadius.circular(
                                  Dimensions.height102 - 2),
                              artworkColor: Colors.white,
                            ),
                    ),
                  ),
                  BigBoldText(
                    text: items.data![audioIndex].title,
                    color: Colors.white,
                    size: Dimensions.font25 - 1,
                  ),
                  RegularText(
                    text: items.data![audioIndex].displayName,
                    color: Colors.grey,
                    size: 12,
                  ),
                  SizedBox(
                    height: Dimensions.height25,
                  ),

                  // * Progress Bar
                  // SizedBox(
                  //   width: 300,
                  //   child: ProgressBar(
                  //     thumbColor: Colors.white,
                  //     bufferedBarColor: Colors.grey.withOpacity(.4),
                  //     progressBarColor: Colors.white,
                  //     baseBarColor: Colors.white,
                  //     progress: Duration(milliseconds: 2000),
                  //     buffered: Duration(milliseconds: 3000),
                  //     total: Duration(milliseconds: 5000),
                  //     thumbGlowColor: Colors.white,
                  //     timeLabelTextStyle: TextStyle(color: Colors.white),
                  //     onSeek: (duration) {
                  //       print('User selected a new time: $duration');
                  //     },
                  //   ),
                  // ),

                  StreamBuilder<Duration>(
                      stream: assetsAudioPlayer.currentPosition,
                      builder: (context, snapshot) {
                        final pos = snapshot.data;

                        position =
                            Duration(seconds: pos == null ? 0 : pos.inSeconds);

                        print("pos : $pos");
                        return SizedBox(
                          width: 230,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 230,
                                child: Slider.adaptive(
                                    value: position.inSeconds.toDouble(),
                                    min: 0,
                                    max: duration.inSeconds.toDouble(),
                                    activeColor: const Color(0xFF9B0404),
                                    thumbColor: Colors.white,
                                    inactiveColor: Colors.grey.withOpacity(.2),
                                    onChanged: (seek) {
                                      position = seek.seconds;

                                      assetsAudioPlayer.seek(
                                        Duration(
                                          seconds: seek.toInt(),
                                        ),
                                      );

                                      print("seek ${seek}");
                                    }),
                              ),
                              Row(
                                children: [
                                  Text(
                                    pos.toString().split('.')[0],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const Spacer(),
                                  Text(
                                    duration.toString().split('.')[0],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                  // * Controller Row

                  Padding(
                    padding:
                        const EdgeInsets.only(left: 70, right: 70, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: Image.asset(
                            AppIcons.shuffle,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (_player.hasNext) {
                              _player.seekToNext();
                            }
                            // await audioPlayer
                            //     .setSource(AssetSource(audioList[audioIndex]));
                            // await audioPlayer.resume();

                            // setState(() {
                            isPlayer.value = true;
                            // });
                            if (audioIndex == 0) {
                              _player.stop();
                              setState(() {
                                audioIndex = items.data!.length - 1;
                              });
                            } else {
                              setState(() {
                                audioIndex--;
                              });
                            }
                          },
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset(
                              AppIcons.skipPrevious,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ValueListenableBuilder(
                            valueListenable: isPlayer,
                            builder: (context, value, child) {
                              return InkWell(
                                onTap: () async {
                                  if (isPlayer.value) {
                                    print("pause");
                                    // setState(() {
                                    isPlayer.value = false;
                                    // });
                                    // _player.pause();
                                    assetsAudioPlayer.pause();
                                  } else {
                                    // setState(() {
                                    print("play");
                                    isPlayer.value = true;
                                    // });
                                    // await _player.play();
                                    assetsAudioPlayer.play();
                                    // assetsAudioPlayer.play();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  height: Dimensions.height70 + 10,
                                  width: Dimensions.height70 + 10,
                                  child: Center(
                                      child: Icon(
                                    isPlayer.value
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    // size: Dimensions.height53 - 3,
                                    color: Colors.black,
                                  )),
                                ),
                              );
                            }),
                        InkWell(
                          onTap: () async {
                            // await audioPlayer.stop();
                            animateController.animationBehavior;

                            // setState(() {
                            isPlayer.value = true;
                            // });
                            setState(() {
                              if (audioIndex + 1 == items.data!.length) {
                                audioIndex = 0;
                                // audioPlayer
                                //     .setSource(AssetSource(audioList[audioIndex]));
                                // audioPlayer.resume();
                              } else {
                                setState(() {
                                  audioIndex++;
                                  // audioPlayer
                                  //     .setSource(AssetSource(audioList[audioIndex]));
                                  // audioPlayer.resume();
                                });
                              }
                            });
                          },
                          child: SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset(
                              AppIcons.playNext,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: Image.asset(
                            AppIcons.repeat,
                            // color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // * comming up next

                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BoldText(
                        text: "Coming Up next",
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  items.data!.length == audioIndex + 1
                      ? Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "No Song Available",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 20),
                          width: 364,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(colors: [
                                Colors.grey.withOpacity(.4),
                                Colors.grey.withOpacity(.2),
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(AppImages.singer2),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          BoldText(
                                            text: items
                                                .data![audioIndex + 1].title,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: Dimensions.height10,
                                          ),
                                          RegularText(
                                            text: items.data![audioIndex + 1]
                                                .displayName,
                                            size: 12,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // const Icon(
                                  //   Icons.menu,
                                  //   color: Colors.white,
                                  // ),
                                ]),
                          ),
                        )
                ],
              ),
            ),
          );
        });
  }
}
