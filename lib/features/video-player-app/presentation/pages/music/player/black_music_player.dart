import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/colors.dart';

import 'package:video_player_app/features/video-player-app/presentation/Utils/dimenstion.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/images.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/music/widgets/bottom_sheet.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/big_bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';
import 'package:video_player_app/features/video-player-app/provider/recent_songs_provider.dart';

class BlackMusicPlayer extends StatefulWidget {
  final List<SongModel> songs;

  final int currentindex;
  final Function(int) updatedIndex;
  const BlackMusicPlayer(
      {super.key,
      required this.songs,
      required this.currentindex,
      required this.updatedIndex});

  @override
  State<BlackMusicPlayer> createState() => _BlackMusicPlayerState();
}

class _BlackMusicPlayerState extends State<BlackMusicPlayer> {
  late AnimationController animateController;

  final OnAudioQuery _onAudioQuery = OnAudioQuery();
  AudioPlayer _player = AudioPlayer();
  ValueNotifier<bool> isPlayer = ValueNotifier<bool>(true);
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late int audioIndex;
  double test = 0.0;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    // TODO: implement initState

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

          Future.delayed(Duration(milliseconds: 100), () {
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
            var onZero = Duration(seconds: 0);

            duration = event?.duration ?? onZero;

            position = assetsAudioPlayer.currentPosition.value;
          });
        } else {
          // _player.pause();
          assetsAudioPlayer.pause();
        }
      } on PlayerException catch (e) {
        print("Error code: ${e.code}");

        print("Error message: ${e.message}");
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

  bool _changed = true;
  List<SongModel> songs = [];
  String currentSong = '';
  int currentIndex = 0;
  bool isPlayerVisible = false;
  bool _isFav = false;

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
          if (items.data == null || items.data!.length == 0) {
            return Center(child: CircularProgressIndicator());
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
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: Dimensions.width20),
                  height: Dimensions.height25,
                  width: Dimensions.height25,
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
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //     stops: [
                //       0.2,
                //       0.2,
                //       0.5,
                //       0.8,
                //       0.6,
                //     ],
                //     colors: [
                //       Colors.black,
                //       Colors.black,
                //       Colors.purple.withOpacity(1),
                //       Colors.black,
                //       Colors.black,
                //     ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimensions.height102,
                  ),
                  // Container(
                  //   height: Dimensions.height383 - Dimensions.height30,
                  //   width: Dimensions.height383 - Dimensions.height30,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(50),
                  //     image: DecorationImage(
                  //       image: AssetImage(AppImages.singer2),
                  //     ),
                  //   ),
                  // ),
                  Spin(
                    infinite: true,
                    spins: 1,
                    manualTrigger: _changed,
                    controller: (controller) =>
                        animateController = controller..repeat(),
                    duration: Duration(seconds: 8),
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
                  SizedBox(
                    height: Dimensions.height25,
                  ),
                  RegularText(
                    text: items.data![audioIndex].title,
                    color: Colors.white,
                    size: 12,
                  ),
                  BigBoldText(
                    text: items.data![audioIndex].displayName,
                    color: Colors.white,
                    size: Dimensions.font25 - 1,
                  ),
                  SizedBox(
                    height: Dimensions.height25,
                  ),
                  // * Controller Row

                  Padding(
                    padding: EdgeInsets.only(left: 70, right: 70, top: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: Image.asset(
                            AppIcons.repeat,
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
                            height: Dimensions.height53 - 20,
                            width: Dimensions.height53 - 20,
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
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF9B0404),
                                  ),
                                  height: Dimensions.height70 + 10,
                                  width: Dimensions.height70 + 10,
                                  child: Center(
                                      child: Icon(
                                    isPlayer.value
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    // size: Dimensions.height53 - 3,
                                    color: Colors.white,
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
                            height: Dimensions.height53 - 20,
                            width: Dimensions.height53 - 20,
                            child: Image.asset(
                              AppIcons.skipNext,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height25,
                          width: Dimensions.height25,
                          child: Image.asset(
                            AppIcons.shuffle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height25,
                  ),
                  SizedBox(
                    height: Dimensions.height25,
                  ),
// * Progress Bar
                  // SizedBox(
                  //   width: Dimensions.height383 -
                  //       Dimensions.height70 -
                  //       Dimensions.height10 +
                  //       3,
                  //   child: ProgressBar(
                  //     thumbColor: Colors.white,
                  //     bufferedBarColor: Colors.grey.withOpacity(.4),
                  //     progressBarColor: Color(0xFF9B0404),
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
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                pos.toString().split('.')[0],
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 230,
                                child: Slider.adaptive(
                                    value: position.inSeconds.toDouble(),
                                    min: 0,
                                    max: duration.inSeconds.toDouble(),
                                    activeColor: Color(0xFF9B0404),
                                    thumbColor: Color(0xFF9B0404),
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
                              Text(
                                duration.toString().split('.')[0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }),

                  // * comming up next
                ],
              ),
            ),
          );
        });
  }
}
