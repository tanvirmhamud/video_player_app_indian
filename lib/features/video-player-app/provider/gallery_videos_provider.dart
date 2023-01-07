import 'package:fetch_all_videos/fetch_all_videos.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class GalleryVideosProvider extends ChangeNotifier {
  List videosPathList = [];
  List thumbnailsPaths = [];

  Future<int> fetchVideos() async {
    if (videosPathList.isEmpty) {
    await  Future.delayed(Duration(seconds: 1));
      FetchAllVideos ob = FetchAllVideos();
      List videos = await ob.getAllVideos();
      videosPathList = videos;
      notifyListeners();
      return 1;
    } else {
      return 1;
    }
  }

  Future<int> generateThumbnail() async {
    if (thumbnailsPaths.isEmpty) {
      for (String file in videosPathList) {
        XFile temFile = XFile("/" + file);
        print(temFile);
        final fileName = await VideoThumbnail.thumbnailData(
          video: temFile.path,
          // thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.JPEG,
          maxHeight:
              64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
          quality: 75,
        );
        thumbnailsPaths.add(fileName);

        // setState(() {});
      }
      notifyListeners();
      return 1;
    } else {
      notifyListeners();
      return 2;
    }
  }
}
