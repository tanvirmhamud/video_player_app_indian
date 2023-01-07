import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/dimenstion.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/images.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/photos/all_photos.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/big_custom_appbar.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';
import 'package:image_picker/image_picker.dart';


class PhotoHomePage extends StatefulWidget {
  const PhotoHomePage({super.key});

  @override
  State<PhotoHomePage> createState() => _PhotoHomePageState();
}

class _PhotoHomePageState extends State<PhotoHomePage> {



  late Future _futureGetPathDownloads,_futureGetPathCam,_futureGetPathScreenshot,_futureGetPathWhatsapp,_futureGetPathFacebook;
  List<dynamic> listImagePathDownload = <dynamic>[],listImagePathSS = <dynamic>[],listImagePathFB = <dynamic>[],listImagePathCam = <dynamic>[],listImagePathWhatsapp = <dynamic>[];
  var _permissionStatus;
  int CountSizeDownloads = 0,CountSizeCam = 0,CountSizeSS = 0,CountSizeWhat = 0,CountSizeFB = 0;

  final List<String> itemList = [
    "Camera",
    "Whatsapp",
    "Screenshots",
    "Facebook",
    "Downloads",
  ];



  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    // Declaring Future object inside initState() method
    // prevents multiple calls inside stateful widget

    _futureGetPathDownloads = _getPathDownloads();
    _futureGetPathCam = _getPathCamera();
    _futureGetPathScreenshot = _getPathScreenShot();
    _futureGetPathFacebook = _getPathFacebook();
    _futureGetPathWhatsapp = _getPathWhatsapp();


  }


  // Check for storage permission
  void _listenForPermissionStatus() async {
    final status = await Permission.storage.request().isGranted;
    // setState() triggers build again
    setState(() => _permissionStatus = status);
  }

  Future<String> _getPathDownloads() {
    return ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  }

  Future<String> _getPathWhatsapp() async {

    Future<String> path = ExternalPath.getExternalStoragePublicDirectory("Android");
    String message = await path;
    String finalPath = message+"/media/com.whatsapp/WhatsApp/Media/WhatsApp Images";
    print("Path is: $finalPath");
    //return ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DCIM);
    return finalPath;
  }

  Future<String> _getPathFacebook() async {

    Future<String> path = ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DCIM);
    String message = await path;
    String finalPath = message+"/Facebook";
    print("Path is: $finalPath");
    //return ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DCIM);
    return finalPath;
  }

  Future<String> _getPathScreenShot() async {

    Future<String> path = ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DCIM);
    String message = await path;
    String finalPath = message+"/Screenshots";
    print("Path is: $finalPath");
    //return ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DCIM);
    return finalPath;
  }

  Future<String> _getPathCamera() async {

    Future<String> path = ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DCIM);
    String message = await path;
    String finalPath = message+"/Camera";
    print("Path is: $finalPath");
    //return ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DCIM);
    return finalPath;
  }



  _fetchFilesDownloads(Directory dir) {
    List<dynamic> listImage = <dynamic>[];
    dir.list().forEach((element) {
      RegExp regExp =
      new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp|jpg|jpeg)", caseSensitive: false);
      // Only add in List if path is an image
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePathDownload = listImage;
        CountSizeDownloads = listImagePathDownload.length;
      });
    });
  }

  _fetchFilesCam(Directory dir) {
    List<dynamic> listImage = <dynamic>[];
    dir.list().forEach((element) {
      RegExp regExp =
      new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp|jpg|jpeg)", caseSensitive: false);
      // Only add in List if path is an image
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePathCam = listImage;
        CountSizeCam = listImagePathCam.length;
      });
    });
  }

  _fetchFilesSS(Directory dir) {
    List<dynamic> listImage = <dynamic>[];
    dir.list().forEach((element) {
      RegExp regExp =
      new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp|jpg|jpeg)", caseSensitive: false);
      // Only add in List if path is an image
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePathSS = listImage;
        CountSizeSS = listImagePathSS.length;
      });
    });
  }

  _fetchFilesFB(Directory dir) {
    List<dynamic> listImage = <dynamic>[];
    dir.list().forEach((element) {
      RegExp regExp =
      new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp|jpg|jpeg)", caseSensitive: false);
      // Only add in List if path is an image
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePathFB = listImage;
        CountSizeFB = listImagePathFB.length;
      });
    });
  }

  _fetchFilesWhats(Directory dir) {
    List<dynamic> listImage = <dynamic>[];
    dir.list().forEach((element) {
      RegExp regExp =
      new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp|jpg|jpeg)", caseSensitive: false);
      // Only add in List if path is an image
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePathWhatsapp = listImage;
        CountSizeWhat = listImagePathWhatsapp.length;
      });
    });
  }

  Widget GetFirstImageFromImagesDownloads(context, List<dynamic> listImagePath){

    File imgPath = listImagePath[0];
    return new Container(
      height: Dimensions.height157 + 8,
      width: Dimensions.height157 + 8,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: FileImage(imgPath),
            // colorFilter:ColorFilter(c),

            fit: BoxFit.fill),
      ),
      child: Icon(
        Icons.image,
        color: Colors.white,
        size: Dimensions.height30 + 5,
      ),
    );

  }

  Widget GetFirstImageFromImagesSS(context, List<dynamic> listImagePath){

    File imgPath = listImagePath[0];
    return new Container(
      height: Dimensions.height157 + 8,
      width: Dimensions.height157 + 8,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: FileImage(imgPath),
            // colorFilter:ColorFilter(c),

            fit: BoxFit.fill),
      ),
      child: Icon(
        Icons.image,
        color: Colors.white,
        size: Dimensions.height30 + 5,
      ),
    );

  }

  Widget GetFirstImageFromImagesFB(context, List<dynamic> listImagePath){

    File imgPath = listImagePath[0];
    return new Container(
      height: Dimensions.height157 + 8,
      width: Dimensions.height157 + 8,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: FileImage(imgPath),
            // colorFilter:ColorFilter(c),

            fit: BoxFit.fill),
      ),
      child: Icon(
        Icons.image,
        color: Colors.white,
        size: Dimensions.height30 + 5,
      ),
    );

  }

  Widget GetFirstImageFromImagesWhatsapp(context, List<dynamic> listImagePath){

    File imgPath = listImagePath[0];
    return new Container(
      height: Dimensions.height157 + 8,
      width: Dimensions.height157 + 8,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            image: FileImage(imgPath),
            // colorFilter:ColorFilter(c),

            fit: BoxFit.fill),
      ),
      child: Icon(
        Icons.image,
        color: Colors.white,
        size: Dimensions.height30 + 5,
      ),
    );

  }

  Widget GetFirstImageFromImages(context, List<dynamic> listImagePath){


    // Check issue of nulling pic
    if(listImagePath.length > 0){
    File imgPath = listImagePath[0];


      return new Container(
        height: Dimensions.height157 + 8,
        width: Dimensions.height157 + 8,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: FileImage(imgPath),
              // colorFilter:ColorFilter(c),

              fit: BoxFit.fill),
        ),
        child: Icon(
          Icons.image,
          color: Colors.white,
          size: Dimensions.height30 + 5,
        ),
      );
    }else{

      return new Container(
        height: Dimensions.height157 + 8,
        width: Dimensions.height157 + 8,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage(
                "assets/images/singer.jpeg",
              ),
              // colorFilter:ColorFilter(c),

              fit: BoxFit.fill),
        ),
        child: Icon(
          Icons.image,
          color: Colors.white,
          size: Dimensions.height30 + 5,
        ),
      );
    }


  }



  Widget PathsCheck(context,int indexx){

    if(indexx == 0)
    {

      return new Center(
        child: Column(
          children: [
            GestureDetector(
            //On CLick By Default
            onTap: () {
      Get.to(AllPhotosPage(indexx));
      print("Index is : $indexx");
      },


        child: FutureBuilder(
          future: _futureGetPathCam,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var dir = Directory(snapshot.data);
              print('permission status: $_permissionStatus');
              if (_permissionStatus)
              {
                _fetchFilesCam(dir);
              }

              return GetFirstImageFromImages(context,listImagePathCam);

            } else {
              return Text("");
            }
          },
        ),
      ),


            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              width: Dimensions.height157 + 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldText(
                    text: itemList[indexx],
                    size: Dimensions.font16,
                  ),
                  RegularText(
                    text: "($CountSizeCam)",
                    size: Dimensions.font16 - 2,
                    color: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      );




    }else if(indexx == 1)
    {
      return new Center(
        child: Column(
          children: [


            GestureDetector(
              //On CLick By Default
              onTap: () {
                Get.to(AllPhotosPage(indexx));
                print("Index is : $indexx");
              },


              child: FutureBuilder(
                future: _futureGetPathWhatsapp,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dir = Directory(snapshot.data);
                    print('permission status: $_permissionStatus');
                    if (_permissionStatus)
                    {
                      _fetchFilesWhats(dir);
                    }

                    return GetFirstImageFromImages(context,listImagePathWhatsapp);

                  } else {
                    return Text("");
                  }
                },
              ),
            ),


            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              width: Dimensions.height157 + 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldText(
                    text: itemList[indexx],
                    size: Dimensions.font16,
                  ),
                  RegularText(
                    text: "($CountSizeWhat)",
                    size: Dimensions.font16 - 2,
                    color: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      );



    }else if(indexx == 2)
    {
      return new Center(
        child: Column(
          children: [


            GestureDetector(
              //On CLick By Default
              onTap: () {
                Get.to(AllPhotosPage(indexx));
                print("Index is : $indexx");
              },


              child: FutureBuilder(
                future: _futureGetPathScreenshot,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dir = Directory(snapshot.data);
                    print('permission status: $_permissionStatus');
                    if (_permissionStatus)
                    {
                      _fetchFilesSS(dir);
                    }


                    return GetFirstImageFromImages(context,listImagePathSS);

                  } else {
                    return Text("");
                  }
                },
              ),
            ),


            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              width: Dimensions.height157 + 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldText(
                    text: itemList[indexx],
                    size: Dimensions.font16,
                  ),
                  RegularText(
                    text: "($CountSizeSS)",
                    size: Dimensions.font16 - 2,
                    color: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      );


    }else if(indexx == 3)
    {
      return new Center(
        child: Column(
          children: [


            GestureDetector(
              //On CLick By Default
              onTap: () {
                Get.to(AllPhotosPage(indexx));
                print("Index is : $indexx");
              },


              child: FutureBuilder(
                future: _futureGetPathFacebook,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dir = Directory(snapshot.data);
                    print('permission status: $_permissionStatus');
                    if (_permissionStatus)
                    {
                      _fetchFilesFB(dir);
                    }


                    return GetFirstImageFromImages(context,listImagePathFB);

                  } else {
                    return Text("");
                  }
                },
              ),
            ),


            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              width: Dimensions.height157 + 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldText(
                    text: itemList[indexx],
                    size: Dimensions.font16,
                  ),
                  RegularText(
                    text: "($CountSizeFB)",
                    size: Dimensions.font16 - 2,
                    color: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      );


    }else if(indexx == 4)
    {
      return new Center(
        child: Column(
          children: [


            GestureDetector(
              //On CLick By Default
              onTap: () {
                Get.to(AllPhotosPage(indexx));
                print("Index is : $indexx");
              },


              child: FutureBuilder(
                future: _futureGetPathDownloads,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dir = Directory(snapshot.data);
                    print('permission status: $_permissionStatus');
                    if (_permissionStatus)
                    {
                      _fetchFilesDownloads(dir);
                    }


                    return GetFirstImageFromImages(context,listImagePathDownload);

                  } else {
                    return Text("");
                  }
                },
              ),
            ),


            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              width: Dimensions.height157 + 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldText(
                    text: itemList[indexx],
                    size: Dimensions.font16,
                  ),
                  RegularText(
                    text: "($CountSizeDownloads)",
                    size: Dimensions.font16 - 2,
                    color: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      );

    }
    else
    {
      return new Center(
        child: Column(
          children: [


            GestureDetector(
              //On CLick By Default
              onTap: () {
                Get.to(AllPhotosPage(indexx));
                print("Index is : $indexx");
              },


              child: FutureBuilder(
                future: _futureGetPathCam,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var dir = Directory(snapshot.data);
                    print('permission status: $_permissionStatus');
                    if (_permissionStatus)
                    {
                      _fetchFilesCam(dir);
                    }

                    return GetFirstImageFromImages(context,listImagePathCam);

                  } else {
                    return Text("");
                  }
                },
              ),
            ),


            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              width: Dimensions.height157 + 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldText(
                    text: itemList[indexx],
                    size: Dimensions.font16,
                  ),
                  RegularText(
                    text: "($CountSizeCam)",
                    size: Dimensions.font16 - 2,
                    color: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      );


    }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigCustomAppBar(
        title: "Photos",
        firstIcon: Icons.search,
        secondIcon: Icons.favorite_outline,
        color: Colors.black,
      ),
      body: GridView.count(
        // crossAxisCount is the number of columns
        crossAxisCount: 2,
        // This creates two columns with two items in each column
        children: List.generate(5, (index) {
          //Check Which path came
          return   PathsCheck(context,index);


        }),
      ),
    );
  }

}
