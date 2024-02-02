import 'package:flutter/material.dart';
import 'dart:math';

class BodyContent extends StatelessWidget {
  final String bodyText;

  BodyContent({required this.bodyText});

  Color _getRandomColor() {
    List<Color> predefinedColors = [
      Colors.blue.shade200,
      Colors.green.shade200,
      Colors.yellow.shade200,
      Colors.pink.shade200,
    ];

    Random random = Random();
    return predefinedColors[random.nextInt(predefinedColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getRandomColor(),
      child: Center(
        child: Text(
          bodyText,
          style: const TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
