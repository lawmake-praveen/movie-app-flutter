import 'package:movie_app_flutter/src/services/api_service.dart';

class MovieController {
  static getMovies(context, type) async {
    var result = await ApiService.getHttpInterceptor(context, 'movie/$type');
    return result;
  }

  static getMovieDetails(context, id) async {
    var result = await ApiService.getHttpInterceptor(context, 'movie/$id');
    return result;
  }

  static getMovieCredits(context, id) async {
    var result = await ApiService.getHttpInterceptor(context, 'movie/$id/credits?language=en-US');
    return result;
  }
  static getSimilarMovies(context, id) async {
    var result = await ApiService.getHttpInterceptor(context, 'movie/$id/similar?language=en-US');
    return result;
  }
  static getRecommendedMovies(context, id) async {
    var result = await ApiService.getHttpInterceptor(context, 'movie/$id/recommendations?language=en-US');
    return result;
  }
  static getMovieVideos(context, id) async {
    var result = await ApiService.getHttpInterceptor(context, 'movie/$id/videos?language=en-US');
    print("=== result in Movie controller : videos : $result");
    return result;
  }
}
