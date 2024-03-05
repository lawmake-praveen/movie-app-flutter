import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/src/config/movie_config.dart';
import 'package:movie_app_flutter/src/widgets/custom_text.dart';

class PeopleSlider extends StatelessWidget {
  final String title;
  final list;
  const PeopleSlider({super.key, this.title = 'Top Cast', this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        CustomText(
          text: title,
          size: 24,
          weight: FontWeight.w500,
          color: ColorGet.text2,
        ),
        const SizedBox(
          height: 6,
        ),
        CarouselSlider.builder(
            itemCount: list.length,
            itemBuilder: (context, index, realIndex) {
              var movie = list[index];
              return Container(
                margin: const EdgeInsets.only(left: 0, right: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w200${movie['profile_path']}",
                          width: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 150,
                              alignment: Alignment.center,
                              child: Icon(Icons.person, color: ColorGet.icon2,size: 100,));
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      CustomText(
                        text: movie['name'],
                        color: ColorGet.text2,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 14,
                      )
                    ]),
              );
            },
            options: CarouselOptions(viewportFraction: 0.35, height: 230)),
      ],
    );
  }
}
