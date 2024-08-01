import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class FlexibleText extends StatelessWidget {
  final String text;
  final double minFontSize;
  final double maxFontSize;
  final FontWeight? fontWeight;
  final Color? colorText;
  final String? fontFamily;

  const FlexibleText({
    super.key,
    required this.text,
    this.minFontSize = 15.0,
    this.maxFontSize = 20.0,
    this.fontWeight,
    this.colorText,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fontSize = maxFontSize;
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        );

        // Reduz o tamanho da fonte até que o texto caiba no espaço disponível
        while (fontSize > minFontSize) {
          textPainter.layout(maxWidth: constraints.maxWidth);
          if (textPainter.didExceedMaxLines) {
            fontSize -= 1;
            textPainter.text = TextSpan(
              text: text,
              style: TextStyle(fontSize: fontSize),
            );
          } else {
            break;
          }
        }

        fontSize = fontSize.clamp(minFontSize, maxFontSize);

        return AutoSizeText(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily ?? 'Poppins',
            color: colorText,
            fontWeight: fontWeight,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        );
      },
    );
  }
}
