import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TabData {
   Uint8List? imagedata;
   InAppWebView webview;
   TabData({this.imagedata, required this.webview});
}
