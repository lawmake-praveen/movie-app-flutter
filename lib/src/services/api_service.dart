// ignore_for_file: prefer_const_declarations

import 'dart:convert';

import '../config/movie_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static getHttpInterceptor(context, endPoint) async {
    var returnData = {};
    Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMDA1Y2I0ZDY5ZmE5OTg1ZjJlZjBkZTEwYWZjZWRhMiIsInN1YiI6IjY0YzRhODRkY2FkYjZiMDBlNzVjODZjNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._ctFLh0sU0Bbr0fMeuSE1Gl130BMhqodXBh9eUS5fPg',
    };

    Uri url = Uri.parse(BASE_URL + endPoint);
    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      print("==== result in http interceptor ${response.body}");
      if (response.statusCode == 200) {
        returnData['status'] = true;
        returnData['data'] = jsonDecode(response.body);
      } else {
        print('=== not status code 200 ===');
        returnData['status'] = false;
        returnData['data'] = jsonDecode(response.body);
      }
    } catch (e) {
      print("catch error:: $e");
      returnData['status'] = false;
    }

    return returnData;
  }
}
