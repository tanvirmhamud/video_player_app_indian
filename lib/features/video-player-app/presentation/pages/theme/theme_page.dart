import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../widgets/big_custom_appbar.dart';
import '../music/player/black_music_player.dart';
import '../music/player/orange_music_player.dart';
import '../music/player/purple_music_player.dart';
import '../music/player/teal_music_player.dart';
import 'Music_Theme/theme.dart';

class All_themes extends StatefulWidget {
  const All_themes({Key? key}) : super(key: key);

  @override
  State<All_themes> createState() => _All_themesState();
}

class _All_themesState extends State<All_themes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigCustomAppBar(
        title: "Themes",
        firstIcon: Icons.abc,
        secondIcon: Icons.abc,
        color: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            Container(
              height: 132,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/playertheme.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MusicThemePage(),
                            ));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => TealMusicPlayer(),
                        //     ));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => OrangeMusicPlayer(
                        //               currentindex: 0,
                        //               songs: [
                        //                 SongModel({
                        //                   "_uri": null,
                        //                   "content":
                        //                       "//media/external/audio/media/12",
                        //                   "artist": "Kevin MacLeod",
                        //                   "year": null,
                        //                   "is_music": true,
                        //                   "title": " Impact Moderato",
                        //                   "_size": 764176,
                        //                   "duration": 27252,
                        //                   "is_alarm": false,
                        //                   "_display_name_wo_ext":
                        //                       "file_example_MP3_700KB",
                        //                   "album_artist": null,
                        //                   "is_notification": false,
                        //                   "track": 0,
                        //                   "_data":
                        //                       "/storage/emulated/0/Download/file_example_MP3_700KB.mp3",
                        //                   "_display_name":
                        //                       "file_example_MP3_700KB.mp3",
                        //                   "album": "YouTube Audio Library",
                        //                   "composer": null,
                        //                   "is_ringtone": false,
                        //                   "artist_id": 1,
                        //                   "is_podcast": false,
                        //                   "bookmark": 0,
                        //                   "date_added": 1673069811,
                        //                   "is_audiobook": false,
                        //                   "date_modified": 1673069816,
                        //                   "album_id": 1,
                        //                   "file_extension": "mp3",
                        //                   "_id": 12
                        //                 })
                        //               ],
                        //               updatedIndex: (int) {},
                        //             )));
                      },
                      child: Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Player Theme',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '5+ Music player Theme',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
