import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_player_app/features/video-player-app/presentation/Utils/dimenstion.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/videos/online_videos/video_player_youtube.dart';
import 'package:youtube_api/youtube_api.dart';

class MediumVideoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgUrl;
  final String videoUrl;
  final YouTubeVideo video;
  final String type;

  const MediumVideoTile({
    Key? key,
    required this.type,
    required this.video,
    required this.videoUrl,
    required this.title,
    required this.subtitle,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(NetworkVideoPlayer(
          video: video,
          type: type,
        ));
      },
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 187,
                height: Dimensions.screenHeight * 0.24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Dimensions.screenHeight * 0.15,
                      width: 187,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.height5),
                          color: Colors.red,
                          image: DecorationImage(
                              image: NetworkImage(
                                imgUrl,
                              ),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    BoldText(
                      text: title,
                      size: 16,
                    ),
                    RegularText(
                      maxLines: 2,
                      text: subtitle,
                      size: Dimensions.font16 - 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
