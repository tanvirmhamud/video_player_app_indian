// ignore_for_file: avoid_print, unused_field

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
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

class TealMusicPlayer extends StatefulWidget {
  final List<SongModel> songs;

  final int currentindex;
  final Function(int) updatedIndex;
  const TealMusicPlayer(
      {super.key,
      required this.songs,
      required this.currentindex,
      required this.updatedIndex});

  @override
  State<TealMusicPlayer> createState() => _TealMusicPlayerState();
}

class _TealMusicPlayerState extends State<TealMusicPlayer> {
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
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
              ),
              title: BoldText(
                text: "Now Player",
                size: 20,
                color: Colors.white,
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 20),
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
                color: Colors.black,
                // gradient: LinearGradient(
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                // stops: [
                //   0.4,
                //   0.5,
                //   0.7,
                // ],
                // colors: [
                //   Color.fromARGB(255, 255, 96, 64),
                //   Colors.black,
                //   Color.fromARGB(255, 15, 88, 124)
                // ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.height102 + 30,
                  ),
                  Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      // shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(AppImages.tealMusic),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height53,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigBoldText(
                          text: items.data![audioIndex].title,
                          color: Colors.white,
                          size: Dimensions.font25 - 1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: RegularText(
                        text: items.data![audioIndex].displayName,
                        color: Colors.grey,
                        size: 14,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: Dimensions.height25,
                  // ),

                  // * Progress Bar
                  // SizedBox(
                  //   width: 300,
                  //   child: ProgressBar(
                  //     thumbColor: Colors.white,
                  //     bufferedBarColor: Colors.grey.withOpacity(.2),
                  //     progressBarColor: Color(0xFF2B97BD),
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
                          width: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
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
                    padding: EdgeInsets.only(left: 70, right: 70, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        // Container(
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: [
                        //           Color(0xFF2B97BD),
                        //           Color.fromARGB(255, 130, 211, 240),
                        //         ]),
                        //   ),
                        //   height: 80,
                        //   width: 80,
                        //   child: Icon(
                        //     Icons.pause,
                        //     size: 50,
                        //     color: Colors.black,
                        //   ),
                        // ),
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
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF2B97BD),
                                          Color.fromARGB(255, 130, 211, 240),
                                        ]),
                                  ),
                                  height: Dimensions.height70 + 10,
                                  width: Dimensions.height70 + 10,
                                  child: Center(
                                      child: Icon(
                                    isPlayer.value
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    size: Dimensions.height53 - 3,
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
                              AppIcons.skipNext,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // * ROw

                  SizedBox(
                    height: Dimensions.height25,
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 150, right: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.repeat,
                              color: Colors.grey,
                              size: 30,
                            ),
                            SizedBox(
                              width: Dimensions.height10,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Dimensions.height10,
                            ),
                            Icon(
                              Icons.shuffle,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
