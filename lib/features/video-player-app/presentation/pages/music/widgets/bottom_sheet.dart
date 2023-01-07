import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/model/playlist_model.dart';

import 'package:video_player_app/features/video-player-app/presentation/Utils/colors.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';
import 'package:video_player_app/features/video-player-app/provider/music_playlist_provider.dart';

import '../../../Utils/dimenstion.dart';
import '../tabs/playlist_tab.dart';

class AlbumBottomSheet extends StatefulWidget {
  SongModel song;
  AlbumBottomSheet({
    required this.song,
    Key? key,
  }) : super(key: key);

  @override
  State<AlbumBottomSheet> createState() => _AlbumBottomSheetState();
}

class _AlbumBottomSheetState extends State<AlbumBottomSheet> {
  var assetsAudioPlayer = AssetsAudioPlayer();

  @override
  Widget build(BuildContext context) {
    return buildSheet();
  }

  Future<void> shareFile(SongModel song) async {
    await FlutterShare.shareFile(
      title: '${song.title}',
      text: song.displayName,
      filePath: "/storage/emulated/0/Android/" + song.uri.toString(),
    );
  }

  List<String> iconsList = [
    AppIcons.playUnrounded,
    // AppIcons.playNext,
    AppIcons.playlist,
    // AppIcons.privacy,
    AppIcons.share,
    AppIcons.ringtone,
    AppIcons.delete,
    AppIcons.info,
  ];

  List<String> _namesList = [
    "Play",
    // "Next",
    "Add to playlist",
    // "Next",
    "Share",
    "Add to  queue",
    "Set as a Ringtone",
    "Delete",
    "Info"
  ];
  @override
  void dispose() async {
    assetsAudioPlayer.stop();
    assetsAudioPlayer.dispose().then((value) {
      print("disposed");
    });

    super.dispose();
  }

  Widget buildSheet({String? route}) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: BoldText(
              text: "Lagan Lagi",
              size: 16,
            ),
          ),
          SizedBox(
            height: Dimensions.height15,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: iconsList.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        print("pressed");
                        index == 1
                            ? showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(50))),
                                context: context,
                                builder: ((context) => AddToPlayListBottomSheet(
                                    song: widget.song)))
                            : null;

                        index == 2 ? shareFile(widget.song) : null;

                        index == 0
                            ? assetsAudioPlayer
                                .open(Audio.file(widget.song.uri.toString()))
                                .then((value) {
                                assetsAudioPlayer.onReadyToPlay.listen((event) {
                                  assetsAudioPlayer.play();
                                });
                              })
                            : null;
                      },
                      child: RowWidget(
                        title: _namesList[index],
                        icon: iconsList[index],
                      ),
                    );
                  })))
        ],
      );
}

class RowWidget extends StatelessWidget {
  final String title;
  final String icon;
  const RowWidget({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //
          Container(
            height: 20,
            width: 20,
            child: Image.asset(
              icon,
              color: AppColors.greyPurpleColor,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          RegularText(
            text: title,
            color: AppColors.greyPurpleColor,
            size: Dimensions.font16,
          ),
        ],
      ),
    );
  }
}

class AddToPlayListBottomSheet extends StatelessWidget {
  SongModel song;
  AddToPlayListBottomSheet({
    required this.song,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildSheet(context: context);
  }

  List<String> iconsList = [AppIcons.add, AppIcons.star];

  Widget buildSheet({String? route, required BuildContext context}) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: BoldText(
              text: "Lagan Lagi",

              //
              size: 16,
            ),
          ),
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
                padding: const EdgeInsets.all(30.0),
                child: Row(
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
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, top: 20),
                    child: PlayListItem(
                      song: song,
                      playName: provider.playListSongs[index].playName,
                      playlist: provider.playListSongs[index].playlist,
                      playlistImg: provider.playListSongs[index].playlistImg,
                      index: index,
                    ),
                  );
                }));
          }))
        ],
      );
}

class PlayListItem extends StatelessWidget {
  PlayListItem({
    Key? key,
    this.song,
    required this.playName,
    required this.playlist,
    this.playlistImg,
    required this.index,
  }) : super(key: key);

  SongModel? song;
  String playName;
  int index;
  List<SongModel> playlist;
  File? playlistImg;

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListprovider>(builder: (context, provider, child) {
      return GestureDetector(
        onTap: () {
          if (song == null) {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              context: context,
              builder: ((context) => PlayListItemsBottomSheet(
                    index: index,
                  )),
            );
          }

          if (song != null) {
            provider.addSongsInPlaylist(
                song: song!,
                playlistName: provider.playListSongs[index].playName);

            print(provider.playListSongs[index].playlist);
          }
        },
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: playlistImg == null
                        ? AssetImage(AppIcons.rectangleRed)
                        : FileImage(playlistImg!) as ImageProvider,
                  ),
                  color: null),
              child: Container(
                height: 20,
                width: 20,
                padding: EdgeInsets.all(0),
                child: Center(
                  child: playlistImg == null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            AppIcons.star,
                          ),
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.width20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BoldText(
                  text: playName,
                  size: 16,
                ),
                RegularText(
                  text:
                      provider.playListSongs[index].playlist.length.toString() +
                          " songs",
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class CreateNewPlayListBottomSheet extends StatefulWidget {
  CreateNewPlayListBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateNewPlayListBottomSheet> createState() =>
      _CreateNewPlayListBottomSheetState();
}

class _CreateNewPlayListBottomSheetState
    extends State<CreateNewPlayListBottomSheet> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildSheet(context: context);
  }

  List<String> iconsList = [AppIcons.add, AppIcons.star];

  File? playlistImage = null;

  Widget buildSheet({String? route, required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: Dimensions.width15,
          ),
          child: BoldText(
            text: "Create New Playlist",

            //
            size: Dimensions.font16,
          ),
        ),
        SizedBox(
          height: Dimensions.height53,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.height30, right: Dimensions.height30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  playlistImage = File(result!.paths[0]!);
                  setState(() {});

                  print(
                    result.paths.toString(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(2),
                  height: Dimensions.height102 + 17,
                  width: Dimensions.height102 + 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.withOpacity(.5),
                    image: playlistImage != null
                        ? DecorationImage(image: FileImage(playlistImage!))
                        : null,
                  ),
                  child: playlistImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Dimensions.height53 - 3,
                              width: Dimensions.height53 - 3,
                              child: Image.asset(AppIcons.upload),
                            ),
                            BoldText(
                              text: "Upload cover",
                              size: Dimensions.font16 - 4,
                            )
                          ],
                        )
                      : null,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: Dimensions.height45 - 3,
                    width: Dimensions.height217 - 15,
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Enter playlist name",
                        contentPadding: EdgeInsets.only(
                            left: Dimensions.width10,
                            right: Dimensions.width10,
                            bottom: 5,
                            top: 5),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.blueColor),
                          borderRadius:
                              BorderRadius.circular(Dimensions.height53),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool exists = false;
                      for (PlayListModelClass element
                          in context.read<PlayListprovider>().playListSongs) {
                        if (element.playName == _controller.text) {
                          exists = true;
                          Get.snackbar(
                              "Playlist", "Already exists with this name");

                          break;
                        } else {
                          exists = false;
                        }
                      }
                      if (_controller.text.length > 5) {
                        await context.read<PlayListprovider>().openPlaylist(
                            playlistName: _controller.text,
                            playImage: playlistImage);
                        if (!exists) {
                          Get.back(closeOverlays: true);
                        }
                      } else {
                        Get.snackbar("playlist", "Too short playlist name");
                      }
                    },
                    child: Container(
                      height: Dimensions.height45 - 5,
                      width: Dimensions.height102 + 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(colors: [
                            AppColors.startGradient,
                            AppColors.endGradient
                          ])),
                      child: Center(
                        child: BoldText(
                          text: "Add",
                          color: Colors.white,
                          size: Dimensions.font16 - 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height102,
        ),
      ],
    );
  }
}
