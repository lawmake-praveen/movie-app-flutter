import 'package:flutter/material.dart';
import 'package:movie_app_flutter/src/config/movie_config.dart';

class Loader {
  static loader() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: ColorGet.border2,
            valueColor: AlwaysStoppedAnimation<Color>(
              ColorGet.border1,
            ),
          )
        ],
      ),
    );
  }

  static loader1(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                backgroundColor: ColorGet.border2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorGet.border1,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
