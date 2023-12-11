import 'package:flutter/material.dart';

TextStyle changa(
  double size,
  FontWeight contWeight,
  Color color,
) {
  return TextStyle(
    fontSize: size,
    fontFamily: 'Changa',
    fontWeight: contWeight,
    color: color,
  );
}

class OutlinedText extends StatelessWidget {
  final String text;
  final String textFamily;
  final double fontSize;
  final double outlineSize;
  final Color textColor;
  final Color outlineColor;
  final Color shadowColor;

  const OutlinedText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.outlineSize,
    required this.textColor,
    required this.outlineColor,
    required this.shadowColor,
    required this.textFamily,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: textFamily,
      shadows: [
        Shadow(
          color: shadowColor,
          blurRadius: 4,
          offset: const Offset(0, -4),
        )
      ],
      color: textColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
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
