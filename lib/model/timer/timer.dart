import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import '/model/colors/colors.dart';

timer(int seconds, double fontSize, Function()? onFinished) {
  return AnimatedTextKit(
      totalRepeatCount: 1,
      onFinished: onFinished,
      pause: const Duration(milliseconds: 0),
      animatedTexts: [
        for (var i = seconds; i > 0; i--)
          RotateAnimatedText(
              (seconds > 59)
                  ? '${i ~/ 60}:${(i % 60 < 10) ? '0' : ''}${i % 60}'
                  : '$i',
              textStyle: TextStyle(
                  fontFamily: 'Changa',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  color: MainColors.mainDarkBrown),
              duration: const Duration(milliseconds: 1000)),
      ]);
}
