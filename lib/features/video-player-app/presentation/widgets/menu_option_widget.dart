import 'package:flutter/material.dart';
import 'package:video_player_app/features/video-player-app/presentation/widgets/regular_text.dart';

import '../Utils/colors.dart';
import '../Utils/dimenstion.dart';

class MenuOptionsWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final int index;
  final int selectedIndex;
  const MenuOptionsWidget({
    Key? key,
    required this.title,
    this.color,
    required this.index,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 15, right: 15, top: 4, bottom: 4),
      decoration: BoxDecoration(
        color: selectedIndex == index ? AppColors.darkBlueColor : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: selectedIndex == index ? Colors.transparent : Colors.grey),
      ),
      child: Center(
        child: RegularText(
          text: title,
          size: Dimensions.font16 - 1,
          color: selectedIndex == index ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
