import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/dimenstion.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/images.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/photos/click_photo.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/big_custom_appbar.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/bold_text.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';

import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';


class AllPhotosPage extends StatefulWidget {
  //const AllPhotosPage({super.key});

  int index;

  AllPhotosPage(this.index);

  @override
  State<AllPhotosPage> createState() => _AllPhotosPageState(index);
}

class _AllPhotosPageState extends State<AllPhotosPage> {


  late Future _futureGetPath;
  List<dynamic> listImagePath = <dynamic>[];
  var _permissionStatus;
  int index;


  _AllPhotosPageState(this.index);

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    // Declaring Future object inside initState() method
    // prevents multiple calls inside stateful widget


    // To check which folder is selected
    if(index == 0){
      _futureGetPath = _getPathCamera();
    }else if(index == 1){
      _futureGetPath = _getPathWhatsapp();
    }
    else if(index == 2){
      _futureGetPath = _getPathScreenShot();
    }else if(index == 3){
      _futureGetPath = _getPathFacebook();
    }
    else if(index == 4){
      _futureGetPath = _getPathDownloads();
    }else{

    }

  }




  final List<String> itemList = [
    "Camera",
    "Whatsapp",
    "Screenshots",
    "Facebook",
    "Downloads",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BigCustomAppBar(
        title: "Photos",
        firstIcon: Icons.search,
        secondIcon: Icons.favorite_outline,
        color: Colors.black,
      ),
      /*body: GridView.count(
        // crossAxisCount is the number of columns
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        childAspectRatio: 2 / 1.5,
        // This creates two columns with two items in each column
        children: List.generate(6, (index) {
          return Center(
            child: GestureDetector(
              onTap: () {
                Get.to(ClickPhotoPage());
              },
              child: Container(
                height: Dimensions.height157 + 8,
                width: Dimensions.height157 + 8,
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/singer.jpeg",
                        ),
                        // colorFilter:ColorFilter(c),

                        fit: BoxFit.fill)),
              ),
            ),
          );
        }),
      ),*/

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FutureBuilder(
              future: _futureGetPath,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var dir = Directory(snapshot.data);
                  print('permission status: $_permissionStatus');
                  if (_permissionStatus) _fetchFiles(dir);



                  return Text("");
                } else {
                  return Text("");
                }
              },
            ),
          ),
          Expanded(
            flex: 19,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: _getListImg(listImagePath),
            ),
          )
        ],
      ),
    );
  }



  // Check for storage permission
  void _listenForPermissionStatus() async {
    final status = await Permission.storage.request().isGranted;
    // setState() triggers build again
    setState(() => _permissionStatus = status);
  }

  // Get storage path
  // https://pub.dev/documentation/ext_storage/latest/
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


  _fetchFiles(Directory dir) {
    List<dynamic> listImage = <dynamic>[];
    dir.list().forEach((element) {
      RegExp regExp =
      new RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp|jpg|jpeg)", caseSensitive: false);
      // Only add in List if path is an image
      if (regExp.hasMatch('$element')) listImage.add(element);
      setState(() {
        listImagePath = listImage;
      });
    });
  }

  List<Widget> _getListImg(List<dynamic> listImagePath) {
    List<Widget> listImages = <Widget>[];
    for (var imagePath in listImagePath) {
      listImages.add(
        Material(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
               /* Get.to(ClickPhotoPage());*/

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClickPhotoPage(imagePath)));
              },
              child: Image.file(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
      );
    }
    return listImages;
  }
}
