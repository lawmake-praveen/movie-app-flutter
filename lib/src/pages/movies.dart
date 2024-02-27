// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          
        ),
      ),
    );
  }
}
