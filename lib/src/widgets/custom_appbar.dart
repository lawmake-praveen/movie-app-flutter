// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, required this.title});

  String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      ),
      backgroundColor: Colors.black,
      centerTitle: true,
    );
  }
}
