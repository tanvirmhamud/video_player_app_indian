import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player_app/features/video-player-app/model/browsertab.dart';

import '../../../../provider/tabbrowser.dart';
import '../../../Utils/colors.dart';
import '../../../Utils/dimenstion.dart';
import '../../../Utils/icons.dart';
import '../../../widgets/regular_text.dart';
import '../Tab/tablist.dart';
import '../browser_page.dart';
import '../download_page.dart';

class AppBarBrowser extends StatefulWidget with PreferredSizeWidget {
  //const AppBarBrowser({Key? key}) : super(key: key);

  final String url;

  AppBarBrowser({Key? key, required this.url}) : super(key: key);
  @override
  State<AppBarBrowser> createState() => _AppBarBrowserState(url);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarBrowserState extends State<AppBarBrowser> {
  String url;

  _AppBarBrowserState(this.url);

  late TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController(text: '$url');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Providertabbrowse>(context);
    return SafeArea(
      child: Column(children: [
        Container(
          height: Dimensions.height53,
          decoration:
              BoxDecoration(color: AppColors.lightPurple.withOpacity(.2)),
          child: Padding(
            padding: EdgeInsets.only(
                left: Dimensions.width15, right: Dimensions.width15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: Dimensions.width15,
                    width: Dimensions.width15,
                    child: Image.asset(
                      AppIcons.cancelInline,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: Dimensions.height30 + 2,
                  width: Dimensions.height229 + 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.width20),
                    border: Border.all(color: AppColors.redColor),
                  ),
                  child: Center(
                    /* child: RegularText(
                      text: "$url",
                      size: Dimensions.width15 - 2,
                      color: AppColors.greyPurpleColor,
                    ),*/

                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5.0, top: 2.0, right: 5.0, bottom: 0.0),
                      child: TextField(
                        textAlign: TextAlign.start,
                        //controller: _controller,
                        controller: _controller,

                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onSubmitted: (url) {
                          print('Val: $url');

                          if (url.endsWith(".com")) {
                            url = "https://" + url;
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return SiteBrowserPage(url: url);
                            }));
                          } else {
                            url = "https://www.google.com/search?q=" + url;
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return SiteBrowserPage(url: url);
                            }));
                          }
                        },
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (provider.tabdata.isEmpty) {
                      var data =
                          await provider.webViewController!.takeScreenshot();
                      
                      provider.addtab(TabData(
                          imagedata: data!, webview: provider.webview!));
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TablistPage(),
                        ));
                  },
                  child: Container(
                    height: Dimensions.height25,
                    width: Dimensions.height25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    child: Center(
                      child: RegularText(
                        text: "${provider.tabdata.length}",
                        size: Dimensions.font16 - 4,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DownloadsPage()));
                  },
                  child: Container(
                    height: Dimensions.height25,
                    width: Dimensions.height25,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black)),
                    child: Center(
                      child: Image.asset(
                        AppIcons.download,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Icon(Icons.more_vert),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}



/*
class AppBarBrowser extends StatelessWidget with PreferredSizeWidget{

  String url;
  AppBarBrowser(this.url);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Container(
          height: Dimensions.height53,
          decoration:
          BoxDecoration(color: AppColors.lightPurple.withOpacity(.2)),
          child: Padding(
            padding: EdgeInsets.only(
                left: Dimensions.width15, right: Dimensions.width15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: Dimensions.width15,
                  width: Dimensions.width15,
                  child: Image.asset(
                    AppIcons.cancelInline,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: Dimensions.height30 + 2,
                  width: Dimensions.height229 + 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.width20),
                    border: Border.all(color: AppColors.redColor),
                  ),
                  child: Center(
                   *//* child: RegularText(
                      text: "$url",
                      size: Dimensions.width15 - 2,
                      color: AppColors.greyPurpleColor,
                    ),*//*

                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0,top: 2.0,right: 5.0,bottom: 0.0),
                      child: TextField(
                        textAlign: TextAlign.start,
                        //controller: _controller,
                        controller: TextEditingController(text: "$url"),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,

                        ),
                        onSubmitted: (url){
                          print('Val: $url');

                          if(url.endsWith(".com")){
                            url = "https://"+url;
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return SiteBrowserPage(url: url);
                                }));
                          }else{
                            url = "https://www.google.com/search?q="+url;
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                                  return SiteBrowserPage(url: url);
                                }));
                          }


                        },
                      ),
                    ),

                  ),
                ),
                Container(
                  height: Dimensions.height25,
                  width: Dimensions.height25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: Center(
                    child: RegularText(
                      text: "4",
                      size: Dimensions.font16 - 4,
                    ),
                  ),
                ),
                Container(
                  height: Dimensions.height25,
                  width: Dimensions.height25,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)),
                  child: Center(
                    child: Image.asset(
                      AppIcons.download,
                      color: Colors.black,
                    ),
                  ),
                ),
                Icon(Icons.more_vert),
              ],
            ),
          ),
        ),

      ]),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


}*/
