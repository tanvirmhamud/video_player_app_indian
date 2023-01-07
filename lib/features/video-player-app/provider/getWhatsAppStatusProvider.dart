import 'dart:developer';
import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class WhatsAppStatusProvider extends ChangeNotifier {
  List<FileSystemEntity> _getImages = [];
  List<FileSystemEntity> _getVideos = [];

  List<FileSystemEntity> get getImages => _getImages;
  List<FileSystemEntity> get getVideos => _getVideos;

  String path =
      '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses';
  String path2 =
      '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses';

  void requestStoragePermission() async {
    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    //if permission is granted only then show home screen else permission error screen is already shown
    if (result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.manageExternalStorage] == PermissionStatus.granted) {}
  }

  Future getStatus() async {
    final status = await Permission.storage.request();

    if (status.isDenied) {
      log('PermissionDenied');
    }
    if (status.isGranted) {
      final status = await Permission.manageExternalStorage.request();

      if (status.isGranted) {
        final directory = Directory(path);
        if (directory.existsSync() &&
            directory.statSync().type == FileSystemEntityType.directory) {
          var items = await Directory(path)
              .listSync(recursive: false, followLinks: false)
              .where((element) => element is File)
              .toList();
          final items2 = await Directory(path2)
              .listSync(recursive: true, followLinks: false)
              .where((element) => element is File)
              .toList();

          items = items + items2;
          _getImages.clear();
          _getVideos.clear();
          for (var item in items) {
            print(item);
          }
          for (var item in items) {
            if (item.path.endsWith(".jpg")) {
              _getImages.add(item);
            } else if (item.path.endsWith(".mp4")) {
              _getVideos.add(item);
            }
          }
          return items;
        } else {
          return "no data";
        }
      }
    }
  }
}
