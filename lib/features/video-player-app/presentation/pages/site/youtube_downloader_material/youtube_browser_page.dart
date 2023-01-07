

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../home_site_page.dart';
import 'downlaoder.dart';

class YoutubeBrowserPage extends StatefulWidget {
  String? data;
  YoutubeBrowserPage({this.data});
  @override
  YoutubeBrowserPageState createState() => YoutubeBrowserPageState();
}

class YoutubeBrowserPageState extends State<YoutubeBrowserPage> {
  final link = "https://www.youtube.com";
  WebViewController? _controller;

  bool _showDownloadButton = false;

  void checkUrl() async {
    if (await _controller!.currentUrl() == "https://m.youtube.com/") {
      setState(() {
        _showDownloadButton = false;
      });
    } else {
      setState(() {
        _showDownloadButton = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    checkUrl();
    return Scaffold(

      body: WebView(
        initialUrl: link,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller){
          setState(() {
            _controller = controller;
          });
        },
      ),

      floatingActionButton: _showDownloadButton == false
          ? Container()
          : FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          final url = await _controller!.currentUrl();
          final title = await _controller!.getTitle();

          ///Download the video
          Download().downloadVideo(url!, "$title");
        },
        child: Icon(Icons.download),
      ),


      );
  }
}