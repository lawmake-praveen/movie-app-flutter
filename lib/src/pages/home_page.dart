// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/src/Controller/movie_controller.dart';
import 'package:movie_app_flutter/src/config/movie_config.dart';
import 'package:movie_app_flutter/src/pages/movie_details_page.dart';
import 'package:movie_app_flutter/src/widgets/custom_text.dart';
import 'package:movie_app_flutter/src/widgets/loader.dart';
import 'package:movie_app_flutter/src/widgets/movie_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var popularMovies;
  var trendingMovies;

  @override
  void initState() {
    getPopularMovies();
    getTrendingMovies();
    super.initState();
  }

  void getPopularMovies() async {
    var result = await MovieController.getMovies(context, 'popular');
    if (result['status']) {
      setState(() {
        popularMovies = result['data'];
      });
    } else {
      getPopularMovies();
    }
  }

  void getTrendingMovies() async {
    var result = await MovieController.getMovies(context, 'now_playing');
    if (result['status']) {
      setState(() {
        trendingMovies = result['data'];
      });
    } else {
      getTrendingMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGet.bg1,
      body: popularMovies == null
          ? Loader.loader()
          : popularMovies == 'Error'
              ? Center(
                  child: Text(
                    'Something went wrong. Please try again',
                    style: TextStyle(fontSize: 18, color: ColorGet.text2),
                  ),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider.builder(
                            itemCount: popularMovies['results'].length,
                            itemBuilder: (context, index, realIndex) {
                              var movie = popularMovies['results'][index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsPage(movie : movie)));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorGet.bg1,
                                    image: DecorationImage(
                                        alignment: Alignment.topCenter,
                                        image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                                        )),
                                  ),
                                  child: Stack(children: [
                                    Positioned.fill(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                            ColorGet.bg1,
                                            ColorGet.bg1.withOpacity(0)
                                          ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter)),
                                    )),
                                    Positioned(
                                        bottom: 0,
                                        left: 20,
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width -
                                                  40,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: movie['title'],
                                                color: ColorGet.text2,
                                                size: 30,
                                                weight: FontWeight.w600,
                                                maxLines: 1,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              CustomText(
                                                text: movie['overview'],
                                                color: ColorGet.text2,
                                                maxLines: 3,
                                              ),
                                            ],
                                          ),
                                        ))
                                  ]),
                                ),
                              );
                            },
                            options: CarouselOptions(
                                autoPlay: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 500),
                                disableCenter: true,
                                viewportFraction: 1,
                                height:
                                    MediaQuery.of(context).size.width * 1.5)),
                        SizedBox(
                          height: 20,
                        ),
                        CustomMovieSlider(
                            title: 'Trending Movies',
                            data: trendingMovies,
                            targetContent: 'poster_path'),
                        CustomMovieSlider(
                            title: 'Popular Movies',
                            data: popularMovies,
                            targetContent: 'poster_path'),
                        
                      ],
                    ),
                  ),
                ),
    );
  }
}
