import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/browsertab.dart';

class Providertabbrowse extends ChangeNotifier {
  List<TabData> tabdata = [];

  void addtab(TabData webview) {
    if (!tabdata.contains(webview)) {
      tabdata.add(webview);
    }

    print("Tanvir ${tabdata.length}");
    notifyListeners();
  }

  // screenshot

  ScreenshotController screenshotController = ScreenshotController();

  Uint8List? imageFile;

  void imagecapture(Uint8List? image) {
    // screenshotController.capture().then((Uint8List? image) {
    //   //Capture Done
    //   imageFile = image;
    //   print(image);
    // }).catchError((onError) {
    //   print(onError);
    // });
    imageFile = image;
    notifyListeners();
  }

  InAppWebViewController? webViewController;
  InAppWebView? webview;

  int tabindex = 0;

  void changetab(int _index) {
    tabindex = _index;
    notifyListeners();
  }
}
