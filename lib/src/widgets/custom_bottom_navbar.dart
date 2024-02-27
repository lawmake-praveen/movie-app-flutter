// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../config/movie_config.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar(
      {super.key, required this.tabChange, required this.currentIndex});

  final void Function(int)? tabChange;
  final int currentIndex;
  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(color: ColorGet.bg1),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorGet.bg1,
          selectedItemColor: ColorGet.icon2,
          unselectedItemColor: ColorGet.icon4,
          currentIndex: widget.currentIndex,
          onTap: (value) => {widget.tabChange!(value)},
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: "Movies",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              label: "TV Series",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ]),
    );
  }
}
