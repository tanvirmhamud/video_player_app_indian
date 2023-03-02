import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:pod_player/pod_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/download.dart';

class PlayVideoFromNetwork extends StatefulWidget {
  final String? m3U8;
  const PlayVideoFromNetwork({Key? key, this.m3U8}) : super(key: key);

  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  // reward

  // interstitial ads

  late final PodPlayerController controller;

  int select = 0;

  // // Timer? _timer;
  // // int _start = 0;

  // // bool showpopup = false;

  // // void startTimer() {
  // //   const oneSec = Duration(seconds: 1);
  // //   _timer = Timer.periodic(
  // //     oneSec,
  // //     (Timer timer) {
  // //       if (_start == 5) {
  // //         setState(() {
  // //           timer.cancel();
  // //           showpopup = true;
  // //           controller.pause();
  // //         });
  // //       } else {
  // //         setState(() {
  // //           _start++;
  // //         });
  // //       }
  // //     },
  // //   );
  // // }

  @override
  void initState() {
    controller = PodPlayerController(
      podPlayerConfig: PodPlayerConfig(autoPlay: true, forcedVideoFocus: false),
      playVideoFrom: PlayVideoFrom.file(
        widget.m3U8!
      ),
    )..initialise();

    // ..addListener(() {
    //   if (_start == 5) {
    //     if (adsview == false && select == 0) {
    //       controller.pause();
    //     }
    //   }
    // });
    // startTimer();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Dwnloadprovider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                provider.downloadvideo(url: widget.m3U8, context: context);
              },
              icon: Icon(
                Icons.download,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          PodVideoPlayer(
            controller: controller,
            onLoading: (context) {
              if (controller.isVideoBuffering == true) {
                return Center(child: Container());
              } else if (controller.videoState == PodVideoState.paused) {
                return Icon(Icons.pause);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          // Container(
          //   height: 200.h,
          //   child: Stack(
          //     children: [
          //       PodVideoPlayer(controller: controller),
          //       // if (showpopup)
          //       //   BackdropFilter(
          //       //     filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          //       //     child: Container(
          //       //       height: 200.h,
          //       //       width: double.infinity,
          //       //       decoration:
          //       //           BoxDecoration(color: Colors.black.withOpacity(0.2)),
          //       //       child: Column(
          //       //         mainAxisAlignment: MainAxisAlignment.center,
          //       //         children: [
          //       //           Padding(
          //       //             padding: const EdgeInsets.all(8.0),
          //       //             child: Text(
          //       //               "Continue to Watch live match",
          //       //               style: TextStyle(fontSize: 16.sp),
          //       //             ),
          //       //           ),
          //       //           Row(
          //       //             mainAxisAlignment: MainAxisAlignment.center,
          //       //             children: [
          //       //               MaterialButton(
          //       //                 color: Colors.red,
          //       //                 onPressed: (() {
          //       //                   setState(() {
          //       //                     showpopup = false;
          //       //                   });
          //       //                 }),
          //       //                 child: Text("Cancle"),
          //       //               ),
          //       //               SizedBox(width: 10.w),
          //       //               MaterialButton(
          //       //                 color: Colors.green,
          //       //                 onPressed: (() {
          //       //                   loadinterstitialads();
          //       //                 }),
          //       //                 child: Text("Watch Ad"),
          //       //               )
          //       //             ],
          //       //           )
          //       //         ],
          //       //       ),
          //       //     ),
          //       //   ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
