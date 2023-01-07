import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/colors.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/music/album_screen.dart';
import 'package:video_player_app/features/video-player-app/provider/music_album_provider.dart';

import '../../../../provider/music_playlist_provider.dart';
import '../../../Utils/dimenstion.dart';
import '../../../Utils/images.dart';
import '../../../widgets/big_bold_text.dart';
import '../../../widgets/bold_text.dart';
import '../../../widgets/regular_text.dart';
import '../widgets/artist_widget.dart';
import 'artist_tab.dart';

class AlbumTab extends StatefulWidget {
  AlbumTab({
    Key? key,
  }) : super(key: key);

  @override
  State<AlbumTab> createState() => _AlbumTabState();
}

class _AlbumTabState extends State<AlbumTab> {
  final List<Color> color = [Colors.black, AppColors.redColor, Colors.pink];

  final List<String> icons = [AppIcons.browser, AppIcons.clock, AppIcons.star];

  final List<String> titles = [
    "Craete playlist",
    "Recent Track",
    "My top List"
  ];

  @override
  Widget build(BuildContext context) {
    bool noAlbumn = true;
    return Consumer<AlbumProvider>(builder: (context, provider, child) {
      return Container(
          child: SingleChildScrollView(
        child: Wrap(
            children: List.generate(provider.albumsList.length, (index) {
          return GestureDetector(
            onTap: () {
              Get.to(AlbumDetailScreen(
                album: provider.albumsList[index],
              ));
            },
            child: ArtistsSquareWigdet(
              bgImg: AppImages.artists,
              name: provider.albumsList[index].name,
              countSongs: provider.albumsList[index].songsList.length,
            ),
          );
        })),
      ));
    });
  }
}
