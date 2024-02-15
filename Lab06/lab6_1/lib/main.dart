import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const MyApp(
        maxScreens: 12,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final int maxScreens;

  const MyApp({Key? key, required this.maxScreens}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Screen ${currentScreen+1}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            top: 100,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                for (int i = 1; i <= widget.maxScreens; i++)
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: 20,
                      width: 50,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          '$i',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Positioned(
            bottom: 26,
            right: 16,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(Icons.skip_next, color: Colors.white, size: 30),
              onPressed: () {
                setState(() {
                  currentScreen = (currentScreen + 1) % widget.maxScreens;
                });
              },
            ),
          ),
          Positioned(
            top: 26,
            left: MediaQuery.of(context).size.width / 2 - 10, // Center horizontally
            child: Text(
              '${currentScreen+1}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),

            ),
          ),
        ],
      ),
    );
  }
}
