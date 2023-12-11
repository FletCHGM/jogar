import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final double outlineSize;
  final Color textColor;
  final Color outlineColor;
  final Color shadowColor;

  const OutlinedText({
    required this.text,
    required this.fontSize,
    required this.outlineSize,
    required this.textColor,
    required this.outlineColor,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: 'TL',
      shadows: [
        Shadow(
          color: shadowColor,
          blurRadius: 0,
          offset: const Offset(4, 3),
        )
      ],
      color: textColor,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: textStyle.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..color = outlineColor
              ..strokeWidth = outlineSize,
            color: null,
          ),
        ),
        Text(text, textAlign: TextAlign.center, style: textStyle),
      ],
    );
  }
}
