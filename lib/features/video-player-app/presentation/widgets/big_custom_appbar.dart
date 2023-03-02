import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_app/Controller/theme.dart';

import '../Utils/colors.dart';
import '../Utils/dimenstion.dart';
import 'regular_text.dart';

class BigCustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final IconData? firstIcon;
  final IconData? secondIcon;
  final String title;
  final Color? color;
  final Function()? firstIconTap;
  final Function()? secondIconTap;

  const BigCustomAppBar({
    Key? key,
    this.firstIcon,
    this.secondIcon,
    required this.title,
    this.color,
    this.firstIconTap,
    this.secondIconTap,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (controller) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: controller.mainColor,
          ),
        ),
        title: RegularText(
          text: title,
          color: controller.mainColor,
        ),
        actions: [
          SizedBox(
            width: Dimensions.height25,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: firstIconTap,
                child: Icon(
                  firstIcon,
                  color: color,
                  size: Dimensions.height25,
                ),
              ),
              SizedBox(
                width: Dimensions.height15,
              ),
              GestureDetector(
                onTap: secondIconTap,
                child: Icon(
                  secondIcon,
                  color: color,
                  size: Dimensions.height25,
                ),
              ),
              SizedBox(
                width: Dimensions.height15,
              ),
            ],
          ),
        ],
      );
    });
  }
}
