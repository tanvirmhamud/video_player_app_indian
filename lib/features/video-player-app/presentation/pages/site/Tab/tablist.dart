import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player_app/features/video-player-app/model/browsertab.dart';

import '../../../../provider/tabbrowser.dart';

class TablistPage extends StatefulWidget {
  const TablistPage({super.key});

  @override
  State<TablistPage> createState() => _TablistPageState();
}

class _TablistPageState extends State<TablistPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Providertabbrowse>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tab",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                // provider.imagecapture();
                provider.addtab(TabData(
                    webview: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse("https://www.google.com")),
                  // initialUrlRequest:
                  // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
                  // initialFile: "assets/index.html",

                  // contextMenu: contextMenu,

                  onWebViewCreated: (controller) async {
                    provider.webViewController = controller;
                    print(await controller.getUrl());
                  },
                  onLoadStop: (controller, url) async {
                    var data = await controller.takeScreenshot();
                    provider.tabdata.last.imagedata = data;
                  },
                  onProgressChanged: (controller, progress) async {
                    if (progress == 100) {
                      // var data = await controller.takeScreenshot();
                      // print("Tanvir $data");
                      // provider.addtab(TabData(imagedata: data!, webview: webview!));
                    }
                  },

                  onConsoleMessage: (controller, consoleMessage) {
                    print(consoleMessage);
                  },
                )));

                provider.changetab(provider.tabdata.length - 1);
                Navigator.pop(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: GridView.builder(
        itemCount: provider.tabdata.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var data = provider.tabdata[index];
          return InkWell(
              onTap: () {
                provider.changetab(index);
                Navigator.pop(context);
              },
              child: Card(
                  child: data.imagedata == null
                      ? Image.asset("assets/icons/BigRectangleSky.png")
                      : Image.memory(data.imagedata!)));
        },
      ),
      // body: Image.memory(provider.imageFile!),
    );
  }
}
