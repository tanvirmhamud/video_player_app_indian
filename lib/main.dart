import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/navbar_home.dart';
import 'package:video_player_app/features/video-player-app/provider/gallery_videos_provider.dart';
import 'package:video_player_app/features/video-player-app/provider/getWhatsAppStatusProvider.dart';
import 'package:video_player_app/features/video-player-app/provider/music_artist_povider.dart';
import 'package:video_player_app/features/video-player-app/provider/music_search_provider.dart';
import 'package:video_player_app/features/video-player-app/provider/music_playlist_provider.dart';
import 'package:video_player_app/features/video-player-app/provider/recent_songs_provider.dart';
import 'features/video-player-app/provider/download.dart';
import 'features/video-player-app/provider/music_album_provider.dart';
import 'features/video-player-app/provider/tabbrowser.dart';
import 'features/video-player-app/provider/youtube_videos_provider.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.openBox("theme");
  Hive.init(dir.path);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => PlayListprovider(),
    ),
    ChangeNotifierProvider(
      create: (context) => RecentPlayedProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => MusicSearchProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ArtistProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AlbumProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => YoutubeVideoProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => GalleryVideosProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => WhatsAppStatusProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => Providertabbrowse(),
    ),
    ChangeNotifierProvider(create: (context) => Dwnloadprovider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.-
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Player Video',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home:DeviceVideoScreen(),
      home: HomePageNavBar(),
    );
  }
}
