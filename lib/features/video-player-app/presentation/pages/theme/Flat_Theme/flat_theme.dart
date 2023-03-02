import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_app/Controller/theme.dart';

import '../../home/home_screen.dart';

class FlatThemePage extends StatefulWidget {
  const FlatThemePage({super.key});

  @override
  State<FlatThemePage> createState() => _FlatThemePageState();
}

class _FlatThemePageState extends State<FlatThemePage> {
  int selectindex = 0;

  List<int> colorlist = [
    0xFF94A8FF,
    0xFF416EFF,
    0xFFebf3fe,
    0xFFFF0000,
    0xFF597EF7,
    0xFF2154FC,
    0xFF6D44B8,
    0xFF678BFF,
    0xFF62689B,
    0xFF7A0398,
    0xFF597EF7,
    0xFFFC00FF,
    0xFF62689B,
    0xFF00D215,
    0xFF2154FC,
    0xFF9E61FF,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<ThemeController>(builder: (controller) {
        return InkWell(
          onTap: () {
            controller.setcolor(colorlist[selectindex]);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: controller.mainColor,
                borderRadius: BorderRadius.circular(100)),
            child: const Text(
              "Use",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }),
      appBar: AppBar(title: const Text("Flat Theme")),
      body: GridView.builder(
        itemCount: colorlist.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectindex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 3,
                      color: selectindex == index
                          ? Colors.red
                          : Colors.transparent)),
              child: Card(
                color: Color(colorlist[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
