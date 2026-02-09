import 'package:flutter/material.dart';

final Color primaryColour = Color(0xFFB6E3FF);

Color darken(Color color, [double amount = 0.1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final darkened = hsl.withLightness(
    (hsl.lightness - amount).clamp(0.0, 1.0),
  );

  return darkened.toColor();
}
