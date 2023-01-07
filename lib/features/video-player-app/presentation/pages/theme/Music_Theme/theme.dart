import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'musictheame.dart';

class MusicThemePage extends StatefulWidget {
  const MusicThemePage({super.key});

  @override
  State<MusicThemePage> createState() => _MusicThemePageState();
}

class _MusicThemePageState extends State<MusicThemePage> {
  List<String> musictheme = [
    "assets/Screenshot 2023-01-07 at 5.35.19 PM.png",
    "assets/Screenshot 2023-01-07 at 5.36.09 PM.png",
    "assets/Screenshot 2023-01-07 at 5.36.46 PM.png",
    "assets/Screenshot 2023-01-07 at 5.40.09 PM.png"
  ];

  var box = Hive.box('theme');

  int selecttheme = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Theme"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 500,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  selecttheme = value;
                });
              },
              itemCount: musictheme.length,
              itemBuilder: (context, index) {
                return Image.asset(musictheme[index]);
              },
            ),
          ),
          MaterialButton(
            color: Colors.indigo,
            onPressed: () {
              setState(() {
                box.put("theme", selecttheme + 1);
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Save Theme")));
            },
            child: Text(
              "Use Theme",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
