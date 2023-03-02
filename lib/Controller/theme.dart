import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class ThemeController extends GetxController {
  var box = Hive.box("theme");

  late Color mainColor = Color(box.get('mainColor') ?? 0xFFF7AF36);
  Color lightPurple = Color(0xFF94A8FF);
  Color blueColor = Color(0xFF416EFF);
  Color skyColor = Color(0xFFebf3fe);
  Color redColor = Color(0xFFFF0000);
  Color lightBlueColor = Color(0xFF597EF7);
  Color darkBlueColor = Color(0xFF2154FC);
  Color purpleColor = Color(0xFF6D44B8);
  Color deepPurpleColor = Color(0xFF678BFF);
  Color greyPurpleColor = Color(0xFF62689B);
  Color redPurpleColor = Color(0xFF7A0398);
  Color startGradient = Color(0xFF597EF7);
  Color endGradient = Color(0xFFFC00FF);
  Color darkGrey = Color(0xFF62689B);
  Color greenAccent = Color(0xFF00D215);
  Color sharpBlue = Color(0xFF2154FC);
  Color purplePure = Color(0xFF9E61FF);
  Color underlineBorder = Color.fromARGB(255, 129, 129, 129);
  Color cursorColor = Color.fromARGB(255, 86, 86, 86);
  Color white = Color.fromARGB(255, 255, 255, 255);

  void setcolor(int colorcode) {
    mainColor = Color(colorcode);
    box.put('mainColor', colorcode);
    update();
  }
}
