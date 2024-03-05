import 'package:flutter/material.dart';
import 'package:movie_app_flutter/src/config/movie_config.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final int maxLines;
  final TextAlign? textAlign;
  const CustomText(
      {super.key,
      required this.text,
      this.size = 16,
      this.weight = FontWeight.w500,
      this.color = ColorGet.text2,
      this.maxLines = 2,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
