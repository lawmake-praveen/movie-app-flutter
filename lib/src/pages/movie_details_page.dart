// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_flutter/src/Controller/movie_controller.dart';
import 'package:movie_app_flutter/src/config/movie_config.dart';
import 'package:movie_app_flutter/src/widgets/custom_button.dart';
import 'package:movie_app_flutter/src/widgets/custom_text.dart';
import 'package:movie_app_flutter/src/widgets/loader.dart';
import 'package:movie_app_flutter/src/widgets/movie_slider.dart';
import 'package:movie_app_flutter/src/widgets/people_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailsPage extends StatefulWidget {
  final movie;
  const MovieDetailsPage({super.key, this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    getMovieData();
    getCredits();
    super.initState();
  }

  var data;
  var credits;
  var actors;
  // var directors;
  var similar;
  var recommended;
  var videos;

  getMovieData() async {
    var result =
        await MovieController.getMovieDetails(context, widget.movie['id']);

    if (result['status']) {
      setState(() {
        data = result['data'];
      });
      getSimilarMovies();
      getRecommendedMovies();
      getMovieVideos();
    } else {
      getMovieData();
    }
  }

  getMovieVideos() async {
    var result =
        await MovieController.getMovieVideos(context, widget.movie['id']);
    print("==== result in view $result");

    if (result['status']) {
      setState(() {
        videos = result['data']['results']
            .where((video) => video['name'].contains("Trailer") == true)
            .take(2)
            .toList();
      });
    } else {
      getMovieVideos();
    }
  }

  getCredits() async {
    var result =
        await MovieController.getMovieCredits(context, widget.movie['id']);

    if (result['status']) {
      setState(() {
        credits = result['data'];
        actors = result['data']['cast']
            .where((cast) =>
                cast['known_for_department'].contains('Acting') == true)
            .take(10)
            .toList();
        // directors = result['data']['cast']
        //     .where((cast) =>
        //         cast['known_for_department'].contains("Directing") == true)
        //     .take(10)
        //     .toList();
      });
    } else {
      getCredits();
    }
  }

  getSimilarMovies() async {
    var result =
        await MovieController.getSimilarMovies(context, widget.movie['id']);
    if (result['status']) {
      setState(() {
        similar = result['data'];
      });
    } else {
      getSimilarMovies();
    }
  }

  getRecommendedMovies() async {
    var result =
        await MovieController.getRecommendedMovies(context, widget.movie['id']);
    if (result['status']) {
      setState(() {
        recommended = result['data'];
      });
    } else {
      getRecommendedMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGet.bg1,
      body: data == null
          ? Loader.loader()
          : data == 'Error'
              ? Center(
                  child: Text(
                    'Something went wrong. Please try again',
                    style: TextStyle(fontSize: 18, color: ColorGet.text2),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight:
                          MediaQuery.of(context).size.width / 500 * 250,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          "https://image.tmdb.org/t/p/w500${widget.movie['backdrop_path']}",
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      backgroundColor: ColorGet.bg1,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: ColorGet.icon2,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.only(bottom: 1000, left: 24, right: 24),
                      child: Column(
                        children: [
                          CustomText(
                            text: widget.movie['title'],
                            color: ColorGet.text2,
                            size: 36,
                          ),
                          CustomText(
                            text: data['tagline'],
                            color: ColorGet.text3,
                            maxLines: 15,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image.network(
                            "https://image.tmdb.org/t/p/w500${widget.movie['poster_path']}",
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 12, right: 12),
                            margin: EdgeInsets.only(top: 8, bottom: 8),
                            decoration: BoxDecoration(
                                color: ColorGet.bg2,
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    CustomText(
                                      text: "${data['runtime'].toString()} min",
                                      color: ColorGet.text1,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    CustomText(
                                        text: data['vote_average']
                                            .toStringAsFixed(2),
                                        color: ColorGet.text1),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.movie,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    CustomText(
                                        text: DateFormat('dd-MMM-yyyy').format(
                                            DateTime.parse(
                                                data['release_date'])),
                                        color: ColorGet.text1),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 4),
                            height: 24,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: data['genres'].length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var genre = data['genres'][index];
                                return Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: CustomText(text: genre['name']));
                              },
                            ),
                          ),
                          CustomText(
                            text: data['overview'],
                            color: ColorGet.text3,
                            textAlign: TextAlign.center,
                            maxLines: 10,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          videos == null
                              ? Container()
                              : CustomButton(
                                  title: 'Watch Trailer',
                                  playIcon: true,
                                  onPressed: () async {
                                    if (await canLaunchUrl(Uri.parse(
                                        'https://www.youtube.com/watch?v=${videos[0]['key']}'))) {
                                      await launchUrl(Uri.parse(
                                          'https://www.youtube.com/watch?v=${videos[0]['key']}'));
                                    } else {
                                      print(
                                          "================== cant open trailer");
                                    }
                                  },
                                ),
                          actors == null
                              ? Loader.loader()
                              : PeopleSlider(
                                  list: actors,
                                ),
                          similar == null
                              ? Loader.loader()
                              : similar['results'].length == 0
                                  ? Container()
                                  : CustomMovieSlider(
                                      left: 0,
                                      title: 'Similar',
                                      data: similar,
                                    ),
                          recommended == null
                              ? Loader.loader()
                              : recommended['results'].length == 0
                                  ? Container()
                                  : CustomMovieSlider(
                                      left: 0,
                                      title: 'Recommended',
                                      data: recommended,
                                    )
                        ],
                      ),
                    ))
                  ],
                ),
    );
  }
}
