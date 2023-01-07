import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:video_player_app/features/video-player-app/model/browsertab.dart';

import 'package:video_player_app/features/video-player-app/presentation/Utils/colors.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/dimenstion.dart';
import 'package:video_player_app/features/video-player-app/presentation/Utils/icons.dart';
import 'package:video_player_app/features/video-player-app/presentation/pages/site/widgets/appBar_browser.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../provider/tabbrowser.dart';

class SiteBrowserPage extends StatefulWidget {
  final String url;

  SiteBrowserPage({Key? key, required this.url}) : super(key: key);

  @override
  State<SiteBrowserPage> createState() => _SiteBrowserPageState();
}

class _SiteBrowserPageState extends State<SiteBrowserPage> {
  // late WebViewController _controller;

  PullToRefreshController? pullToRefreshController;
  final GlobalKey webViewKey = GlobalKey();

  Uint8List? imagedata;
  bool loading = true;

  Future loadtab() async {
    final provider = Provider.of<Providertabbrowse>(context, listen: false);
    provider.changetab(0);
    provider.tabdata.clear();

    provider.webview = InAppWebView(
      key: webViewKey,
      initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
      // initialUrlRequest:
      // URLRequest(url: WebUri(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
      // initialFile: "assets/index.html",

      // contextMenu: contextMenu,
      pullToRefreshController: pullToRefreshController,
      onWebViewCreated: (controller) async {
        provider.webViewController = controller;
        print(await controller.getUrl());
      },
      onLoadStop: (controller, url) async {},
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
    );

    // pullToRefreshController = kIsWeb ||
    //         ![TargetPlatform.iOS, TargetPlatform.android]
    //             .contains(defaultTargetPlatform)
    //     ? null
    //     : PullToRefreshController(
    //         onRefresh: () async {
    //           if (defaultTargetPlatform == TargetPlatform.android) {
    //             webViewController?.reload();
    //           } else if (defaultTargetPlatform == TargetPlatform.iOS ||
    //               defaultTargetPlatform == TargetPlatform.macOS) {
    //             webViewController?.loadUrl(
    //                 urlRequest:
    //                     URLRequest(url: await webViewController?.getUrl()));
    //           }
    //         },
    //       );
    // provider.addtab(WebView(
    //   gestureNavigationEnabled: false,
    //   allowsInlineMediaPlayback: true,
    //   initialUrl: widget.url,
    //   debuggingEnabled: false,
    //   onPageFinished: (url) {
    //     // provider.imagecapture();
    //   },
    //   javascriptMode: JavascriptMode.unrestricted,
    //   onWebViewCreated: (WebViewController webViewController) {

    //     _controller = webViewController;
    //   },
    // ));
  }

  @override
  void initState() {
    // TODO: implement initState
    loadtab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Providertabbrowse>(context);

    return Scaffold(
      appBar: AppBarBrowser(url: widget.url),
      // body: provider.webviewtab[0],
      // body: Image.memory(provider.imageFile!),
      body: provider.tabdata.isEmpty
          ? provider.webview
          : provider.tabdata[provider.tabindex].webview,
    );
  }
}
