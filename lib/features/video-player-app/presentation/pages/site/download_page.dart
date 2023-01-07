import 'dart:io';

import 'package:flutter/material.dart';

import 'package:video_player_app/features/video-player-app/presentation/Utils/colors.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/dimenstion.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/home/latest_news.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/site/widgets/browser_history_widget.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/site/youtube_downloader_material/youtube_browser_page.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/big_custom_appbar.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/square_widget.dart';

import '../../widgets/circular_widget.dart';
import 'browser_page.dart';
import 'download_page.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => DownloadsPageState();
}

class DownloadsPageState extends State<DownloadsPage> {
  final TextEditingController _searchController = TextEditingController();
  var files,photoss,videos;
  late String checkClickValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigCustomAppBar(
        title: "Downloads",
        firstIcon: Icons.search,
        secondIcon: Icons.more_vert,
        color: Colors.black,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 10,),
              child: Container(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap:(){
                        setState(() {
                          checkClickValue = "Video";
                        });
                      },
                      child: checkSelectedItemVideo(context,checkClickValue),
                    ),


                    GestureDetector(
                      onTap:(){
                        setState(() {
                          checkClickValue = "Photos";
                        });
                      },
                      child: checkSelectedItemPhotos(context,checkClickValue),
                    ),
                    GestureDetector(
                      onTap:(){
                        setState(() {
                          checkClickValue = "mp3";
                        });
                      },
                      child: checkSelectedItemMP3(context,checkClickValue),
                    ),

                  ],
                ),
              ),
            ),

            Container(color: Colors.grey,child: SizedBox(height: 5,)),

            checkFiles(context,checkClickValue),

          ],
        ),
      ),

    );

  }

  Widget checkSelectedItemVideo(context, String checkClickValue){

    if(checkClickValue == "Video"){

      return new Padding(
        padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 13.0,right: 8.0),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff2154FC),
          ),
          child: Center(
            child: Text('Video',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,

              ),
            ),
          ),
        ),
      );

    }else{

      return new Padding(
        padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 13.0,right: 8.0),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Color(0xff98A5A0),
              width: 1,
            ),
          ),
          child: Center(
            child: Text('Video',
              style: TextStyle(
                color: Color(0xff98A5A0),
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }


  }

  Widget checkSelectedItemPhotos(context, String checkClickValue){

    if(checkClickValue == "Photos"){

      return new Padding(
        padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 13.0,right: 8.0),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff2154FC),
          ),
          child: Center(
            child: Text('Photos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,

              ),
            ),
          ),
        ),
      );

    }else{

      return new Padding(
        padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 13.0,right: 8.0),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Color(0xff98A5A0),
              width: 1,
            ),
          ),
          child: Center(
            child: Text('Photos',
              style: TextStyle(
                color: Color(0xff98A5A0),
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }


  }

  Widget checkSelectedItemMP3(context, String checkClickValue){

    if(checkClickValue == "mp3"){

      return new Padding(
        padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 13.0,right: 8.0),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff2154FC),
          ),
          child: Center(
            child: Text('Mp3 Files',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,

              ),
            ),
          ),
        ),
      );

    }else{

      return new Padding(
        padding: const EdgeInsets.only(top: 16.0,bottom: 16.0,left: 13.0,right: 8.0),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Color(0xff98A5A0),
              width: 1,
            ),
          ),
          child: Center(
            child: Text('Mp3 Files',
              style: TextStyle(
                color: Color(0xff98A5A0),
                fontSize: 14,
              ),
            ),
          ),
        ),
      );
    }


  }

  Widget checkFiles(context, String checkClickValue){

    if(checkClickValue == "Video"){
      if(videos != null){
        return new Column(
          children: [

          ],
        );

      }else{
        return new Container(
          child: Column(
            children: [

              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/novideopic.png'),
              ),
              SizedBox(
                height: Dimensions.height25,
              ),
              Text(
                "No videos found in Downloads",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }

    }else if(checkClickValue == "Photos"){
      if(photoss != null){
        return new  Expanded(
          child: ListView.builder(  //if file/folder list is grabbed, then show here
            itemCount: photoss?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                  child:ListTile(
                    title: Text(photoss[index].path.split('/').last),
                    leading: Icon(Icons.photo),
                    onTap: (){
                      // you can add Play/push code over here
                    },
                  )
              );
            },
          ),
        );
      }else{
        return new Container(
          child: Column(
            children: [

              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/novideopic.png'),
              ),
              SizedBox(
                height: Dimensions.height25,
              ),
              Text(
                "No videos found in Downloads",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }

    }else if(checkClickValue == "mp3"){
      if(files != null){
        return new  Expanded(
          child: ListView.builder(  //if file/folder list is grabbed, then show here
            itemCount: files?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                  child:ListTile(
                    title: Text(files[index].path.split('/').last),
                    leading: Icon(Icons.audiotrack),
                    onTap: (){
                      // you can add Play/push code over here
                    },
                  )
              );
            },
          ),
        );
      }else{
        return new Container(
          child: Column(
            children: [

              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/novideopic.png'),
              ),
              SizedBox(
                height: Dimensions.height25,
              ),
              Text(
                "No videos found in Downloads",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }

    }else{
      return new Container(
        child: Column(
          children: [

            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/novideopic.png'),
            ),
            SizedBox(
              height: Dimensions.height25,
            ),
            Text(
              "No videos found in Downloads",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }


  }



  @override
  void initState() {
    checkClickValue = "Video";
    getFiles();
    getPhotos();//call getFiles() function on initial state.
    getVideos();
    super.initState();
  }

  void getFiles() async { //asyn function to get list of files
    // List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    // var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
    // var fm = FileManager(root: Directory(root)); //
    // files = await fm.filesTree(
    //     excludedPaths: ["/storage/emulated/0/Android"],
    //     extensions: ["mp3"] //optional, to filter files, list only mp3 files
    // );
    // setState(() {}); //update the UI
  }

  void getPhotos() async { //asyn function to get list of files
    // List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    // var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
    // var fm = FileManager(root: Directory(root)); //
    // photoss = await fm.filesTree(
    //     excludedPaths: ["/storage/emulated/0/Android"],
    //     extensions: [".jpg","jpeg","png"] //optional, to filter files, list only mp3 files
    // );
    // setState(() {}); //update the UI
  }

  void getVideos() async { //asyn function to get list of files
    // List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    // var root = storageInfo[0].rootDir; //storageInfo[1] for SD card, geting the root directory
    // var fm = FileManager(root: Directory(root)); //
    // videos = await fm.filesTree(
    //     excludedPaths: ["/storage/emulated/0/Android"],
    //     extensions: ["mp4","mkv","webm"] //optional, to filter files, list only mp3 files
    // );


    // setState(() {}); //update the UI
  }




}
