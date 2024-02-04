import 'package:flutter/material.dart';

void main() {
  const style = TextStyle(
    color: Colors.red,
    backgroundColor: Colors.yellow,
    fontSize: 25,
    letterSpacing: 5.0
  );

  runApp(
    const Center(
      child: Text(
        'Hello Flutter',
        textDirection: TextDirection.ltr,
        style: style,
      ),
    )
  );
}
