import 'package:flutter/material.dart';
import 'package:movie_app_flutter/src/config/movie_config.dart';
import 'package:movie_app_flutter/src/widgets/custom_text.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final bool playIcon;
  final VoidCallback? onPressed;

  const CustomButton(
      {super.key, required this.title, this.playIcon = false, this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: ColorGet.bg2),
        onPressed: widget.onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: widget.title,
              color: ColorGet.text1,
            ),
            if (widget.playIcon)
              const Icon(
                Icons.play_arrow,
                color: ColorGet.icon1,
              )
          ],
        ),
      ),
    );
  }
}
