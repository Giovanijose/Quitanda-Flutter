import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(139, 195, 75, .1),
  100: const Color.fromRGBO(139, 195, 75, .2),
  200: const Color.fromRGBO(139, 195, 75, .3),
  300: const Color.fromRGBO(139, 195, 75, .4),
  400: const Color.fromRGBO(139, 195, 75, .5),
  500: const Color.fromRGBO(139, 195, 75, .6),
  600: const Color.fromRGBO(139, 195, 75, .7),
  700: const Color.fromRGBO(139, 195, 75, .8),
  800: const Color.fromRGBO(139, 195, 75, .9),
  900: const Color.fromRGBO(139, 195, 75, 1),
};

abstract class CustomColors {
  static Color customContrastColor = Colors.red.shade700;

  static MaterialColor customSwatchColor = MaterialColor(0xFF8Bc34A, _swatchOpacity);
}
