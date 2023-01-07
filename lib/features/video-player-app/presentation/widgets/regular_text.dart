import 'package:flutter/material.dart';

import '../Utils/dimenstion.dart';

class RegularText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final TextOverflow overflow;
  final TextAlign alignment;
  final int maxLines;
  const RegularText({
    Key? key,
    required this.text,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.color = Colors.black,
    this.size = 20,
    this.alignment = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: alignment,
      // overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: size == 20 ? Dimensions.font20 : size, color: color),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
