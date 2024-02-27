import 'package:movie_app_flutter/src/services/api_service.dart';

class MovieController {
  static getMovies(context, type) async {
    var result = await ApiService.getHttpInterceptor(context, 'movie/$type');

    print("---- result in getdata $result");

    return result;
  }
}
