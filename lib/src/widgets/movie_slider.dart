// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/src/config/movie_config.dart';
import 'package:movie_app_flutter/src/widgets/custom_text.dart';

class CustomMovieSlider extends StatelessWidget {
  final data;
  final String title;
  final String targetContent;
  final double left;
  const CustomMovieSlider(
      {super.key,
      this.data,
      required this.title,
      this.targetContent = 'poster_path',
      this.left = 20});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: left),
          child: CustomText(
            text: title,
            size: 24,
            weight: FontWeight.w500,
            color: ColorGet.text2,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        CarouselSlider.builder(
            itemCount: data['results'].length,
            itemBuilder: (context, index, realIndex) {
              var movie = data['results'][index];
              return Container(
                margin: EdgeInsets.only(left: 0, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w200${movie[targetContent]}",
                          width: 150,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox(
                              width: 150,
                              height: 192,
                              child: Icon(
                                Icons.local_movies_outlined,
                                size: 120,
                                color: ColorGet.icon2,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      CustomText(
                        text: movie['title'],
                        color: ColorGet.text2,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 14,
                      )
                    ]),
              );
            },
            options: CarouselOptions(viewportFraction: 0.4, height: 300)),
      ],
    );
  }
}
