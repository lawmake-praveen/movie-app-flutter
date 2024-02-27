// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TvSeries extends StatefulWidget {
  const TvSeries({super.key});

  @override
  State<TvSeries> createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tv'),
    );
  }
}