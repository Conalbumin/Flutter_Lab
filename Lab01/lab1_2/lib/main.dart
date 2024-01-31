
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int id = 1;
  bool enableButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('Toggle floating button');
            setState(() {
              enableButton = !enableButton;
            });
          },
        ),
        title: const Text('Flutter Image View'),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: Center(
          child: enableButton
              ? Image.network('https://picsum.photos/250?image=$id')
              : Image.asset('assets/stop.jpeg')),
      floatingActionButton: FloatingActionButton(
        onPressed: enableButton ? () {
          setState(() {
            id++;
            print('Clicked, id = $id');
          });
        } : null,
        child: const Icon(Icons.change_circle),
      ),
    );
  }
}
