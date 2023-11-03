import 'package:flutter/material.dart';

class Style {
  static Color primaryColor = const Color.fromARGB(234, 3, 160, 239);
  static Color lightPrimaryColor = const Color.fromARGB(23, 3, 160, 239);
  static Color greyColor = const Color.fromARGB(255, 219, 221, 226);

  static widthLg(context) {
    return MediaQuery.of(context).size.width * 0.8;
  }

  static widthMd(context) {
    return MediaQuery.of(context).size.width * 0.85;
  }
}
