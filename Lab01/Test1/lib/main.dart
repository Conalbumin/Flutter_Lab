import 'package:flutter/material.dart';

void main() {
  runApp(MyLego());
}

class MyLego extends StatefulWidget {
  @override
  State<MyLego> createState() => _MyLegoState();
}

class _MyLegoState extends State<MyLego> {
  String message = 'Welcome';
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Application'),
        ),
        body: Column(children: [
          Text(
            message,
            textDirection: TextDirection.ltr,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.deepOrange,
            ),
          ),
          ElevatedButton(
              onPressed: () {
               setState(() {
                 count++;
                 message = 'Welcome to Flutter programming ${count}';
                 print('Clicked');
                 print(message);
               });
              },
              child: Text('Click me'))
        ]),
      ),
    );
  }
}
