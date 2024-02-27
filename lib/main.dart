// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app_flutter/src/config/movie_config.dart';
import 'package:movie_app_flutter/src/widgets/custom_bottom_navbar.dart';

import './src/pages/home_page.dart';
import './src/pages/search.dart';
import './src/pages/movies.dart';
import './src/pages/tv_series.dart';
import './src/pages/profile.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: ColorGet.bg1,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  navigateBottomBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List pages = [
    HomePage(),
    Search(),
    Movies(),
    TvSeries(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: CustomBottomNavbar(
            tabChange: (index) => navigateBottomBar(index),
            currentIndex: _currentIndex),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
