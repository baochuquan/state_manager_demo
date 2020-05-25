import 'package:flutter/cupertino.dart';

bool isDark(Color color) {
  final luminence =
  (0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue);
  return luminence < 150;
}
