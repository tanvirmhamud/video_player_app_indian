import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_native_api/flutter_native_api.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/images.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/videos/online_videos/better_player.dart';
import 'package:video_player_app/features/video-player-app/provider/getWhatsAppStatusProvider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../Utils/colors.dart';
import '../../../Utils/dimenstion.dart';
import '../../../widgets/regular_text.dart';
import '../Tools/notification/Notification_page.dart';

class WhatsAppStatus extends StatefulWidget {
  const WhatsAppStatus({super.key});

  @override
  State<WhatsAppStatus> createState() => _WhatsAppStatusState();
}

class _WhatsAppStatusState extends State<WhatsAppStatus> {
  String statusPath = "";
  bool video = true;

  @override
  void initState() {
    Provider.of<WhatsAppStatusProvider>(context, listen: false).getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<WhatsAppStatusProvider>(builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.getStatus(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    onClick: () {},
                    icon: Icons.search,
                    secondIcon: Icons.more_vert,
                    title: "WhatsApp Status",
                    iconColor: Colors.black,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.width10 - 2),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            video = true;
                            setState(() {});
                          },
                          child: Container(
                            height: Dimensions.height30 + 4,
                            width: Dimensions.height96,
                            decoration: BoxDecoration(
                              color: video == true
                                  ? AppColors.darkBlueColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.lightPurple),
                            ),
                            child: Center(
                                child: RegularText(
                              text: "Videos",
                              color:
                                  video != true ? Colors.black : Colors.white,
                              size: Dimensions.font16 - 2,
                            )),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              video = false;
                            });
                          },
                          child: Container(
                            height: Dimensions.height30 + 4,
                            width: Dimensions.height96,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: AppColors.lightPurple),
                                color: video != true
                                    ? AppColors.darkBlueColor
                                    : Colors.white),
                            child: Center(
                                child: RegularText(
                              text: "Photos",
                              size: Dimensions.font16 - 2,
                              color:
                                  video == true ? Colors.black : Colors.white,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: Dimensions.height15,
                  ),
                  if (video)
                    Flexible(
                      child: GridView.count(
                          childAspectRatio: 0.85,
                          padding: EdgeInsets.zero,
                          crossAxisCount: 2,
                          crossAxisSpacing: Dimensions.width10,
                          mainAxisSpacing: Dimensions.height45 - 5,
                          children:
                              List.generate(provider.getVideos.length, (index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width15,
                                  right: Dimensions.width15),
                              child: WhatsAppVideoWidget(
                                filePath: provider.getVideos[index].path,
                              ),
                            );
                          })),
                    ),
                  if (!video)
                    Flexible(
                      child: GridView.count(
                        childAspectRatio: 0.85,
                        padding: EdgeInsets.zero,
                        crossAxisCount: 2,
                        crossAxisSpacing: Dimensions.width10,
                        mainAxisSpacing: Dimensions.height45 - 5,
                        children: List.generate(
                          provider.getImages.length,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width15,
                                  right: Dimensions.width15),
                              child: WhatsAppImageWidget(
                                filePath: provider.getImages[index].path,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      }),
    );
  }
}

class WhatsAppVideoWidget extends StatelessWidget {
  String filePath;
  WhatsAppVideoWidget({
    required this.filePath,
    Key? key,
  }) : super(key: key);

  Future generateThumbnail(String vidPath) async {
    try {
      final fileName = await VideoThumbnail.thumbnailData(
        video: vidPath,
        imageFormat: ImageFormat.JPEG,
      );

      return fileName;
    } catch (e) {
      print(e);
    }

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(BetterPlayerView(path: filePath));
      },
      child: Stack(
        children: [
          Container(
            // height: Dimensions.height217,
            // width: 169,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0.4,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                      color: Colors.grey.withOpacity(.5))
                ]),
            child: Column(
              children: [
                FutureBuilder(
                  future: generateThumbnail(filePath),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: Dimensions.screenHeight * 0.21,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: MemoryImage(snapshot.data),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        height: Dimensions.height172,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Padding(
                  padding: EdgeInsets.all(Dimensions.width10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // RegularText(
                      //   text: "434344243",
                      //   size: Dimensions.font16 - 4,
                      // ),
                      GestureDetector(
                        onTap: () {
                          FlutterNativeApi.shareVideo(filePath);
                        },
                        child: SizedBox(
                          height: Dimensions.width20,
                          width: Dimensions.width50,
                          child: Image.asset(AppIcons.shareInsta),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ImageGallerySaver.saveFile(filePath).then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Video Saved in Gallery..."),
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: Dimensions.width20,
                          width: Dimensions.width50,
                          child: FittedBox(
                              child: Image.asset(HomeIcons.statusDownload)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height65 - 5,
            left: 0,
            right: 0,
            child: Center(
                child: SizedBox(
                    height: Dimensions.height53 - 3,
                    width: Dimensions.height53 - 3,
                    child: Image.asset(HomeIcons.statusPlay))),
          ),
        ],
      ),
    );
  }
}

class WhatsAppImageWidget extends StatelessWidget {
  String filePath;
  WhatsAppImageWidget({
    required this.filePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(
                    File(filePath),
                  ),
                  fit: BoxFit.contain),
            ),
          ),
        );
      },
      child: Stack(
        key: ValueKey("1"),
        children: [
          Container(
            // height: Dimensions.height217,
            // width: 169,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0.4,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                      color: Colors.grey.withOpacity(.5))
                ]),
            child: Column(
              children: [
                Container(
                  height: Dimensions.screenHeight * 0.21,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: FileImage(File(filePath)), fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Padding(
                  padding: EdgeInsets.all(Dimensions.width10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // RegularText(
                      //   text: "434344243",
                      //   size: Dimensions.font16 - 4,
                      // ),
                      GestureDetector(
                        onTap: () {
                          FlutterNativeApi.shareImage(filePath);
                        },
                        child: SizedBox(
                          height: Dimensions.width20,
                          width: Dimensions.width50,
                          child: Image.asset(AppIcons.shareInsta),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ImageGallerySaver.saveFile(filePath).then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Image Saved in Gallery..."),
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: Dimensions.width20,
                          width: Dimensions.width50,
                          child: Image.asset(HomeIcons.statusDownload),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
